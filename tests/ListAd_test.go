package tests

import (
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

func TestBasicCase(t *testing.T) {
	// setup
	app := fiber.New()
	app.Get("/api/v1/ads/list", handlers.ListAds)
	db.Init(os.Getenv("DATABASE_URL"))

	// mock request
	req := httptest.NewRequest(
		"GET",
		"/api/v1/ads/list?"+
			"offset=0"+
			"&limit=10"+
			"&age=25"+
			"&gender=F,M"+
			"&country=TW,JP"+
			"&platform=android",
		nil,
	)
	req.Header.Add("Content-Type", "application/json")

	// send mock request
	resp, err := app.Test(req)
	if err != nil {
		t.Errorf("failed to list ads: %v", err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != fiber.StatusOK {
		t.Error(resp.Body)
		t.Log(resp)
	}

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		t.Error(resp.Body)
		t.Log(resp)
	} else {
		var bodyData map[string][]models.ListedAd
		if err := json.Unmarshal(body, &bodyData); err != nil {
			t.Error("CANNOT UNMARSHAL")
		} else {
			t.Log(bodyData["items"])
		}
	}
}

func TestInvalidParam(t *testing.T) {
	// setup
	app := fiber.New()
	app.Get("/api/v1/ads/list", handlers.ListAds)
	db.Init(os.Getenv("DATABASE_URL"))
	// mock request
	req := httptest.NewRequest(
		"GET",
		"/api/v1/ads/list?"+
			"offset=100"+
			"&limit=10"+
			"&age=25"+
			"&gender=S"+
			"&country=TW"+
			"&platform=android",
		nil,
	)
	req.Header.Add("Content-Type", "application/json")

	// send mock request
	resp, err := app.Test(req)
	if err != nil {
		t.Errorf("failed to list ads: %v", err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != fiber.StatusOK {
		t.Error(resp.StatusCode)
	}

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		t.Error(err.Error())
	} else {
		var bodyData map[string]string
		if err := json.Unmarshal(body, &bodyData); err != nil {
			t.Error("CANNOT UNMARSHAL")
		} else {
			t.Log(bodyData["error"])
		}
	}
}

func TestNoParams(t *testing.T) {
	// setup
	app := fiber.New()
	app.Get("/api/v1/ads/list", handlers.ListAds)
	db.Init(os.Getenv("DATABASE_URL"))
	// mock request
	req := httptest.NewRequest("GET", "/api/v1/ads/list", nil)
	req.Header.Add("Content-Type", "application/json")

	// send mock request
	resp, err := app.Test(req)
	if err != nil {
		t.Errorf("failed to list ads: %v", err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != fiber.StatusOK {
		t.Error(resp.StatusCode)
	}

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		t.Error(err.Error())
	} else {
		var bodyData map[string][]models.ListedAd
		if err := json.Unmarshal(body, &bodyData); err != nil {
			t.Error("CANNOT UNMARSHAL")
		} else {
			t.Log(bodyData["items"])
		}
	}
}
