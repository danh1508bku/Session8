CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(100),
    job_level INT,
    salary NUMERIC
);

CREATE OR REPLACE PROCEDURE adjust_salary(
    IN p_emp_id INT,
    OUT p_new_salary NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_salary NUMERIC;
    v_level INT;
BEGIN
    SELECT salary, job_level
    INTO v_salary, v_level
    FROM employees
    WHERE emp_id = p_emp_id;

    IF v_level = 1 THEN
        p_new_salary := v_salary * 1.05;
    ELSIF v_level = 2 THEN
        p_new_salary := v_salary * 1.10;
    ELSIF v_level = 3 THEN
        p_new_salary := v_salary * 1.15; 
    END IF;

    UPDATE employees
    SET salary = p_new_salary
    WHERE emp_id = p_emp_id;

END;
$$;

INSERT INTO employees (emp_name, job_level, salary) VALUES
('An', 1, 10000),
('Bình', 2, 15000),
('Cường', 3, 20000);

CALL adjust_salary(3, null);

select * from employees;
