package handlers

import (
	"go-fiber/database"
	"go-fiber/models"

	"github.com/gofiber/fiber/v2"
)

func Home(c *fiber.Ctx) error {
        return c.SendString("Backend mashup: Go/Fiber edition!")
}

func ListUsers(c *fiber.Ctx) error {
    users := []models.User{}
    database.DB.Db.Find(&users)

    return c.Status(200).JSON(users)
}

