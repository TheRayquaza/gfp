package controllers

import (
    "net/http"
    "svc-pdb/src/data/database"
    "svc-pdb/src/data/models"
    "github.com/gin-gonic/gin"
    "svc-pdb/src/api/dto"
    "svc-pdb/src/domain/services"
)

// POST /api/login
func Login(c *gin.Context) {
    var req dto.LoginRequest

    if err := c.ShouldBindJSON(&req); err != nil {
        c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
        return
    }

    token, err := services.LoginUser(req.Email, req.Password)
    if err != nil {
        c.JSON(http.StatusUnauthorized, gin.H{"error": err.Error()})
        return
    }

    c.JSON(http.StatusOK, gin.H{
        "token": token,
        "type":  "Bearer",
    })
}

// POST /api/register
func Register(c *gin.Context) {
    var req dto.RegisterRequest
    if err := c.ShouldBindJSON(&req); err != nil {
        c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
        return
    }

    user, err := services.RegisterUser(req.Username, req.Email, req.Password)
    if err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": "Could not create user"})
        return
    }

    c.JSON(http.StatusCreated, user)
}

// GET /api/account
func GetAccount(c *gin.Context) {
    userID := c.MustGet("userID").(uint)
    var user models.User
    
    if err := database.DB.First(&user, userID).Error; err != nil {
        c.JSON(http.StatusNotFound, gin.H{"error": "User not found"})
        return
    }
    c.JSON(http.StatusOK, user)
}

// DELETE /api/account
func DeleteAccount(c *gin.Context) {
    userID := c.MustGet("userID").(uint)
    
    if err := database.DB.Delete(&models.User{}, userID).Error; err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete account"})
        return
    }
    c.JSON(http.StatusOK, gin.H{"message": "Account deleted successfully"})
}
