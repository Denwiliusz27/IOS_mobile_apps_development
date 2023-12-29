package controllers

import (
	"github.com/labstack/echo/v4"
	"net/http"
)

type Order struct {
	ID           int     `json:"id"`
	OrderDate    string  `json:"orderDate"`
	IsShipped    bool    `json:"isShipped"`
	ProductsIds  []int   `json:"productsIds"`
	SummaryPrice float64 `json:"summaryPrice"`
}

var orders = []Order{
	{ID: 1, OrderDate: "2023/12/23", IsShipped: false, ProductsIds: []int{1, 2, 3}, SummaryPrice: 11.47},
	{ID: 2, OrderDate: "2023/11/30", IsShipped: true, ProductsIds: []int{2, 7}, SummaryPrice: 6.49},
	{ID: 3, OrderDate: "2023/12/15", IsShipped: false, ProductsIds: []int{3, 5}, SummaryPrice: 12.48},
}

type OrderController struct{}

func (oc *OrderController) GetOrders(c echo.Context) error {
	return c.JSON(http.StatusOK, orders)
}
