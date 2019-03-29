DROP DATABASE IF EXISTS company;
CREATE DATABASE IF NOT EXISTS company;

USE company;

DROP TABLE IF EXISTS employees;
CREATE TABLE IF NOT EXISTS employees
(
    id         INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name       VARCHAR(50)  NOT NULL,
    salary     INT UNSIGNED NOT NULL,
    manager_id INT UNSIGNED DEFAULT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (manager_id) REFERENCES employees (id) ON DELETE RESTRICT ON UPDATE RESTRICT
);

INSERT INTO employees(name, salary)
VALUES ('Joe', 70000),
       ('Henry', 80000),
       ('Sam', 60000),
       ('Max', 90000);

UPDATE employees
SET manager_id = 3
WHERE id = 1;

UPDATE employees
SET manager_id = 4
WHERE id = 2;

SELECT e1.name
FROM employees e1
         INNER JOIN employees e2 ON e1.manager_id = e2.id
WHERE e1.salary > e2.salary;