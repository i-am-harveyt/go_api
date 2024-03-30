package tests

import (
	"bytes"
	"encoding/json"
	"net/http/httptest"
	"testing"
	"time"

	"github.com/gofiber/fiber/v2"
	"github.com/i-am-harveyt/go-ad-service/models"
)

func TestCreateAd(t *testing.T) {
	app := fiber.New()

	req := models.CreateAdRequest{
		Title:    "Test Ad",
		StartAt:  time.Now(),
		EndAt:    time.Now().Add(24 * time.Hour),
		AgeStart: uint8Ptr(20),
		AgeEnd:   uint8Ptr(30),
		Gender:   []string{"M", "F"},
		Country:  []string{"TW", "JP"},
		Platform: []string{"android", "ios"},
	}

	body, err := json.Marshal(req)
	if err != nil {
		t.Errorf("failed to marshal request body: %v", err)
	}

	resp, err := app.Test(httptest.NewRequest("POST", "/api/v1/ads", bytes.NewReader(body)))
	if err != nil {
		t.Errorf("failed to create ad: %v", err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != fiber.StatusCreated {
		t.Errorf("expected status code %d, got %d", fiber.StatusCreated, resp.StatusCode)
	}

	// Add more test cases for invalid requests, etc.
}

func TestListAds(t *testing.T) {
	app := fiber.New()

	resp, err := app.Test(httptest.NewRequest("GET", "/api/v1/ads/list?offset=0&limit=10&age=25&gender=M&country=TW&platform=android", nil))
	if err != nil {
		t.Errorf("failed to list ads: %v", err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != fiber.StatusOK {
		t.Errorf("expected status code %d, got %d", fiber.StatusOK, resp.StatusCode)
	}

	// Add more test cases for invalid requests, pagination, etc.
}

func uint8Ptr(v uint8) *uint8 {
	return &v
}
