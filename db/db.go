package db

import (
	"database/sql"
	"fmt"
	_ "github.com/lib/pq" // PostgreSQL driver
)

var DB *sql.DB

func Init(dataSourceName string) {
	var err error
	DB, err = sql.Open("postgres", dataSourceName)
	if err != nil {
		panic(err)
	}

	err = DB.Ping()
	if err != nil {
		panic(err)
	}

	fmt.Println("Database connection established")
}
