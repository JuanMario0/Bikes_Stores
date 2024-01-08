SELECT  -- ord es para especificar la tabla sales.orders 
        -- cus es para especificar la tabla customers
ord.order_id, 
CONCAT(cus.first_name, ' ', cus.last_name),  -- Unimos nombre y apellido en un solo dato 
-- utilizando la función Concat
cus.city, 
cus.state, 
ord.order_date,
-- queremos ahora saber el volumen de ventas y ingresos totales
SUM(ite.quantity) AS 'Total_unidades',
SUM(ite.quantity * ite.list_price) AS  'Ganancia',
pro.product_name, 
cat.category_name,
--ahora saber en que tienda se hicieron las ventas 
sto.store_name,
-- ahora saber el que realizo la venta 
CONCAT(sta.first_name, ' ', sta.last_name) AS 'Ventas_rep'

FROM sales.orders  ord 
JOIN sales.customers cus   -- EL nombre del cliente, el apellido, la ciudad y el estado estan en sales.customers usamos JOIN
ON ord.customer_id = cus.customer_id --Indicamos cual e sla relación en este caso el ID de las dos tablas es el mismo. 
JOIN sales.order_items  ite--Los campos de quantity y list_price 
ON ord.order_id = ite.order_id  
JOIN production.products pro 
ON ite.product_id = pro.product_id
JOIN production.categories cat
ON pro.category_id = cat.category_id
JOIN sales.stores sto
ON ord.store_id = sto.store_id
JOIN sales.staffs sta
ON ord.staff_id = sta.staff_id
-- Para que las dos funciones hagan efecto se aplica group by 
GROUP BY
ord.order_id, 
CONCAT(cus.first_name, ' ', cus.last_name),  
cus.city, 
cus.state, 
ord.order_date,
pro.product_name,
cat.category_name,
sto.store_name,
CONCAT(sta.first_name, ' ', sta.last_name) 