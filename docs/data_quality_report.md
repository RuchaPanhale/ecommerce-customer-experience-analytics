# Data Quality Report

Source: Olist Brazilian E-Commerce dataset (Kaggle), loaded as-is into the `raw` schema
with `scripts/load_raw.py`.

Scope: this project uses 4 tables (orders, order_items, order_reviews, customers).
The script also loads the other 5 Kaggle files, but they are not used.

## 1. Row counts after loading

| Table | Rows | One row per |
|---|---:|---|
| raw.orders | 99,441 | order |
| raw.order_items | 112,650 | item in an order |
| raw.order_reviews | 99,224 | review |
| raw.customers | 99,441 | customer per order (customer_id) |

## 2. Checks and issues

| Table | Issue | Rows affected | Decision |
|---|---|---:|---|
| orders | order_id is unique (99,441 rows = 99,441 distinct) | 0 | No action; order_id is the key |
| orders | 8 statuses; 2,963 orders are not "delivered" (shipped 1,107, canceled 625, unavailable 609, invoiced 314, processing 301, created 5, approved 2) | 2,963 | Excluded from delivery metrics; kept for order counts |
| orders | Status "delivered" but no delivered-to-customer date | 8 | Excluded from delivery metrics (definition requires a date) |
| orders | Status "canceled" but has a delivered-to-customer date | 6 | Treated as canceled; excluded from delivery metrics |
| orders | Status "delivered" but no approval date (14) or no carrier date (2) | 16 | Kept; these dates are not used in delivery metrics |
| orders | Incomplete months: 2016-09 (4), 2016-10 (324), 2016-11 (no orders), 2016-12 (1), 2018-09 (16), 2018-10 (4); none of the 2018-09/10 orders are delivered | 349 | Trend charts use Jan 2017 – Aug 2018 (20 full months); all delivered orders kept for other analyses |
| customers | customer_id is one per order (99,441), not one per person; real people = customer_unique_id (96,096) | 99,441 | dim_customer is keyed on customer_id; customer_unique_id is kept as a column for counting real people |
| customers | No nulls in unique_id, zip, city or state | 0 | No action |
| order_reviews | Some orders have more than one review (543 with 2, 4 with 3) | 551 extra rows | Keep one review per order (most recent); rule finalized in Step 2 (staging) |
| order_reviews | review_id is not unique (99,224 rows, 98,410 distinct) | 814 extra rows | Do not use review_id alone as a key |
| order_reviews | Orders with no review | 768 | Excluded from review-score analysis; kept for delivery metrics |
| order_reviews | Reviews with no written comment (much more common at 4–5 stars) | 58,247 | Kept; tracked as has_comment in fact_orders; comment text is not analyzed |
| order_items | (order_id, order_item_id) is unique; 112,650 rows across 98,666 orders | 0 | Use the pair as the key for fact_order_items |
| order_items | Most orders have 1 item (88,863); largest order has 21 items | 0 | Sum items to one row per order in fact_orders |
| order_items | Prices R$0.85 to R$6,735 (median R$74.99); none zero or negative | 0 | Kept; report medians next to averages because of high-value items |
| order_items | Items with freight_value = 0 | 383 | Kept; treated as free shipping |
| order_items | Items whose order_id is missing from orders | 0 | No action |
| orders / order_items | Orders with no items (unavailable 603, canceled 164, created 5, invoiced 2, shipped 1); no delivered order lacks items | 775 | order_value is null for these; they are excluded from delivery metrics anyway |