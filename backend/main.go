package main

import (
	"log"

	"construction-hazard-system/database"
	"construction-hazard-system/routes"

	"github.com/gin-gonic/gin"
)

func main() {
	// Connect to PostgreSQL.
	db, err := database.Connect()
	if err != nil {
		log.Fatal("Database connection failed: ", err)
	}
	defer db.Close()

	log.Println("Successfully connected to PostgreSQL!")

	// Create the Gin router.
	router := gin.Default()

	// Register API routes.
	routes.Register(router)

	// Start the server.
	if err := router.Run(":8080"); err != nil {
		log.Fatal("Server failed to start: ", err)
	}
}
