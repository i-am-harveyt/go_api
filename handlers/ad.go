package handlers

import (
	"net/http"
	"strings"
	"time"

	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/fiber/v2/log"
	"github.com/lib/pq"

	"github.com/i-am-harveyt/go-ad-service/db"
	"github.com/i-am-harveyt/go-ad-service/models"
	"github.com/i-am-harveyt/go-ad-service/utils"
)

func CreateAd(c *fiber.Ctx) error {
	var req models.CreateAdRequest
	if err := c.BodyParser(&req); err != nil {
		return c.Status(http.StatusBadRequest).JSON(fiber.Map{
			"error": err.Error(),
		})
	}

	if err := validateCreateAdRequest(&req); err != nil {
		return c.Status(http.StatusBadRequest).JSON(fiber.Map{
			"error": err.Error(),
		})
	}

	ad := models.Ad{
		Title:      req.Title,
		StartAt:    req.StartAt,
		EndAt:      req.EndAt,
		Conditions: req.Conditions,
	}

	id, err := insertAd(ad)
	if err != nil {
		return c.Status(http.StatusInternalServerError).JSON(fiber.Map{
			"error": err.Error(),
		})
	}

	return c.Status(http.StatusCreated).JSON(fiber.Map{
		"id": id,
	})
}

func ListAds(c *fiber.Ctx) error {
	var req models.ListAdRequest
	if err := c.QueryParser(&req); err != nil {
		return c.Status(http.StatusBadRequest).JSON(fiber.Map{
			"error": err.Error(),
		})
	}

	ads, err := getActiveAds(&req)
	if err != nil {
		return c.Status(http.StatusInternalServerError).JSON(fiber.Map{
			"error": err.Error(),
		})
	}

	return c.Status(http.StatusOK).JSON(fiber.Map{
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

func insertAd(ad models.Ad) (uint, error) {
	tx, err := db.DB.Begin()

	// insert the ad itself
	queryInsertAd := `
		INSERT INTO public.ad (title, start_at, end_at)
		VALUES ($1, $2, $3) RETURNING id;
	`
	var lastInsertID uint
	err = tx.QueryRow(queryInsertAd,
		ad.Title,
		ad.StartAt,
		ad.EndAt,
	).Scan(&lastInsertID)
	if err != nil {
		tx.Rollback()
		return 0, err
	}

	// insert the conditions
	queryInsertCondition := `
		INSERT INTO public.condition (
			ad_id, age_start, age_end, gender, country, platform
		) VALUES ($1, $2, $3, $4, $5, $6);
	`
	stm, err := tx.Prepare(queryInsertCondition)
	for _, condition := range ad.Conditions {
		log.Info(condition)
		_, err := stm.Exec(
			lastInsertID,
			condition.AgeStart,
			condition.AgeEnd,
			pq.Array(condition.Gender),
			pq.Array(condition.Country),
			pq.Array(condition.Platform),
		)
		if err != nil {
			tx.Rollback()
			return 0, err
		}
	}

	err = tx.Commit()
	return lastInsertID, err
}

func getActiveAds(req *models.ListAdRequest) ([]models.ListedAd, error) {
	now := time.Now()
	query := `
		SELECT title, end_at FROM public.ad A
		INNER JOIN public.condition C ON A.id=C.ad_id
		WHERE ($1 = 0 OR (age_start <= $1 AND $1 <= age_end))
			AND ($2 = ARRAY[]::text[] OR gender IS NULL OR $2 <@ gender)
		  AND ($3 = ARRAY[]::text[] OR country IS NULL OR $3 <@ country)
		  AND ($4 = ARRAY[]::text[] OR platform IS NULL OR $4 <@ platform)
		  AND (start_at <= $5 AND $5 <= end_at)
		ORDER BY end_at ASC
		OFFSET $6 LIMIT $7
	`
	_ = `
	`
	genderArr := pq.Array(strings.Split(req.Gender, ","))
	countryArr := pq.Array(strings.Split(req.Country, ","))
	platformArr := pq.Array(strings.Split(req.Platform, ","))
	log.Info(req.Age, genderArr, countryArr, platformArr)

	rows, err := db.DB.Query(query,
		req.Age,
		genderArr,
		countryArr,
		platformArr,
		now,
		req.Offset, req.Limit,
	)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var ads []models.ListedAd
	for rows.Next() {
		var listAd models.ListedAd
		if err := rows.Scan(&listAd.Title, &listAd.EndAt); err != nil {
			return nil, err
		}
		ads = append(ads, listAd)
	}

	if err := rows.Err(); err != nil {
		return nil, err
	}

	return ads, nil
}
