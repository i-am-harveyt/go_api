package handlers

import (
	"fmt"

	"github.com/gofiber/fiber/v2"

	"github.com/lib/pq"

	"github.com/i-am-harveyt/go-ad-service/db"
	"github.com/i-am-harveyt/go-ad-service/models"
	"github.com/i-am-harveyt/go-ad-service/utils"
)

func CreateAd(c *fiber.Ctx) error {
	var req models.CreateAdRequest
	if err := c.BodyParser(&req); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"error": err.Error(),
		})
	}

	if errs := utils.Validator.Validate(req); len(errs) > 0 {
		return c.Status(fiber.StatusForbidden).JSON(
			fiber.Map{
				"error": fmt.Sprintf(
					"Input Invalid: Field=%s; Tag=%s; Value=%s;",
					errs[0].Field,
					errs[0].Tag,
					errs[0].Value,
				),
			},
		)
	}

	ad := models.Ad{
		Title:      req.Title,
		StartAt:    req.StartAt,
		EndAt:      req.EndAt,
		Conditions: req.Conditions,
	}

	for _, cond := range ad.Conditions {
		if errs := utils.Validator.Validate(cond); len(errs) > 0 {
			return c.Status(fiber.StatusForbidden).JSON(
				fiber.Map{
					"error": fmt.Sprintf(
						"Input Invalid: Field=%s; Tag=%s; Value=%s;",
						errs[0].Field,
						errs[0].Tag,
						errs[0].Value,
					),
				},
			)
		}
	}

	id, err := insertAd(ad)
	if err != nil {
		return c.Status(
			fiber.StatusInternalServerError,
		).JSON(
			fiber.Map{
				"error": err.Error(),
			},
		)
	}

	return c.Status(fiber.StatusCreated).JSON(fiber.Map{
		"id": id,
	})
}

func insertAd(ad models.Ad) (uint, error) {
	tx, err := db.DB.Begin()

	// insert the ad itself with trancsaction
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

	// insert the conditions with transactions and bulk insert
	queryInsertCondition := `
		INSERT INTO public.condition (
			ad_id, age_start, age_end, gender, country, platform
		) VALUES ($1, $2, $3, $4, $5, $6);
	`
	stm, err := tx.Prepare(queryInsertCondition)
	for _, condition := range ad.Conditions {
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
