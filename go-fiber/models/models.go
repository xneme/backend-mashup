package models


type User struct {
    Id int64 `json:"id" gorm:"integer;not null;default:null"`
    Name string `json:"name" gorm:"text;not null;default:null"`
    Email string `json:"email" gorm:"text;not null;default:null"`
}
