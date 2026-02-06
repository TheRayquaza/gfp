package main

import (
	"log"
	"srvc-pdb/src/api"
	"srvc-pdb/src/config"
	"srvc-pdb/src/data/database"
)

func main() {
	cfg := config.LoadConfig()

	if err := database.InitRedis(cfg.RedisAddr); err != nil {
		log.Fatalf("Fatal: Could not connect to Redis at %s: %v", cfg.RedisAddr, err)
	}
	log.Printf("Connected to Redis at %s", cfg.RedisAddr)

	r := api.SetupRouter()

	log.Printf("Server starting on host %s and port %s", cfg.ServerHost, cfg.ServerPort)
	if err := r.Run(cfg.ServerHost + ":" + cfg.ServerPort); err != nil {
		log.Fatal(err)
	}
}
