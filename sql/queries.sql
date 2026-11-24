-- 14 SQL queries for Olist delivery analysis

-- Q1: Latest delivered orders
SELECT order_id, customer_id, order_purchase_timestamp FROM olist_orders_dataset WHERE order_status='delivered' ORDER BY order_purchase_timestamp DESC LIMIT 10;

-- Q2: Orders by status
SELECT order_status, COUNT(*) AS order_count FROM olist_orders_dataset GROUP BY order_status ORDER BY order_count DESC;

-- Q3: Missing actual delivery dates
SELECT COUNT(*) AS missing_delivery_dates FROM olist_orders_dataset WHERE order_delivered_customer_date IS NULL;

-- Q4: COALESCE for missing product categories
SELECT COALESCE(product_category_name,'Not available') AS category, COUNT(*) AS products FROM olist_products_dataset GROUP BY category ORDER BY products DESC LIMIT 10;

-- Q5: Orders placed in 2018
SELECT COUNT(*) AS orders_2018 FROM olist_orders_dataset WHERE order_purchase_timestamp BETWEEN '2018-01-01' AND '2018-12-31 23:59:59';

-- Q6: Customer cities beginning with s
SELECT customer_city, COUNT(*) AS customers FROM olist_customers_dataset WHERE customer_city LIKE 's%' GROUP BY customer_city ORDER BY customers DESC LIMIT 10;

-- Q7: Average payment by payment type
SELECT payment_type, ROUND(AVG(payment_value),2) AS avg_payment, COUNT(*) AS records FROM olist_order_payments_dataset GROUP BY payment_type ORDER BY avg_payment DESC;

-- Q8: Orders joined with customers
SELECT o.order_id,c.customer_city,c.customer_state FROM olist_orders_dataset o INNER JOIN olist_customers_dataset c ON o.customer_id=c.customer_id LIMIT 20;

-- Q9: Delivered orders joined with item totals
SELECT o.order_id,COUNT(i.order_item_id) AS item_count,ROUND(SUM(i.price),2) AS item_value FROM olist_orders_dataset o LEFT JOIN olist_order_items_dataset i ON o.order_id=i.order_id WHERE o.order_status='delivered' GROUP BY o.order_id ORDER BY item_value DESC LIMIT 20;

-- Q10: Late-delivery share by customer state
SELECT c.customer_state,COUNT(*) AS delivered_orders,ROUND(100.0*SUM(CASE WHEN julianday(o.order_delivered_customer_date)>julianday(o.order_estimated_delivery_date) THEN 1 ELSE 0 END)/COUNT(*),2) AS late_pct FROM olist_orders_dataset o JOIN olist_customers_dataset c ON o.customer_id=c.customer_id WHERE o.order_status='delivered' AND o.order_delivered_customer_date IS NOT NULL GROUP BY c.customer_state HAVING COUNT(*)>=100 ORDER BY late_pct DESC;

-- Q11: Review score vs average delivery delay
SELECT r.review_score,COUNT(*) AS reviews,ROUND(AVG(julianday(o.order_delivered_customer_date)-julianday(o.order_estimated_delivery_date)),2) AS avg_delay_days FROM olist_order_reviews_dataset r JOIN olist_orders_dataset o ON r.order_id=o.order_id WHERE o.order_status='delivered' AND o.order_delivered_customer_date IS NOT NULL GROUP BY r.review_score ORDER BY r.review_score;

-- Q12: Top product categories by sales
SELECT COALESCE(p.product_category_name,'Unknown') AS category,COUNT(*) AS units,ROUND(SUM(i.price),2) AS sales_value FROM olist_order_items_dataset i LEFT JOIN olist_products_dataset p ON i.product_id=p.product_id GROUP BY category ORDER BY sales_value DESC LIMIT 15;

-- Q13: Zero-value payments by type
SELECT payment_type,COUNT(*) AS records,SUM(CASE WHEN payment_value=0 THEN 1 ELSE 0 END) AS zero_value_records FROM olist_order_payments_dataset GROUP BY payment_type;

-- Q14: Monthly average delivery delay
SELECT strftime('%Y-%m',order_purchase_timestamp) AS month,COUNT(*) AS orders,ROUND(AVG(julianday(order_delivered_customer_date)-julianday(order_estimated_delivery_date)),2) AS avg_delay_days FROM olist_orders_dataset WHERE order_status='delivered' AND order_delivered_customer_date IS NOT NULL GROUP BY month ORDER BY month;

