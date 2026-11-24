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
| orders | Incomplete months: 2016-09 (4), 2016-10 (324), 2016-11 (no orders), 2016-12 (1), 2018-09 (16), 2018-10 (4); none of the 2018-09/10 orders are delivered | 349 | Trend charts use Jan 2017 – Aug 2018 (20 full months); all delivered orders kept for other analyses |
| customers | customer_id is one per order (99,441), not one per person; real people = customer_unique_id (96,096) | 99,441 | Use customer_unique_id for all customer-level and repeat-purchase analysis |
| customers | Repeat buyers are rare: 93,099 people placed 1 order; 2,997 placed 2 or more (all statuses) | 2,997 | Report counts with every repeat-rate result; flag small groups |
| customers | One customer_unique_id has 17 orders, one has 9 | 2 | Kept; check later whether these look like business buyers |
| customers | No nulls in unique_id, zip, city or state | 0 | No action |
| order_reviews | Some orders have more than one review (543 with 2, 4 with 3) | 551 extra rows | Keep one review per order (most recent) before joining; decide exact rule on Day 2 |
| order_reviews | review_id is not unique (99,224 rows, 98,410 distinct) | 814 extra rows | Do not use review_id alone as a key |
| order_reviews | Orders with no review | 768 | Excluded from review-score analysis; kept for delivery metrics |
| order_reviews | Reviews with no written comment (much more common at 4–5 stars) | 58,247 | Kept for score analysis; only commented reviews go to Q4 classification |