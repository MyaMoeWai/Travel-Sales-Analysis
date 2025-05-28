
SELECT reservation_date, 
count(distinct customer_id) As unique_customer
FROM reservations
GROUP BY reservation_date
ORDER BY reservation_date;


with customer_count as (
select r.product_id,r.customer_id,s.sale_amount
from sales s 
join reservations r on s.reservation_id=r.reservation_id
where r.status='Confirmed')
select p.product_name,p.product_type,
count(distinct cc.customer_id) as total_customers,
sum(cc.sale_amount) as total_sale
from customer_count cc
join products p on cc.product_id=p.product_id
group by p.product_id,p.product_name;


with total_reservation as (
select reservation_date,count(reservation_id) as total_rsvp
from reservations
where reservations.status='Confirmed'
group by reservation_date)
select date_format(reservation_date,'%Y-%m-%d') as rsvp_date, avg(total_rsvp) as avg_daily_rsvp
from total_reservation
group by date_format(reservation_date,'%Y-%m-%d');

select country_name, count(cus.customer_id) as total_customers
from customers cus
join cities ci on cus.city_id=ci.city_id
join countries co on ci.country_id=co.country_id
group by co.country_name;


select date_format(s.sale_date,'%Y-%m-%d') as sale_date, count(s.sale_id) as total_sale_transactions,
sum(s.sale_amount) as total_sale_amount
from sales s
group by date_format(s.sale_date,'%Y-%m-%d') 
order by date_format(s.sale_date,'%Y-%m-%d') asc;


select payment_name, count(distinct r.customer_id) as total_customers
from sales s
join reservations r on s.reservation_id=r.reservation_id
join payment p on s.payment_id=p.payment_id
where p.payment_name in ('Credit Card', 'Debit Card')
group by p.payment_name;

 
select concat(c.first_name," ",c.last_name)as customer,
 sum(s.sale_amount) as total_purchased
from sales s
join reservations r on s.reservation_id=r.reservation_id
join customers c on r.customer_id= c.customer_id
where r.status='Confirmed' and s.sale_amount>600.00
group by concat(c.first_name," ",c.last_name);


SELECT DATE_FORMAT(reservation_date, '%Y-%m') AS month_year, 
COUNT(*) AS cancelled_reservations
FROM reservations
WHERE status = 'Cancelled'
GROUP BY DATE_FORMAT(reservation_date, '%Y-%m')
ORDER BY month_year;


select date_format(s.sale_date,'%Y-%m-%d') as sale_date, count(s.sale_id) as total_sale_count, sum(s.sale_amount) as total_sale_amount
from sales s 
join reservations r on s.reservation_id=r.reservation_id
join products p on r.product_id=p.product_id
where p.product_type='Hotel'
group by date_format(s.sale_date,'%Y-%m-%d')
order by date_format(s.sale_date,'%Y-%m-%d') asc;


select c.first_name,c.last_name,c.email,c.phone_number
from customers c 
join reservations r on c.customer_id=r.customer_id
join products p on r.product_id=p.product_id
where p.product_type='Hotel' and r.status='Confirmed';


SELECT p.product_name, date_format(r.reservation_date, '%Y-%m') AS sale_month, 
sum(s.sale_amount) as total_rvenue
FROM sales s
join reservations r on s.reservation_id=r.reservation_id
join products p on r.product_id=p.product_id
WHERE r.status = 'Confirmed'
GROUP BY p.product_name, date_format(r.reservation_date, '%Y-%m')
ORDER BY sale_month, product_name;


select concat(c.first_name, ' ', c.last_name) as full_name,c.phone_number,c.email,ci.city_name as city, co.country_name as country,c.registration_date,p.product_type,
p.product_name as product_description, 
sum(s.sale_amount) as total_spent_amount
from customers c
join reservations r on c.customer_id = r.customer_id
join sales s on r.reservation_id = s.reservation_id
join products p on r.product_id = p.product_id
join cities ci on c.city_id = ci.city_id
join countries co on ci.country_id = co.country_id
where r.status = 'Confirmed'
group by c.customer_id,full_name, c.phone_number, c.email, c.registration_date, 
    p.product_type, product_description, ci.city_name, co.country_name;