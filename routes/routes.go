package routes

import (
	"github.com/gofiber/fiber/v2"
	"github.com/i-am-harveyt/go-ad-service/handlers"
)

func Setup(app *fiber.App) {
	api := app.Group("/api/v1")
	ad := api.Group("/ad")
	ad.Get("/ping", func(c *fiber.Ctx) error { return c.JSON(fiber.Map{"message": "/ad ping"}) })

	ad.Post("/", handlers.CreateAd)
	ad.Get("/", handlers.ListAds)
}
