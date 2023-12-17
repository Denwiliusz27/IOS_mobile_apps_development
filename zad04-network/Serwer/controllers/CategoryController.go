package controllers

import (
	"github.com/labstack/echo/v4"
	"net/http"
	"strconv"
)

type Category struct {
	ID   int    `json:"id"`
	Name string `json:"name"`
}

var categories = []Category{
	{ID: 1, Name: "Vegetables"},
	{ID: 2, Name: "Fruits"},
	{ID: 3, Name: "Dairy"},
	{ID: 4, Name: "Drinks"},
	{ID: 5, Name: "Bread"},
}

type CategoryController struct{}

func (cc *CategoryController) GetCategories(c echo.Context) error {
	return c.JSON(http.StatusOK, categories)
}

func (cc *CategoryController) GetCategoryById(c echo.Context) error {
	id, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		return c.JSON(http.StatusBadRequest, nil)
	}

	for _, category := range categories {
		if category.ID == id {
			return c.JSON(http.StatusOK, category)
		}
	}

	return c.JSON(http.StatusNotFound, nil)
}
