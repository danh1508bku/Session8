CREATE TABLE order_detail (
    id SERIAL PRIMARY KEY,
    order_id INT,
    product_name VARCHAR(100),
    quantity INT,
    unit_price NUMERIC
);

create or replace procedure calculate_order_total(order_id_input int, out total numeric)
as $$
begin
	select coalesce(sum(unit_price*quantity),0) into total from order_detail
	where order_id = order_id_input;
end;
$$ language plpgsql;


INSERT INTO order_detail (order_id, product_name, quantity, unit_price) VALUES
(1, 'Trà sữa trân châu', 2, 30000),
(1, 'Trà đào', 1, 40000),
(1, 'Matcha latte', 3, 35000),

(2, 'Cà phê sữa', 2, 25000),
(2, 'Bạc xỉu', 1, 30000),

(3, 'Trà vải', 1, 45000);


call calculate_order_total(1,null);
call calculate_order_total(4,null)
