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
| orders | order_id is unique (99,441 rows = 99,441 distinct) | 0 | No action; order_id is the key |
| orders | 8 statuses; 2,963 orders are not "delivered" (shipped 1,107, canceled 625, unavailable 609, invoiced 314, processing 301, created 5, approved 2) | 2,963 | Excluded from delivery metrics; kept for order counts |
| orders | Status "delivered" but no delivered-to-customer date | 8 | Excluded from delivery metrics (definition requires a date) |
| orders | Status "canceled" but has a delivered-to-customer date | 6 | Treated as canceled; excluded from delivery metrics |
| orders | Status "delivered" but no approval date (14) or no carrier date (2) | 16 | Kept; these dates are not used in delivery metrics |
| orders | Purchases span 2016-09-04 to 2018-10-17; first and last months may be incomplete | TBD | Check monthly counts next; exclude incomplete months from trends |