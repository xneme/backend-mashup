package main

import (
	"go-fiber/handlers"

	"github.com/gofiber/fiber/v2"
)


func setupRoutes(app *fiber.App) {
    app.Get("/", handlers.Home)
    app.Get("/users", handlers.ListUsers)
}

