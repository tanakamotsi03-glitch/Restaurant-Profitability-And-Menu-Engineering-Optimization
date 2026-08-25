
-- REMOVING DUPLICATES

/*creating another copy of pos sales table with relevant columns only */
CREATE TABLE `pos_sales_copy4` (
  `order_id` int DEFAULT NULL,
  `transaction_id` int DEFAULT NULL,
  `restaurant_location` text,
  `timestamp` text,
  `item_name` text,
  `quantity` int DEFAULT NULL,
  `unit_price` double DEFAULT NULL,
  `discount` text,
  `total_amount` double DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


insert into pos_sales_copy4
select 
	order_id, transaction_id, restaurant_location,  
	`timestamp`, item_name, quantity, unit_price, discount, 
	total_amount ,
row_number() over( partition by order_id, transaction_id, restaurant_location,  
                      `timestamp`, item_name, quantity, unit_price, discount, 
                      total_amount 
) as row_num
from pos_sales_copy;

delete 
from pos_sales_copy4
where row_num > 1
;

-- Final Cleaned Data
ALTER TABLE pos_sales_copy4 
DROP COLUMN row_num;

ALTER TABLE pos_sales_copy4
RENAME TO pos_sales_clean_Data;



