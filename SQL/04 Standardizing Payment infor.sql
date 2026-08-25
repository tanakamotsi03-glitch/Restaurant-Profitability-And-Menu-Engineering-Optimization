-- Step 4 Standardizing payment_method
UPDATE pos_sales_copy 
SET payment_method = CONCAT(
    UPPER(SUBSTRING(TRIM(payment_method), 1, 1)), 
    LOWER(SUBSTRING(TRIM(payment_method), 2))
);
select *
from pos_sales_copy
;
