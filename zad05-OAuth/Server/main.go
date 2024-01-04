package main

import (
	"Server/controllers"
	"github.com/labstack/echo/v4"
)

func main() {
	e := echo.New()

	userController := controllers.UserController{}
	e.GET("/login", userController.Login)
	e.POST("/register", userController.Register)

	err := e.Start(":8080")
	if err != nil {
		return
	}
}
