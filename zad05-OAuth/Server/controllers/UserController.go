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
	Login    string `json:"login"`
	Password string `json:"password"`
}

var users = []User{
	{ID: 1, Name: "Adam", Age: 22, Login: "adam@gmail.com", Password: "adam123"},
	{ID: 2, Name: "John", Age: 45, Login: "johnny@op.pl", Password: "Jhn1"},
	{ID: 3, Name: "Kazimierz", Age: 22, Login: "kaziukozaczek@gmail.com", Password: "takikozaczekjakkazek123"},
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
				return c.JSON(http.StatusOK, temp)
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

	newUser := User{
		ID:       len(users) + 1,
		Name:     user.Name,
		Age:      user.Age,
		Login:    user.Login,
		Password: user.Password,
	}

	users = append(users, newUser)

	fmt.Printf("User created succesfully\n")
	return c.JSON(http.StatusOK, newUser)
}
