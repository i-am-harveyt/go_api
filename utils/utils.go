package utils

import "errors"

var (
	ErrInvalidAge      = errors.New("invalid age")
	ErrInvalidGender   = errors.New("invalid gender")
	ErrInvalidCountry  = errors.New("invalid country")
	ErrInvalidPlatform = errors.New("invalid platform")
	ErrInvalidLimit    = errors.New("limit must be between 1 and 100")
	ErrInvalidOffset   = errors.New("offset must be 0 or greater")
)

func ValidateAge(age uint8) error {
	if age < 1 || age > 100 {
		return ErrInvalidAge
	}
	return nil
}

func ValidateGender(gender string) error {
	if gender != "M" && gender != "F" && gender != "" {
		return ErrInvalidGender
	}
	return nil
}

func ValidateCountry(country string) error {
	// You can add a list of valid countries here
	if country != "TW" && country != "JP" && country != "" {
		return ErrInvalidCountry
	}
	return nil
}

func ValidatePlatform(platform string) error {
	if platform != "android" && platform != "ios" && platform != "web" && platform != "" {
		return ErrInvalidPlatform
	}
	return nil
}

func ValidateLimit(limit uint64) error {
	if limit < 1 || limit > 100 {
		return ErrInvalidLimit
	}
	return nil
}

func ValidateOffset(offset uint64) error {
	if offset < 0 {
		return ErrInvalidOffset
	}
	return nil
}
