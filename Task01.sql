DROP DATABASE IF EXISTS company;
CREATE DATABASE IF NOT EXISTS company;

USE company;

DROP TABLE IF EXISTS departments;
CREATE TABLE IF NOT EXISTS departments
(
    id   INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(50)  NOT NULL,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS employees;
CREATE TABLE IF NOT EXISTS employees
(
    id            INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name          VARCHAR(50)  NOT NULL,
    salary        INT UNSIGNED NOT NULL,
    department_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (department_id) REFERENCES departments (id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO departments(name)
VALUES ('IT'),
       ('Sales');

INSERT INTO employees(name, salary, department_id)
VALUES ('Joe', 70000, 1),
       ('Henry', 80000, 2),
       ('Sam', 60000, 2),
       ('Max', 90000, 1);

SELECT d.name AS name, MAX(e.salary) AS salary
FROM employees e
         INNER JOIN departments d on e.department_id = d.id
GROUP BY e.department_id;