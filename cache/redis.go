package cache

import (
	"context"

	"github.com/redis/go-redis/v9"
)

var RedisCli *redis.Client = redis.NewClient(&redis.Options{
	Addr:     "localhost:6379",
	Password: "",
	DB:       0,
})

var RedisCtx = context.Background()
