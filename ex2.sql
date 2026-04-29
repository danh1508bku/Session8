CREATE TABLE inventory (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    quantity INT
);

create or replace procedure check_stock(p_id INT, p_qty INT)
as $$
declare
	v_qty int;
begin
	select quantity into v_qty from inventory
	where product_id = p_id;

	if v_qty<p_qty then raise exception 'Không đủ hàng trong kho';
	end if;

	raise notice 'Đủ hàng trong kho';
end;
$$ language plpgsql;

INSERT INTO inventory (product_name, quantity) VALUES
('Trà sữa', 10),
('Cà phê', 5);

CALL check_stock(1, 3);
CALL check_stock(2, 10);
