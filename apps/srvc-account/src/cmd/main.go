package main

import (
    "svc-pdb/src/api"
    "svc-pdb/src/data/database"
)

func main() {
    database.InitDB()
    r := api.SetupRouter()
    r.Run(":8080")
}
