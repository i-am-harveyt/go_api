import json
import random
from datetime import datetime, timedelta


def generate_test_data(num_records):
    data = []
    countries = ["US", "CA", "GB", "FR", "DE", "IT", "TW", "JP", "AU", "BR"]
    platforms = ["android", "ios"]
    genders = ["M", "F"]

    for i in range(1, num_records + 1):
        start_date = datetime(2024, 1, 1) + \
            timedelta(days=random.randint(0, 364))
        end_date = start_date + timedelta(days=random.randint(1, 30))

        num_conditions = random.randint(1, 3)
        conditions = []

        for j in range(num_conditions):
            age_start = random.randint(18, 60)
            age_end = age_start + random.randint(5, 20)
            country = random.sample(countries, random.randint(1, 3))
            platform = random.sample(platforms, random.randint(1, 2))
            gender = random.sample(genders, random.randint(1, 2))

            condition = {
                "ageStart": age_start,
                "ageEnd": age_end,
                "country": country,
                "platform": platform
            }

            if random.random() < 0.5:
                condition["gender"] = gender

            conditions.append(condition)

        record = {
            "title": f"AD {i}",
            "startAt": start_date.isoformat() + "Z",
            "endAt": end_date.isoformat() + "Z",
            "conditions": conditions
        }

        data.append(record)

    return data


# 生成 100 筆測試資料
test_data = generate_test_data(100)

# 將資料寫入 JSON 檔案
with open("test_data.json", "w") as file:
    json.dump(test_data, file, indent=2)
