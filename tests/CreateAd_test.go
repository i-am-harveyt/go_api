package tests

import (
	"bytes"
	"encoding/json"
	"io"
	"net/http/httptest"
	"os"
	"testing"

	"github.com/gofiber/fiber/v2"
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

func TestCreateAd(t *testing.T) {
	app := fiber.New()
	app.Post("/api/v1/ad/", handlers.CreateAd)
	db.Init(os.Getenv("DATABASE_URL"))

	ads, err := readJSONFile()
	if err != nil {
		t.Errorf("failed to marshal request body: %v", err)
	}

	for _, ad := range ads {
		body, err := json.Marshal(ad)
		if err != nil {
			t.Errorf("failed to parse ad: %v", err)
		}

		req := httptest.NewRequest(
			"POST",
			"/api/v1/ad/",
			bytes.NewReader(body),
		)
		req.Header.Add("Content-Type", "application/json")

		resp, err := app.Test(req)
		if err != nil {
			t.Errorf("failed to create ad: %v", err)
		}
		defer resp.Body.Close()

		if resp.StatusCode != fiber.StatusCreated {
			t.Error(resp.Body)
			return
		}
	}
}
