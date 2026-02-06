package services

import (
	"golang.org/x/crypto/bcrypt"
	"srvc-account/src/data/database"
	"srvc-account/src/data/models"
)

func RegisterUser(username, email, password string) (*models.User, error) {
	hashedPassword, _ := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)

	user := &models.User{
		Username:     username,
		Email:        email,
		PasswordHash: string(hashedPassword),
	}

	if err := database.DB.Create(user).Error; err != nil {
		return nil, err
	}

	return user, nil
}
