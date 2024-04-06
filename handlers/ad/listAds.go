package handlers

import (
	"encoding/json"
	"slices"
	"strings"
	"time"

	"github.com/gofiber/fiber/v2"
	"github.com/lib/pq"
	"github.com/redis/go-redis/v9"

	"github.com/i-am-harveyt/go-ad-service/cache"
	"github.com/i-am-harveyt/go-ad-service/db"
	"github.com/i-am-harveyt/go-ad-service/models"
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

	// to see if cache hits
	val, err := cache.RedisCli.Get(cache.RedisCtx, queryString).Result()
	if err != nil && err != redis.Nil { // some other error
		// log.Error(err.Error())
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"error": err.Error(),
		})
	} else if err != redis.Nil { // key in redis, i.e. cache hit
		// log.Infof("[HIT] val: %s", val)
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
	// log.Info(ads)
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

func reqFieldToArray(s string) []string {
	return slices.DeleteFunc(
		strings.Split(s, ","),
		// splitting "" will get {""}, remove 'em
		func(s string) bool { return s == "" },
	)
}

func getActiveAds(req *models.ListAdRequest) ([]models.ListedAd, error) {
	query := `
		SELECT DISTINCT A.id, A.title, A.end_at
		FROM public.ad A
		INNER JOIN public.condition C ON A.id=C.ad_id
		WHERE ($1 = 0 OR $1 BETWEEN C.age_start AND C.age_end)
			AND (C.gender IS NULL OR $2 <@ C.gender)
			AND (C.country IS NULL OR $3 <@ C.country)
			AND (C.platform IS NULL OR $4 <@ C.platform)
			AND ((NOW() BETWEEN A.start_at AND A.end_at) OR 1=1)
		ORDER BY A.end_at ASC
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
		if err := rows.Scan(
			&dummyId,
			&listAd.Title,
			&listAd.EndAt,
		); err != nil {
			return nil, err
		}
		ads = append(ads, listAd)
	}

	if err := rows.Err(); err != nil {
		return nil, err
	}

	return ads, nil
}
