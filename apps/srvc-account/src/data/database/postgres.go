package database

import (
	"fmt"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"log"

	"srvc-account/src/config"
	"srvc-account/src/data/models"
)

var DB *gorm.DB

func InitDB(config *config.Config) {
	dsn := fmt.Sprintf("host=%s user=%s password=%s dbname=%s port=%s sslmode=disable",
		config.DBHost, config.DBUser, config.DBPassword, config.DBName, config.DBPort)

	var err error
	DB, err = gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		log.Fatal("Failed to connect to database:", err)
	}

	// Auto-migrate the schema
	DB.AutoMigrate(&models.User{})
}
