package services

import (
    "errors"
	    "os"
    "time"
    "github.com/golang-jwt/jwt/v5"
    "svc-pdb/src/data/database"
    "svc-pdb/src/data/models"
    "golang.org/x/crypto/bcrypt"
)

var jwtSecret = []byte(os.Getenv("JWT_SECRET"))

func GenerateToken(userID uint) (string, error) {
    claims := jwt.MapClaims{
        "user_id": userID,
        "exp":     time.Now().Add(time.Hour * 72).Unix(),
    }
    token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
    return token.SignedString(jwtSecret)
}

func LoginUser(email, password string) (string, error) {
    var user models.User
    
    // 1. Find user by email
    if err := database.DB.Where("email = ?", email).First(&user).Error; err != nil {
        return "", errors.New("invalid email or password")
    }

    // 2. Compare passwords
    err := bcrypt.CompareHashAndPassword([]byte(user.PasswordHash), []byte(password))
    if err != nil {
        return "", errors.New("invalid email or password")
    }

    // 3. Generate JWT (using the helper created earlier)
    token, err := GenerateToken(user.ID)
    if err != nil {
        return "", err
    }

    return token, nil
}