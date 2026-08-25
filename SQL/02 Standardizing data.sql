-- Step 2: standardizing pos data i.e item_name column

SELECT 
    CONCAT(
        UPPER(SUBSTRING(TRIM(item_name), 1, 1)), 
        LOWER(SUBSTRING(TRIM( item_name), 2))
    ) AS cleaned_value
FROM pos_sales_copy;

-- updating the food_item column

UPDATE pos_sales_copy  
SET item_name = CONCAT(
    UPPER(SUBSTRING(TRIM(item_name), 1, 1)), 
    LOWER(SUBSTRING(TRIM(item_name), 2))
);

select *
from pos_sales_copy;


