package models

import (
	"fmt"
	"time"
)

type Ad struct {
	ID         uint64      `json:"id"`
	Title      string      `json:"title"`
	StartAt    time.Time   `json:"startAt"`
	EndAt      time.Time   `json:"endAt"`
	Conditions []Condition `json:"conditions"`
}

type ListedAd struct {
	Title string    `json:"title"`
	EndAt time.Time `json:"endAt"`
}

type Condition struct {
	AgeStart uint8    `json:"ageStart"`
	AgeEnd   uint8    `json:"ageEnd"`
	Gender   []string `json:"gender"`
	Country  []string `json:"country"`
	Platform []string `json:"platform"`
}

type CreateAdRequest struct {
	Title      string      `json:"title"`
	StartAt    time.Time   `json:"startAt"`
	EndAt      time.Time   `json:"endAt"`
	Conditions []Condition `json:"conditions"`
}

type ListAdRequest struct {
	Offset   uint64 `json:"offset"`
	Limit    uint64 `json:"limit"`
	Age      uint8  `json:"age"`
	Gender   string `json:"gender"`
	Country  string `json:"country"`
	Platform string `json:"platform"`
}

func (this *ListAdRequest) ToString() string {
	return fmt.Sprintf(
		"Offset:%d; Limit:%d; Age:%d; Gender:%s; Country:%s; Platform:%s",
		this.Offset, this.Limit, this.Age,
		this.Gender, this.Country, this.Platform,
	)
}
