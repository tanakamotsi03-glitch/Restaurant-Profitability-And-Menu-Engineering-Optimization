-- Step 3 standardizing pos data i.e timestamp column
-- converting text/string  to date
UPDATE pos_sales_copy

SET  `timestamp` = 
    CASE 
        -- Matches YYYY-MM-DD
        WHEN `timestamp` LIKE '____-__-__%' THEN STR_TO_DATE(`timestamp`, '%Y-%m-%d %H:%i:%s')
        -- Matches DD/MM/YYYY
        WHEN `timestamp` LIKE '__/__/____%' THEN STR_TO_DATE(`timestamp`, '%d/%m/%Y %H:%i')
        -- Matches MM-DD-YYYY
        WHEN `timestamp` LIKE '__-__-____%' THEN STR_TO_DATE(`timestamp`, '%m-%d-%Y %H:%i')
        ELSE `timestamp`
    END 
;

select *
from pos_sales_copy;
