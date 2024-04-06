# Go Ad Service

This is a simple ad serving service implemented in Go. It provides two RESTful APIs: one for creating ads and another for listing active ads based on certain conditions.

## Requirements

- Go 1.16 or later
- PostgreSQL database

## Run this app

```bash
git clone https://github.com/i-am-harveyt/go-ad-service.git
cd go-ad-service

docker compose up &
```

The server will start running on `http://localhost:3000`.

## 架構設定

1. API 介面同題幹描述
2. 網路框架： Go Fiber
3. 外部存儲
   1. DB: PostgreSQL
   2. Cache: Redis
4. Rate Limiter (Go fiber middleware, not builit from scratch)
5. Validator, to validate data, escpcially the ISO-3166 part

## 設計思路

1. 選擇 Go Fiber 而非 Gin 的理由：
   1. 相對簡要易讀的 doc，此外 Gin 的已經許久沒有更新 (2022)
   2. 比較接近 Express 的設計邏輯，較為熟悉
   3. 雖然沒有支援 HTTP2，fasthttp 的生態系也相對不健全，但該框架的功能已經足夠齊全
2. 資料庫選擇
   1. 初步想法：在本題中，condition 可能有多個，所以直觀來說，用 RDBMS 常有的 INNER JOIN 可以有效地把 ad 表的資料跟 condition 的資料串連在一起
   2. 不過值得注意的是，因為本題的廣告數量有限，因此難保某些情況，直接用 NoSQL 可能有更佳的效能
   3. 不過因為本題並沒有特別討論水平擴展能力，所以以中心化的資料管理為主，這時候用 NoSQL 的效益可能較低，因此選用 RDBMS
   4. 並沒有選擇使用 ORM，因為在這個情況下編寫程式碼的複雜度不大，不至於需要特此追求簡化
3. 快取
   1. 本題有要求 Public API capacity
   2. 考量到進出資料庫的時間較長，使用快取來增加相同 query 的返還速度
   3. 本程式設定快取資料的生命週期一分鐘，以確保新資料插入後，快取的資料不會長時間與資料庫不一致
4. Rate Limiter
   1. Go Fiber 有自帶的 Rate limiter middleware，此處暫時不選擇重頭做起
   2. 此設計主要是為了防止相同來源大量重複請求拖慢或癱瘓系統
5. Validator
   1. 選用 validator 包
   2. 原意是為了處理 ISO-3166 的驗證問題，但後來把所有驗證都用其解決了
