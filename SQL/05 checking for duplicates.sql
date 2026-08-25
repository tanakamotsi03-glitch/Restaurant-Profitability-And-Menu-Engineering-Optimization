-- Step 5: Checking for Duplicates (Use of CTEs)

with check_for_duplicates as (
select
 transaction_id,
`timestamp`,
item_name,
quantity,
unit_price,
total_amount,

row_number() over(partition by transaction_id, `timestamp`,
item_name,
quantity,
unit_price,
total_amount
) as row_count_for_dup
from pos_sales_copy )

select * from 
check_for_duplicates
where row_count_for_dup < 2
;

