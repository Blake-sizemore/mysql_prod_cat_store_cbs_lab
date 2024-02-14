DROP SCHEMA IF EXISTS sp_cat_lab;
CREATE SCHEMA sp_cat_lab;
USE sp_cat_lab;

CREATE TABLE customers (
    id INT AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    PRIMARY KEY (id)
);

CREATE TABLE orders (
    id INT AUTO_INCREMENT,
    customer_id INT,
    product_name VARCHAR(100),
    quantity INT,
    PRIMARY KEY (id),
    FOREIGN KEY (customer_id) REFERENCES customers (id)
);

INSERT INTO customers (first_name, last_name, email)
VALUES
('Whiskers', 'McMeow', 'whiskers.mcmeow@catmail.com'),
('Fluffy', 'Purrington', 'fluffy.purrington@catmail.com'),
('Mittens', 'Clawson', 'mittens.clawson@catmail.com'),
('Shadow', 'Hissster', 'shadow.hissster@catmail.com'),
('Luna', 'Tailsworth', 'luna.tailsworth@catmail.com');

INSERT INTO orders (customer_id, product_name, quantity)
VALUES
(1, 'Catnip Toy', 2),
(1, 'Scratching Post', 1),
(1, 'Fish-shaped Food Bowl', 1),
(2, 'Catnip Toy', 3),
(2, 'Soft Bed', 1),
(2, 'Mouse Plush', 3),
(3, 'Mouse Plush', 4),
(3, 'Cat Collar with Bell', 1),
(3, 'Tuna Treats Pack', 2),
(4, 'Laser Pointer Toy', 1),
(4, 'Soft Bed', 2),
(4, 'Kitty Litter Scooper', 1),
(5, 'Sisal Ball', 3),
(5, 'Mouse Plush', 2),
(5, 'Catnip Pouch', 2);

select * from orders;

--  Get customer orders
delimiter $$ 
drop procedure if exists get_customer_orders $$
create procedure get_customer_orders(IN _orders_id int)
begin
	select * from orders where customer_id = _orders_id;
end $$
delimiter ;

-- get customers orders 
call get_customer_orders(2);

delimiter $$ 
drop procedure if exists add_new_order $$
create procedure add_new_order(in _customer_id int,IN _product_name varchar(50), in _quantity int)
begin
	insert into orders (customer_id, product_name, quantity) 
    values (_customer_id, _product_name, _quantity);
end $$
delimiter ;

call add_new_order (2,"Jelly", 10);

-- modifiy order 

delimiter $$ 
drop procedure if exists update_order_quantity $$
create procedure update_order_quantity(in _order_id int, in _quantity int)
begin
	update orders set quantity = _quantity where id=_order_id;
end $$
delimiter ;

call update_order_quantity (2,500);

-- delete order 

delimiter $$ 
drop procedure if exists delete_order $$
create procedure delete_order(in _order_id int)
begin
	delete from orders where id=_order_id;
end $$
delimiter ;

call delete_order(1);

-- who ordered this 
select * from orders join customers where product_name = "Catnip Toy";

delimiter $$ 
drop procedure if exists find_customers_by_product $$
create procedure find_customers_by_product(in _product_name varchar(100))
begin
	select * from orders join customers where product_name = _product_name;
end $$
delimiter ;

call find_customers_by_product("Scratching Post");