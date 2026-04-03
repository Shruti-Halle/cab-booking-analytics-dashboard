use cab_booking_system;
show tables;
select * from customers;
desc customers;
select * from drivers;

desc drivers;
select * from payments;
desc payments;
select * from rides;
desc rides;
select * from vehicles;
desc vehicles;


-- 1. Who are the top earning drivers?
select * from drivers;
select * from rides;

select d.driver_name,sum(r.fare) as total_earnings
from drivers d
join rides r 
on d.driver_id=r.driver_id
where r.status="completed"
group by d.driver_name
order by total_earnings desc;

-- 2. Which locations generate the most rides?
select pickup_location ,count(*) as total_rides 
from rides 
group by pickup_location
order by total_rides desc;

-- 3. What is the cancellation rate?
select count(*) * 100.0 /(select count(*) from rides)
as cancellation_rate from rides 
where status="cancelled";

-- 4. Which customers use the service most?
select c.customer_name,count(r.ride_id) as total_rides
from customers c
join rides r
on c.customer_id=r.customer_id
group by c.customer_name
order by total_rides desc;

-- 5. Which vehicle types generate the highest revenue?
select * from vehicles;
select * from rides;
select * from drivers;

select v.vehicle_type ,sum(r.fare) as highest_revenue
from drivers d
join rides r on d.driver_id=r.driver_id
join vehicles v on v.vehicle_id=d.vehicle_id
group by v.vehicle_type
order by highest_revenue desc;



-- 1. Total Revenue Generated

-- Question: How much total revenue has the company generated?
select * from payments;

select sum(amount) as total_revenue
from payments
where payment_status="success";

-- 2. Top 5 Customers by Spending
select c.customer_id,c.customer_name ,sum(p.amount) as total_spent
from customers c 
join rides r on r.customer_id=c.customer_id
join payments p on p.ride_id=r.ride_id
where p.payment_status="success"
group by c.customer_id,c.customer_name
order by total_spent desc
limit 5;

-- 3. Driver with Highest Average Rating and Most Rides
select * from drivers;
select * from rides;

select d.driver_id,d.driver_name,floor(avg(d.rating)) as average_rating,
count(r.ride_id) as total_rides
from drivers d
join rides r on r.driver_id=d.driver_id
group by d.driver_id,d.driver_name
order by total_rides desc
limit 1;


-- 4. Cancellation Rate

select count(case when status="Cancelled" then 1 end)*100.0/ count(*) as cancellation_rate
from rides;

-- 5.Daily Revenue Trend 
select * from payments;

select date(payment_date) as Payment_Date ,sum(amount) as daily_revenue
from payments
group by date(payment_date)
order by Payment_Date;

-- 6. Most Popular Pickup Location
select * from rides;

select pickup_location,count(*) as total_rides
from rides
group by pickup_location
order by total_rides desc 
limit 1;

-- 7. Drivers Who Never Completed a Ride

select * from drivers;
select * from rides;

select d.driver_id,d.driver_name
from drivers d
left join rides r 
on r.driver_id=d.driver_id
and r.status="Cancelled" 
where r.ride_id is null;


