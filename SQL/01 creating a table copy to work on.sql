-- Creating a Copy of the table POS_Sales to work on 

CREATE TABLE pos_sales_copy
like pos_sales;

INSERT pos_sales_copy
select *
from pos_sales;

-- PHASE 1: Data cleaning and standardizing POS data 

SELECT *
FROM pos_sales_copy;

-- Step 1: checking for Null values

SELECT 
  SUM(CASE WHEN order_id IS NULL OR order_id = '' THEN 1 ELSE 0 END) AS Null_order_Id,
  SUM(CASE WHEN transaction_id IS NULL OR transaction_id = '' THEN 1 ELSE 0 END) AS Null_transaction_Id,
  SUM(CASE WHEN restaurant_location IS NULL OR restaurant_location = '' THEN 1 ELSE 0 END) AS Null_restaurant_location,
  SUM(CASE WHEN `timestamp` IS NULL OR `timestamp` = '' THEN 1 ELSE 0 END) AS Null_timestamp,
  SUM(CASE WHEN day_of_week IS NULL OR day_of_week = '' THEN 1 ELSE 0 END) AS Null_day_of_week,
  SUM(CASE WHEN meal_period IS NULL OR meal_period = '' THEN 1 ELSE 0 END) AS Null_meal_period,
  SUM(CASE WHEN table_number IS NULL OR table_number = '' THEN 1 ELSE 0 END) AS Null_table_number,
  SUM(CASE WHEN employee_id IS NULL OR employee_id = '' THEN 1 ELSE 0 END) AS Null_employee_id,
  SUM(CASE WHEN customer_type IS NULL OR customer_type = '' THEN 1 ELSE 0 END) AS Null_customer_type,
  SUM(CASE WHEN item_name IS NULL OR item_name = '' THEN 1 ELSE 0 END) AS Null_item_name,
  SUM(CASE WHEN quantity IS NULL OR quantity = '' THEN 1 ELSE 0 END) AS Null_quantity,
  SUM(CASE WHEN unit_price IS NULL OR unit_price = '' THEN 1 ELSE 0 END) AS Null_unit_price,
  SUM(CASE WHEN discount IS NULL OR discount = '' THEN 1 ELSE 0 END) AS Null_discount,
  SUM(CASE WHEN tax IS NULL OR tax = '' THEN 1 ELSE 0 END) AS Null_tax,
  SUM(CASE WHEN total_amount IS NULL OR total_amount = '' THEN 1 ELSE 0 END) AS Null_total_amount,
  SUM(CASE WHEN payment_method IS NULL OR payment_method = '' THEN 1 ELSE 0 END) AS Null_payment_method
FROM pos_sales_copy;

-- setting null discount value to 0

UPDATE pos_sales_copy
SET discount = 0 
WHERE discount IS NULL
   OR TRIM(discount) = '';
   
-- setting null tax value to 0

UPDATE pos_sales_copy
SET tax = 0 
WHERE tax IS NULL
   OR TRIM(tax) = '';
