package main

import (
	"log"
	"os"

	"github.com/gofiber/fiber/v2"
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

	// Create a new Fiber app
	app := fiber.New()
	app.Get("/ping", func(c *fiber.Ctx) error { return c.JSON(fiber.Map{"message": "pong"}) })

	// Set up routes
	routes.Setup(app)

	// Start the server
	log.Fatal(app.Listen(":3000"))
}
