package tests

import (
	"bytes"
	"encoding/json"
	"io"
	"net/http/httptest"
	"os"
	"testing"

	"github.com/gofiber/fiber/v2"
	"github.com/i-am-harveyt/go-ad-service/cache"
	"github.com/i-am-harveyt/go-ad-service/db"
	handlers "github.com/i-am-harveyt/go-ad-service/handlers/ad"
	"github.com/i-am-harveyt/go-ad-service/models"
)

func readJSONFile() ([]models.CreateAdRequest, error) {
	filePath := "./gen_data/test_data.json"
	file, err := os.Open(filePath)
	if err != nil {
		return nil, err
	}
	defer file.Close()

	data, err := io.ReadAll(file)
	if err != nil {
		return nil, err
	}

	var ads []models.CreateAdRequest
	err = json.Unmarshal(data, &ads)
	if err != nil {
		return nil, err
	}
	return ads, nil
}

func Benchmark2(b *testing.B) {
	b.StopTimer()
	// setup
	app := fiber.New(
		fiber.Config{
			Prefork: true,
		},
	)
	app.Post("/api/v1/ad", handlers.CreateAd)
	db.Init(os.Getenv("DATABASE_URL"))
	defer db.DB.Close()
	defer cache.RedisCli.Close()

	// prepare test data
	ads, err := readJSONFile()
	if err != nil {
		b.Errorf("failed to marshal request body: %v", err)
	}
	body, err := json.Marshal(ads[0])

	// mock request
	req := httptest.NewRequest(
		"POST",
		"/api/v1/ad",
		bytes.NewReader(body),
	)
	req.Header.Add("Content-Type", "application/json")

	// send mock request
	b.StartTimer()

	for i := 0; i < b.N; i++ {
		resp, err := app.Test(req)
		if err != nil {
			b.StopTimer()
			b.Error(err.Error())
			return
		} else if resp.StatusCode != fiber.StatusCreated {
			b.StopTimer()
			b.Error(resp.StatusCode)
			b.Error(resp.Header)
			return
		}
	}

	b.StopTimer()
}
