package main

import (
	"Serwer/controllers"
	"github.com/labstack/echo/v4"
)

func main() {
	e := echo.New()

	productsController := controllers.ProductsController{}
	e.GET("/products", productsController.GetProducts)
	e.GET("/product/:id", productsController.GetProductById)
	e.GET("/products/:categoryId", productsController.GetProductsByCategoryId)

	categoryController := controllers.CategoryController{}
	e.GET("/categories", categoryController.GetCategories)
	e.GET("/category/:id", categoryController.GetCategoryById)

	err := e.Start(":8080")
	if err != nil {
		return
	}
}
