package controllers

import (
	"fmt"
	"github.com/labstack/echo/v4"
	"net/http"
)

type User struct {
	ID       int    `json:"id"`
	Name     string `json:"name"`
	Age      int    `json:"age"`
	City     string `json:"city"`
	Login    string `json:"login"`
	Password string `json:"password"`
}

type UserLogin struct {
	Login    string `json:"login"`
	Password string `json:"password"`
}

type UserRegister struct {
	Name     string `json:"name"`
	Age      int    `json:"age"`
	City     string `json:"city"`
	Login    string `json:"login"`
	Password string `json:"password"`
}

type ReturnUser struct {
	Name string `json:"name"`
	Age  int    `json:"age"`
	City string `json:"city"`
}

var users = []User{
	{ID: 1, Name: "Adam", Age: 22, City: "Warszawa", Login: "adam@gmail.com", Password: "adam123"},
	{ID: 2, Name: "John", Age: 45, City: "Gdynia", Login: "johnny@op.pl", Password: "Jhn1"},
	{ID: 3, Name: "Kazimierz", Age: 22, City: "Krosno", Login: "kaziukozaczek@gmail.com", Password: "takikozaczekjakkazek123"},
}

type UserController struct{}

func (uc *UserController) Login(c echo.Context) error {
	user := UserLogin{}

	fmt.Printf("I got login request\n")

	if err := c.Bind(&user); err != nil {
		fmt.Printf("Bad request\n")
		return c.JSON(http.StatusBadRequest, nil)
	}

	for _, temp := range users {
		if temp.Login == user.Login {
			if temp.Password == user.Password {
				returnUser := ReturnUser{
					Name: temp.Name,
					Age:  temp.Age,
					City: temp.City,
				}
				return c.JSON(http.StatusOK, returnUser)
			}
			fmt.Printf("Inappropriate password\n")
			return c.JSON(http.StatusConflict, nil)
		}
	}

	fmt.Printf("User doesn't exist\n")
	return c.JSON(http.StatusNotFound, nil)
}

func (uc *UserController) Register(c echo.Context) error {
	user := UserRegister{}

	if err := c.Bind(&user); err != nil {
		return c.JSON(http.StatusBadRequest, nil)
	}

	for _, temp := range users {
		if temp.Login == user.Login {
			return c.JSON(http.StatusConflict, nil)
		}
	}

	newUser := User{
		ID:       len(users) + 1,
		Name:     user.Name,
		Age:      user.Age,
		City:     user.City,
		Login:    user.Login,
		Password: user.Password,
	}

	users = append(users, newUser)

	returnUser := ReturnUser{
		Name: newUser.Name,
		Age:  newUser.Age,
		City: newUser.City,
	}

	fmt.Printf("User created succesfully\n")
	return c.JSON(http.StatusOK, returnUser)
}
