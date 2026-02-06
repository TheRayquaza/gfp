package api

import (
	"github.com/gin-gonic/gin"
	"srvc-account/src/api/controllers"
	"srvc-account/src/api/middleware"
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
