package models

import (
    "gorm.io/gorm"
    "time"
)

type User struct {
    ID           uint           `json:"id" gorm:"primaryKey"`
    Username     string         `json:"username" gorm:"unique;not null"`
    Email        string         `json:"email" gorm:"unique;not null"`
    PasswordHash string         `json:"-"`
    CreatedAt    time.Time      `json:"created_at"`
    DeletedAt    gorm.DeletedAt `json:"-" gorm:"index"` // Enables Soft Delete
}