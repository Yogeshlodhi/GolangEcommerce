package middleware

import (
	Tokens "github.com/Yogeshlodhi/Tokens"
	"net/http"
	"github.com/gin-gonic/gin"
)

func Authentication() gin.HandlerFunc{
	return func(c *gin.Context){
		ClientToken := c.Request.Header.Get("token")
		if ClientToken == ""{
			c.JSON(http.StatusInternalServerError, gin.H{"error": "No authorization header found"})
			c.Abort()
			return
		}
		claims, err := Tokens.ValidateToken(ClientToken)
		if err != ""{
			c.JSON(http.StatusInternalServerError, gin.H{"error": err})
			c.Abort()
			return
		}

		c.Set("email", claims.Email)
		c.Set("uid", claims.Uid)
		c.Next()
	}
}