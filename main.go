package main

import (
	"log"
	"os"
	"time"

	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/fiber/v2/middleware/limiter"

	"github.com/i-am-harveyt/go-ad-service/cache"
	"github.com/i-am-harveyt/go-ad-service/db"
	"github.com/i-am-harveyt/go-ad-service/routes"
)

func main() {
	// Load environment variables
	dataSourceName := os.Getenv("DATABASE_URL")
	if dataSourceName == "" {
		log.Fatal("DATABASE_URL environment variable is not set")
	}

	// Initialize the database connection
	db.Init(dataSourceName)
	defer db.DB.Close()

	defer cache.RedisCli.Close()

	// Create a new Fiber app
	app := fiber.New()
	app.Get("/ping", func(c *fiber.Ctx) error { return c.JSON(fiber.Map{"message": "pong"}) })

	// setup rate limiter
	app.Use(limiter.New(
		limiter.Config{
			Max:               10,
			Expiration:        30 * time.Second,
			LimiterMiddleware: limiter.SlidingWindow{},
			KeyGenerator:      func(c *fiber.Ctx) string { return c.Get("x-forwarded-for") },
			LimitReached: func(c *fiber.Ctx) error {
				return c.
					Status(fiber.StatusTooManyRequests).
					JSON(fiber.Map{"message": "Too many requests, please try later"})
			},
		},
	))

	// Set up routes
	routes.Setup(app)

	// Start the server
	log.Fatal(app.Listen(":3000"))
}
