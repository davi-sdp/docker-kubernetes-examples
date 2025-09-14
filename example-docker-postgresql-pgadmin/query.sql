select version();

CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    hire_date DATE DEFAULT CURRENT_DATE
);

select * from employees;

INSERT INTO employees (first_name, last_name, email) VALUES ('João', 'Silva', 'silva.joao@gmail.com');
INSERT INTO employees (first_name, last_name, email) VALUES ('Maria', 'Santos', 'santos.maria@gmail.com');