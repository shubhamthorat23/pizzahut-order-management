create database pizzahut;
use pizzahut;
select* from pizzas;
select* from pizza_types;

create table orders(order_id int not null,
order_date date not null,
order_time time not null);

select* from orders;	

create table orders_details(order_details_id int not null,
order_id int not null,
pizza_id text not null,
quantity int not null);

select* from orders_details;

-- Retrieve the total number of orders placed.
select*from orders;
select count(order_id) from (orders);
select count(order_id) as total_orders from orders;

-- Calculate the total revenue generated from pizza sales.
select*from orders_details;
select*from pizzas;

select
sum(orders_details.quantity * pizzas.price) as total_sales
from orders_details join pizzas
on pizzas.pizza_id = orders_details.pizza_id;

-- Identify the highest priced pizza.
select* from pizzas;

select pizza_types.name,pizzas.price
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
order by pizzas.price desc
limit 1;


-- identify the most common pizz size orderad.
select*from pizzas;
select*from orders_details;


select pizzas.size, count(orders_details.order_details_id) as orders_count
from pizzas join orders_details
on pizzas.pizza_id = orders_details.pizza_id
group by pizzas.size;


-- join the necessary table to find the total quantity of each pizza category ordered.
select*from pizzas;
select*from pizza_types;
select*from orders_details;

select pizza_type.category,
sum(orders_details.quantity) as quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join orders_details
on orders_details.pizza_id = pizzas.pizza_id
group by pizza_types.category order by quantity;

SELECT 
    pizza_types.category, 
    SUM(orders_details.quantity) AS total_quantity
FROM 
    pizza_types 
JOIN 
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id 
JOIN 
    orders_details ON orders_details.pizza_id = pizzas.pizza_id 
GROUP BY 
    pizza_types.category 
ORDER BY 
    total_quantity DESC;


-- Deterimine the distribution of orders by hours of the day
select*from orders;

select hour(order_time) , count(order_id) from orders
group by hour(order_time);



-- Find the category-wise distribution of pizzas.
select*from pizza_types;

select category , count(name) from pizza_types
group by category;


-- Group the orders by date and calculate the average number of pizzas ordered per day.
select*from orders;
select*from orders_details;

select avg(quantity) from
(select orders.order_date,sum(orders_details.quantity) as quantity
from orders join orders_details
on orders.order_id=orders_details.order_id
group by orders.order_date) as order_quantity;


-- Determine the top 3 most ordered pizza types based on revenue.
select*from pizza_types;
select*from orders_details;
select*from pizzas;

select pizza_types.name,
sum(orders_details.quantity*pizzas.price) as revenue
from pizza_types join pizzas
on pizzas.pizza_type_id=pizza_types.pizza_type_id
join orders_details
on orders_details.pizza_id=pizzas.pizza_id
group by pizza_types.name order by revenue desc limit 3;













		