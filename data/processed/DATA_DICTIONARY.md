# Data dictionary
- delivery_delay_days: actual customer delivery date minus estimated date; positive = late.
- approval_hours: purchase to approval time in hours.
- item_count: number of items in an order.
- total_price: sum of item prices, excluding freight.
- total_freight: sum of freight values.
- seller_count: distinct sellers contributing to the order.
- cross_state: primary seller state differs from customer state (1=yes).
- purchase_month: month number; purchase_weekday: Monday=0.
- main_category: most frequent product category in the order; rare categories grouped as Other.
