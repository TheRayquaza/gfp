package main

import (
	"srvc-account/src/api"
	"srvc-account/src/config"
	"srvc-account/src/data/database"
)

func main() {
	cfg := config.LoadConfig()
	database.InitDB(cfg)
	r := api.SetupRouter(cfg.JWTSecret)
	r.Run(cfg.ServerHost + ":" + cfg.ServerPort)
}
