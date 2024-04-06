package utils

import (
	"errors"
)

var (
	ErrInvalidAge      = errors.New("invalid age")
	ErrInvalidGender   = errors.New("invalid gender")
	ErrInvalidCountry  = errors.New("invalid country")
	ErrInvalidPlatform = errors.New("invalid platform")
	ErrInvalidLimit    = errors.New("limit must be between 1 and 100")
	ErrInvalidOffset   = errors.New("offset must be 0 or greater")
)

