package services

import (
    "svc-pdb/src/data/database"
    "svc-pdb/src/data/models"
    "golang.org/x/crypto/bcrypt"
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
