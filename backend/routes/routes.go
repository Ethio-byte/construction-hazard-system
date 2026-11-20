package routes

import (
	"construction-hazard-system/handlers"

	"github.com/gin-gonic/gin"
)

func Register(router *gin.Engine) {
	router.GET("/health", handlers.Health)
}
