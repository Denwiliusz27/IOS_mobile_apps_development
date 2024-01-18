package main

import (
	"Server/controllers"
	"github.com/labstack/echo/v4"
)

func main() {
	e := echo.New()

	paymentController := controllers.PaymentController{}
	e.POST("/pay", paymentController.Pay)

	err := e.Start(":8080")
	if err != nil {
		return
	}
}
