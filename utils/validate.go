package utils

import "github.com/go-playground/validator/v10"

type (
	CustomValidator struct {
		v *validator.Validate
	}

	Error struct {
		Field string
		Tag   string
		Value interface{}
	}
)

func (cv *CustomValidator) Validate(data interface{}) []Error {
	validationErrors := []Error{}

	if errs := validate.Struct(data); errs != nil {
		for _, err := range errs.(validator.ValidationErrors) {
			validationErrors = append(
				validationErrors,
				Error{
					Field: err.Field(),
					Tag:   err.Tag(),
					Value: err.Value(),
				},
			)
		}
	}

	return validationErrors
}

var (
	validate  = validator.New()
	Validator = CustomValidator{
		v: validate,
	}
)
