-- 00_profile.sql
-- Purpose: profile the raw Olist tables before cleaning.
-- Checks: row counts, duplicate keys, nulls per column, date ranges, status counts.
-- Metric definitions: see docs/metric_definitions.md (added later today).

-- ========== raw.orders ==========

-- 1. Duplicate check: total rows vs distinct order_id
SELECT
    COUNT(*)                 AS total_rows,
    COUNT(DISTINCT order_id) AS distinct_order_ids
FROM raw.orders;

-- 2. Nulls per column: COUNT(*) counts all rows, COUNT(col) skips nulls
SELECT
    COUNT(*) - COUNT(order_id)                      AS null_order_id,
    COUNT(*) - COUNT(customer_id)                   AS null_customer_id,
    COUNT(*) - COUNT(order_status)                  AS null_status,
    COUNT(*) - COUNT(order_purchase_timestamp)      AS null_purchase,
    COUNT(*) - COUNT(order_approved_at)             AS null_approved,
    COUNT(*) - COUNT(order_delivered_carrier_date)  AS null_to_carrier,
    COUNT(*) - COUNT(order_delivered_customer_date) AS null_delivered,
    COUNT(*) - COUNT(order_estimated_delivery_date) AS null_estimated
FROM raw.orders;

-- 3. Order status counts, largest first
SELECT order_status, COUNT(*) AS orders
FROM raw.orders
GROUP BY order_status
ORDER BY orders DESC;

-- 4. Date range of purchases (dates were loaded as text, so cast to timestamp)
SELECT
    MIN(order_purchase_timestamp::timestamp) AS first_purchase,
    MAX(order_purchase_timestamp::timestamp) AS last_purchase
FROM raw.orders;

-- 5. Blank dates by order status: are delivered orders missing delivery dates?
SELECT
    order_status,
    COUNT(*)                                        AS orders,
    COUNT(*) - COUNT(order_approved_at)             AS null_approved,
    COUNT(*) - COUNT(order_delivered_carrier_date)  AS null_to_carrier,
    COUNT(*) - COUNT(order_delivered_customer_date) AS null_delivered
FROM raw.orders
GROUP BY order_status
ORDER BY orders DESC;