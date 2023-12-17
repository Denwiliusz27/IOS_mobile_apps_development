package controllers

import (
	"github.com/labstack/echo/v4"
	"net/http"
	"strconv"
)

type Product struct {
	ID         int    `json:"id"`
	Name       string `json:"name"`
	CategoryId int    `json:"categoryId"`
}

var products = []Product{
	{ID: 1, Name: "Potatoes", CategoryId: 1},
	{ID: 2, Name: "Apple", CategoryId: 2},
	{ID: 3, Name: "Pepsi", CategoryId: 4},
	{ID: 4, Name: "Village bread", CategoryId: 5},
	{ID: 5, Name: "Tomatoes", CategoryId: 1},
	{ID: 6, Name: "Milk", CategoryId: 3},
	{ID: 7, Name: "Banana", CategoryId: 2},
}

type ProductsController struct{}

func (p *ProductsController) GetProducts(c echo.Context) error {
	return c.JSON(http.StatusOK, products)
}

func (p *ProductsController) GetProductById(c echo.Context) error {
	id, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		return c.JSON(http.StatusBadRequest, nil)
	}

	for _, product := range products {
		if product.ID == id {
			return c.JSON(http.StatusOK, product)
		}
	}

	return c.JSON(http.StatusNotFound, nil)
}

func (p *ProductsController) GetProductsByCategoryId(c echo.Context) error {
	var result []Product

	categoryId, err := strconv.Atoi(c.Param("categoryId"))
	if err != nil {
		return c.JSON(http.StatusBadRequest, nil)
	}

	for _, product := range products {
		if product.CategoryId == categoryId {
			result = append(result, product)
		}
	}

	if len(result) > 0 {
		return c.JSON(http.StatusOK, result)
	}

	return c.JSON(http.StatusNotFound, nil)
}
