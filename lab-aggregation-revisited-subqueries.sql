-- 1
select first_name, last_name, email from rental
join
customer
using (customer_id)
group by customer_id;

-- 2
select customer_id, concat(first_name, last_name) as name,  round(avg(amount),2) as average_payment from rental
join
customer
using (customer_id)
join
payment
using (customer_id)
group by customer_id;

-- 3a
select concat(cus.first_name, cus.last_name) as name, cus.email from
customer as cus
join
rental
using (customer_id)
join
inventory
using (inventory_id)
join
film_category as fcat
using (film_id)
join
category as cat
using (category_id)
where cat.name = 'Action'
group by cus.customer_id
order by cus.customer_id
;

-- 3b
select concat(first_name, last_name) as name, email from customer
where customer_id in (
select customer_id from rental
where inventory_id in (
select inventory_id from inventory
where film_id in 
(select film_id from
film_category
where category_id = 1)))
order by customer_id;

-- 4
select
(case when amount<=2 then 'low' when amount>2 and amount<=4 then 'medium' when amount>4 then 'high' end) as payment_type
from payment;
