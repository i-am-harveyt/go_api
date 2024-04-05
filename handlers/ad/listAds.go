package handlers

import (
	"encoding/json"
	"slices"
	"strings"
	"time"

	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/fiber/v2/log"
	"github.com/lib/pq"
	"github.com/redis/go-redis/v9"

	"github.com/i-am-harveyt/go-ad-service/cache"
	"github.com/i-am-harveyt/go-ad-service/db"
	"github.com/i-am-harveyt/go-ad-service/models"
	"github.com/i-am-harveyt/go-ad-service/utils"
)

// To list the ads given some query params
func ListAds(c *fiber.Ctx) error {
	// validate the request
	var req models.ListAdRequest
	if err := c.QueryParser(&req); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"error": err.Error(),
		})
	}
	// default limit is 5
	if req.Limit == 0 {
		req.Limit = 5
	}

	queryString := req.ToString()
	log.Info(queryString)

	// to see if cache hits
	val, err := cache.RedisCli.Get(cache.RedisCtx, queryString).Result()
	if err != nil && err != redis.Nil { // some other error
		log.Error(err.Error())
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"error": err.Error(),
		})
	} else if err != redis.Nil { // key in redis, i.e. cache hit
		log.Infof("[HIT] val: %s", val)
		var ads []models.ListedAd
		err := json.Unmarshal([]byte(val), &ads)
		if err != nil {
			return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
				"error": err.Error(),
			})
		}

		return c.Status(fiber.StatusOK).JSON(fiber.Map{
			"items": ads,
		})
	}

	// fetch data from database
	ads, err := getActiveAds(&req)
	log.Info(ads)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"error": err.Error(),
		})
	}

	// write into cache
	adsString, err := json.Marshal(ads)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"error": err.Error(),
		})
	}
	if err = cache.RedisCli.Set(
		cache.RedisCtx,
		queryString,
		adsString,
		5*time.Minute).Err(); err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"error": err.Error(),
		})
	}

	return c.Status(fiber.StatusOK).JSON(fiber.Map{
		"items": ads,
	})
}

func validateCreateAdRequest(req *models.CreateAdRequest) error {
	for _, condition := range req.Conditions {
		if err := utils.ValidateAge(condition.AgeStart); err != nil {
			return err
		}

		if err := utils.ValidateAge(condition.AgeEnd); err != nil {
			return err
		}

		for _, gender := range condition.Gender {
			if err := utils.ValidateGender(gender); err != nil {
				return err
			}
		}

		for _, country := range condition.Country {
			if err := utils.ValidateCountry(country); err != nil {
				return err
			}
		}

		for _, platform := range condition.Platform {
			if err := utils.ValidatePlatform(platform); err != nil {
				return err
			}
		}
	}

	return nil
}

func reqFieldToArray(s string) []string {
	return slices.DeleteFunc(
		strings.Split(s, ","),
		func(s string) bool { return s == "" },
	)
}

func getActiveAds(req *models.ListAdRequest) ([]models.ListedAd, error) {
	query := `
		SELECT A.id, A.title, A.end_at FROM public.ad A
		INNER JOIN public.condition C ON A.id=C.ad_id
		WHERE ($1 = 0 OR $1 BETWEEN C.age_start AND c.age_end)
			AND (array_length($2::text[], 1)=0 OR gender IS NULL OR $2 <@ gender)
			AND (array_length($3::text[], 1)=0 OR country IS NULL OR $3 <@ country)
			AND (array_length($4::text[], 1)=0 OR platform IS NULL OR $4 <@ platform)
			AND ((NOW() BETWEEN start_at AND end_at) OR 1=1)
		GROUP BY A.id
		ORDER BY end_at ASC
		OFFSET $5 LIMIT $6
	`
	genderArr := reqFieldToArray(req.Gender)
	countryArr := reqFieldToArray(req.Country)
	platformArr := reqFieldToArray(req.Platform)

	rows, err := db.DB.Query(query,
		req.Age,
		pq.StringArray(genderArr),
		pq.StringArray(countryArr),
		pq.StringArray(platformArr),
		req.Offset,
		req.Limit,
	)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var ads []models.ListedAd
	for rows.Next() {
		var listAd models.ListedAd
		var dummyId uint
		if err := rows.Scan(&dummyId, &listAd.Title, &listAd.EndAt); err != nil {
			return nil, err
		}
		ads = append(ads, listAd)
	}

	if err := rows.Err(); err != nil {
		return nil, err
	}

	return ads, nil
}
