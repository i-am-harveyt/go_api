package cache

import (
	"context"
	"os"

	"github.com/redis/go-redis/v9"
)

var RedisCli *redis.Client = redis.NewClient(&redis.Options{
	Addr: os.Getenv("REDIS_ADDRESS"),
	Password: "",
	DB:       0,
})

var RedisCtx = context.Background()
