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
	AgeStart uint8    `json:"ageStart" validate:"min=1,max=100"`
	AgeEnd   uint8    `json:"ageEnd"   validate:"min=1,max=100"`
	Gender   []string `json:"gender"   validate:"dive,oneof=M F"`
	Country  []string `json:"country"  validate:"dive,iso3166_1_alpha2"`
	Platform []string `json:"platform" validate:"dive,oneof=android ios web"`
}

type CreateAdRequest struct {
	Title      string      `json:"title"`
	StartAt    time.Time   `json:"startAt"`
	EndAt      time.Time   `json:"endAt"`
	Conditions []Condition `json:"conditions"`
}

type ListAdRequest struct {
	Offset   uint8  `json:"offset"   validate:"min=0"`
	Limit    uint8  `json:"limit"    validate:"required,min=0,max=100"` // since fiber's default=0, allow 0 here
	Age      uint8  `json:"age"      validate:"min=0,max=100"`
	Gender   []string `validate:"dive,oneof=M F"`
	Country  []string `validate:"dive,iso3166_1_alpha2"`
	Platform []string `validate:"dive,oneof=android ios web"`
}

func (this *ListAdRequest) ToString() string {
	return fmt.Sprintf(
		"Offset:%d; Limit:%d; Age:%d; Gender:%s; Country:%s; Platform:%s",
		this.Offset, this.Limit, this.Age,
		this.Gender, this.Country, this.Platform,
	)
}
