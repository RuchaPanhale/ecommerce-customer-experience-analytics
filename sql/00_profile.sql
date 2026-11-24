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

-- 6. Orders per month: find incomplete months at the start and end of the data
SELECT
    DATE_TRUNC('month', order_purchase_timestamp::timestamp)::date AS order_month,
    COUNT(*)                                                       AS orders,
    COUNT(*) FILTER (WHERE order_status = 'delivered')             AS delivered_orders
FROM raw.orders
GROUP BY order_month
ORDER BY order_month;

-- ========== raw.customers ==========

-- 7. Keys: order-level customer_id vs real person (customer_unique_id)
SELECT
    COUNT(*)                           AS total_rows,
    COUNT(DISTINCT customer_id)        AS distinct_customer_ids,
    COUNT(DISTINCT customer_unique_id) AS distinct_people
FROM raw.customers;

-- 8. Nulls per column
SELECT
    COUNT(*) - COUNT(customer_unique_id)       AS null_unique_id,
    COUNT(*) - COUNT(customer_zip_code_prefix) AS null_zip,
    COUNT(*) - COUNT(customer_city)            AS null_city,
    COUNT(*) - COUNT(customer_state)           AS null_state
FROM raw.customers;

-- 9. How many people placed 1, 2, 3... orders (all statuses, profiling only)
WITH orders_per_person AS (
    SELECT customer_unique_id, COUNT(*) AS n_orders
    FROM raw.customers
    GROUP BY customer_unique_id
)
SELECT n_orders, COUNT(*) AS people
FROM orders_per_person
GROUP BY n_orders
ORDER BY n_orders;