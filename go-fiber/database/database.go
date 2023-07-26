package database

import (
	"log"
	"os"

	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
)

type Dbinstance struct {
    Db *gorm.DB
}

var DB Dbinstance

func ConnectDb() {
    db, err := gorm.Open(postgres.Open(os.Getenv("DB_DSN")), &gorm.Config{
        Logger: logger.Default.LogMode(logger.Info),
    })

    if err != nil {
        log.Fatal("Failed to connect to database.\n", err)
        os.Exit(2)
    }

    log.Println("connected to database")
    db.Logger = logger.Default.LogMode(logger.Info)

//    log.Println("running migrations")
//    db.AutoMigrate(&models.User{})

    DB = Dbinstance{
        Db: db,
    }
}
