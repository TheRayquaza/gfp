package main

import (
	"srvc-account/src/api"
	"srvc-account/src/data/database"
)

func main() {
	database.InitDB()
	r := api.SetupRouter()
	r.Run(":8080")
}
