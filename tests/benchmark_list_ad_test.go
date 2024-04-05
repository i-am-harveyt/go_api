package tests

import (
	"net/http/httptest"
	"os"
	"testing"

	"github.com/gofiber/fiber/v2"
	"github.com/i-am-harveyt/go-ad-service/cache"
	"github.com/i-am-harveyt/go-ad-service/db"
	handlers "github.com/i-am-harveyt/go-ad-service/handlers/ad"
)

func Benchmark1(b *testing.B) {
	// setup
	app := fiber.New()
	app.Get("/api/v1/ads/list", handlers.ListAds)
	db.Init(os.Getenv("DATABASE_URL"))
	defer db.DB.Close()
	defer cache.RedisCli.Close()

	// mock request
	req := httptest.NewRequest(
		"GET",
		"/api/v1/ads/list?"+
			"offset=0"+
			"&limit=10"+
			"&age=25"+
			"&gender=F"+
			"&country=TW"+
			"&platform=android",
		nil,
	)
	req.Header.Add("Content-Type", "application/json")

	// send mock request
	b.ResetTimer()
	b.StartTimer()

	for i := 0; i < b.N; i++ {
		app.Test(req)
	}
}
