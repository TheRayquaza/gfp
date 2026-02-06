package api

import (
    "svc-pdb/src/api/controllers"
    "github.com/gin-gonic/gin"
)

func SetupRouter() *gin.Engine {
    r := gin.Default()
    
    r.POST("/api/register", controllers.Register)
    r.POST("/api/login", controllers.Login)

    authorized := r.Group("/api")
    authorized.Use(middleware.AuthRequired())
    {
        authorized.GET("/account", controllers.GetAccount)
        authorized.DELETE("/account", controllers.DeleteAccount)
    }
    
    return r
}