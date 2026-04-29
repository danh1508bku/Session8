CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price NUMERIC,
    discount_percent INT
);


create or replace procedure calculate_discount(p_id INT, OUT p_final_price NUMERIC)
as $$
declare
	v_price numeric;
	v_discount_percent int;
begin 
	select price, discount_percent into v_price, v_discount_percent from products
	where id = p_id;

	if v_discount_percent > 50 then v_discount_percent := 50;
	end if;

	p_final_price := v_price - (v_price*v_discount_percent/100);
	
	update products
	set price = p_final_price
	where id = p_id;
end;
$$ language plpgsql;

INSERT INTO products (name, price, discount_percent) VALUES
('Áo', 100000, 10),
('Quần', 200000, 60),  -- sẽ bị giới hạn còn 50%
('Giày', 300000, 20);

CALL calculate_discount(2, NULL);
CALL calculate_discount(1, NULL);

select * from products;
