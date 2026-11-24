# Data Quality Report

Source: Olist Brazilian E-Commerce dataset (Kaggle), loaded as-is into the `raw` schema
with `scripts/load_raw.py`.

## 1. Row counts after loading

| Table | Rows | One row per |
|---|---:|---|
| raw.customers | 99,441 | customer per order (customer_id) |
| raw.geolocation | 1,000,163 | zip prefix and map point (many per zip) |
| raw.order_items | 112,650 | item in an order |
| raw.order_payments | 103,886 | payment |
| raw.order_reviews | 99,224 | review |
| raw.orders | 99,441 | order |
| raw.products | 32,951 | product |
| raw.sellers | 3,095 | seller |
| raw.product_category_name_translation | 71 | category |

## 2. Issues found

| Table | Issue | Rows affected | Decision |
|---|---|---:|---|
| *To be filled during profiling* | | | |