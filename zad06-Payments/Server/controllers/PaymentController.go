package controllers

import (
	"fmt"
	"github.com/labstack/echo/v4"
	"net/http"
)

type User struct {
	CardNr string `json:"cardNr"`
	Ccv    string `json:"ccv"`
}

type Bought struct {
	ID      int    `json:"id"`
	CardNr  string `json:"cardNr"`
	Product string `json:"product"`
}

type Payment struct {
	CardNr  string `json:"cardNr"`
	Ccv     string `json:"ccv"`
	Product string `json:"product"`
}

var users = []User{
	{CardNr: "1234567890123456", Ccv: "123"},
	{CardNr: "1212121212121212", Ccv: "456"},
}

var bought = []Bought{
	{ID: 1, CardNr: "1234567890123456", Product: "Bread"},
	{ID: 2, CardNr: "1212121212121212", Product: "Laptop"},
	{ID: 3, CardNr: "1234567890123456", Product: "Milk"},
}

type PaymentController struct{}

func (uc *PaymentController) Pay(c echo.Context) error {
	payment := Payment{}

	fmt.Printf("I got payment request\n")

	if err := c.Bind(&payment); err != nil {
		fmt.Printf("Bad request\n")
		return c.JSON(http.StatusBadRequest, nil)
	}

	for _, temp := range users {
		if temp.CardNr == payment.CardNr {
			if temp.Ccv == payment.Ccv {
				newBought := Bought{
					ID:      len(bought) + 1,
					CardNr:  payment.CardNr,
					Product: payment.Product,
				}
				bought = append(bought, newBought)

				return c.JSON(http.StatusOK, nil)
			}
			fmt.Printf("Inappropriate ccv\n")
			return c.JSON(http.StatusConflict, nil)
		}
	}

	fmt.Printf("Card doesn't exist\n")
	return c.JSON(http.StatusNotFound, nil)
}
