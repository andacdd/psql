--ILK HAFTA--
--1



select * from products



--2
select * from customers where country = 'Germany'

--3

select concat(first_name,' ',last_name),hire_date from employees order by hire_date LIMIT 3

--4

select * from products where unit_price > 50 order by unit_price desc limit 5

--5

select distinct(country) from suppliers order by country

--IKINCI HAFTA--

--1

select category_name, count(*) as product_number  from categories left join products  on categories.category_id = products.category_id group by category_name 

--2

select customers.customer_id, count(*) as order_number
from customers left join orders on customers.customer_id = orders.customer_id
group by customers.customer_id
order by order_number desc limit 10

--3



SELECT e.first_name, e.last_name, round(sum(od.quantity * od.unit_price)) as total_sale
FROM orders o LEFT JOIN order_details od on o.order_id = od.order_id
              LEFT JOIN employees e on  o.employee_id = e.employee_id
			  
GROUP BY e.first_name, e.last_name
ORDER BY sum(od.quantity * od.unit_price) DESC 



--4



select suppliers.company_name, a.number_of_category
from (select supplier_id,count( Distinct(category_id)) as number_of_category from products group by supplier_id) as a left join suppliers on a.supplier_id = suppliers.supplier_id
order by a.number_of_category desc



--5



SELECT  o.customer_id,
		avg(od.quantity * od.unit_price) av_amount
		FROM orders o
		LEFT JOIN order_details od on od.order_id = o.order_id
		group by customer_id
		having 		avg(od.quantity * od.unit_price) > 1000
		
	

--UCUNCU HAFTA

--1 



select distinct(c.customer_id)
from customers c left join orders o on c.customer_id = o.customer_id
where order_id is null


--2 



select  o.order_id, count(*) as product_count
from orders o 
left join order_details od  on o.order_id = od.order_id
left join products p on od.product_id = p.product_id
where p.product_id = (
                      select product_id
                      from order_details
                      group by product_id
                      order by count(*)  desc limit 1)
group by o.order_id



--3 



 select product_name,
       case
	        when unit_price < 20 then 'Cheap'
	        when unit_price > 50 then 'Expensive'
			else 'Medium' end as Price
			
		FROM products
		


--4



SELECT c.country, ROUND(sum(od.quantity * od.unit_price) )as sum_amount
FROM orders o LEFT JOIN customers c on o.customer_id = c.customer_id
              LEFT JOIN order_details od on o.order_id = od.order_id
GROUP BY c.country			  
ORDER BY sum_amount desc LIMIT 5



--BONUS SORU



SELECT distinct(c.category_name), MAX(p.unit_price) OVER(partition by c.category_id) as max_price_in_category
FROM products p 
     LEFT JOIN categories c on p.category_id = c.category_id
	 


--DORDUNCU HAFTA

--Customer Analyses


--1



SELECT c.company_name, ROUND(sum(od.quantity * od.unit_price)) as sum_amount
FROM orders o LEFT JOIN customers c on o.customer_id = c.customer_id
              LEFT JOIN order_details od on o.order_id = od.order_id
GROUP BY company_name			  
ORDER BY sum_amount desc LIMIT 10



--2






--Product Analyses


--3



SELECT p.product_name, round(sum(od.quantity * od.unit_price)) as sum_amount
FROM products p
     LEFT JOIN order_details od on p.product_id = od.product_id
GROUP BY product_name
ORDER BY sum(od.quantity * od.unit_price) desc LIMIT 10 



--4 



SELECT p.product_name COUNT(*) as sale_number

FROM order_details od LEFT JOIN orders o  on o.order_id = od.order_id
                      LEFT JOIN products p on od.product_id = p.product_id
					  
GROUP BY p.product_name
ORDER BY COUNT(*)












	  