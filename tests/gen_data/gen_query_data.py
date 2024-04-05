"""This module is to generate query params data & save to a file"""

import json
import random


def generate_query_params(num_records):
    """This function is used to generate query params"""
    data = []
    countries = ["US", "CA", "GB", "FR", "DE", "IT", "TW", "JP", "AU", "BR"]
    platforms = ["android", "ios"]
    genders = ["M", "F"]

    for _ in range(num_records):
        params = {}
        if random.random() > 0.5:
            params["age"] = random.randint(0, 80)
        if random.random() > 0.5:
            params["offset"] = random.randint(0, 10)
        if random.random() > 0.5:
            params["limit"] = random.randint(10, 30)
        if random.random() > 0.5:
            params["gender"] = random.sample(genders, 1)[0]
        if random.random() > 0.5:
            params["country"] = random.sample(countries, 1)[0]
        if random.random() > 0.5:
            params["platform"] = random.sample(platforms, 1)[0]

        data.append(params)

    return data


if __name__ == "__main__":
    # 生成 100 筆測試資料
    test_data = generate_query_params(100)

    # 將資料寫入 JSON 檔案
    with open("test_queries.json", "w", encoding="utf8") as file:
        json.dump(test_data, file, indent=2)
