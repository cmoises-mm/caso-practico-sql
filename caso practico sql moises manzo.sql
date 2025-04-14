 select * from menu_items;
-- Encontrar el número de artículos en el menú.--
 select count(item_name) from menu_items;
--respuesta es 32 articulos--

--¿Cuálesel artículo menos caro y el más caro en el menú?--
(select item_name, price
from menu_items
where price =(select min(price) from menu_items))
union all
--edamame 5 --
(select item_name, price
from menu_items
where price =(select max(price) from menu_items))
--shrimp scampi 19.95--

--¿Cuántos platos americanos hay en el menú?--

select count (category) from menu_items
where category ='American'
--6 platos americanos--

--¿Cuál es el precio promedio de los platos?--
select round(avg(price),2) from menu_items
--precio promedio es 13.29--

select * from order_details
--¿Cuántos pedidos únicos se realizaron en total?--
select count(distinct order_id) from order_details;
--hay 5370 pedidos unicos--

--¿Cuáles son los 5 pedidos que tuvieron el mayor número de artículos?--
select * from order_details
where order_id is  not null
order by order_id desc
limit 5;

-- ¿Cuándoserealizó el primer pedido y el último pedido?--
(select * from order_details
	where order_date = (select min(order_date) from order_details )
	order by 4 asc
	limit 1)
	union all
(select * from order_details
	where order_date = (select max(order_date) from order_details )
	order by 4 desc
	limit 1)


--¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'?--
select count (order_date) from order_details
 where order_date between '2023-01-01' and '2023-01-05'

-- Realizar un left join entre entre order_details y menu_items con el identificador item_id(tabla order_details) y menu_item_id(tabla menu_items)--

select  * from order_details
left join  menu_items on order_details.item_id = menu_items.menu_item_id

-- los 5 productos mas vendidos--

select distinct(item_name) as articulo,
	count(m.item_name) as veces_pedido,
	category
	from order_details o
	inner join  menu_items  m on o.item_id = m.menu_item_id
	group by articulo , category
	order by veces_pedido desc
	limit 5

--el mes que mas ventas hubo--


SELECT TO_CHAR(o.order_date::DATE, 'Month') AS nombre_mes,
	count(m.item_name) as veces_pedido
	from order_details o
	inner join  menu_items  m on o.item_id = m.menu_item_id
	group by nombre_mes
	order by veces_pedido desc
	limit 1
	

--horario con mas pedidos--
SELECT (o.order_time) AS hora_pico,
		o.order_date,
	count(m.item_name) as veces_pedido
	from order_details o
	inner join  menu_items  m on o.item_id = m.menu_item_id
	group by hora_pico, o.order_date
	order by veces_pedido desc
	limit 1

--la categoria con mas--
SELECT category AS categoria,
	count(m.item_name) as veces_pedido
	from order_details o
	inner join  menu_items  m on o.item_id = m.menu_item_id
	group by categoria
	order by veces_pedido desc
	limit 1
--los productos con mas ventas  por   mes --
SELECT m.item_name AS producto,
	count(m.item_name)*m.price as cantidad,
	TO_CHAR(o.order_date::DATE, 'Month') AS nombre_mes
	from order_details o
	inner join  menu_items  m on o.item_id = m.menu_item_id
	group by producto,price,nombre_mes
	order by cantidad desc
	