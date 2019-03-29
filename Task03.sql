DROP DATABASE IF EXISTS clients;
CREATE DATABASE IF NOT EXISTS clients DEFAULT CHARACTER SET utf8;

USE clients;

DROP TABLE IF EXISTS client;
CREATE TABLE IF NOT EXISTS client
(
    id    INT UNSIGNED NOT NULL AUTO_INCREMENT,
    login VARCHAR(50)  NOT NULL,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS base;
CREATE TABLE IF NOT EXISTS base
(
    id        INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name      VARCHAR(50)  NOT NULL,
    client_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (client_id) REFERENCES client (id) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS contact;
CREATE TABLE IF NOT EXISTS contact
(
    id      INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name    VARCHAR(50)  NOT NULL,
    phone   CHAR(11)     NOT NULL,
    base_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (base_id) REFERENCES base (id) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `group`;
CREATE TABLE IF NOT EXISTS `group`
(
    id   INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(50)  NOT NULL,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS contact_group;
CREATE TABLE IF NOT EXISTS contact_group
(
    contact_id INT UNSIGNED NOT NULL,
    group_id   INT UNSIGNED NOT NULL,
    PRIMARY KEY (contact_id, group_id),
    FOREIGN KEY (contact_id) REFERENCES contact (id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (group_id) REFERENCES `group` (id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO client(login)
VALUES ('Клиент 1'),
       ('Клиент 2');

INSERT INTO base(name, client_id)
VALUES ('База 1', 1),
       ('База 2', 1);

INSERT INTO contact(name, phone, base_id)
VALUES ('Иван Иванов', '79787951475', 1),
       ('Петр Петров', '79787951476', 1),
       ('Александр Коваль', '79785467890', 1),
       ('Вера Степанова', '79784102596', 1),
       ('Виктория Чернякова', '79784106696', 2),
       ('Татьяна Александрова', '79786543312', 2);

INSERT INTO `group`(name)
VALUES ('Семья'),
       ('Работа'),
       ('Друзья'),
       ('Часто используемые');

INSERT INTO contact_group(contact_id, group_id)
VALUES (1, 2),
       (1, 4),
       (3, 3),
       (4, 2),
       (4, 4),
       (5, 1),
       (5, 4),
       (6, 3);

-- Добавление/удаление/изменение контакта
INSERT INTO contact(name, phone, base_id) VALUE
    ('Евгений Куценко', '79883456708', 1);

UPDATE contact
SET phone='79783421106'
WHERE id = 7;

DELETE
FROM contact
WHERE id = 2;

-- Добавление/удаление/изменение контакта в группу
INSERT INTO contact_group(contact_id, group_id) VALUE
    (7, 3);

UPDATE contact_group
SET group_id=4
WHERE contact_id = 7;

DELETE
FROM contact_group
WHERE contact_id = 1;

-- Вывод групп с подсчетом количества контактов
SELECT g.name, COUNT(*) AS `count`
FROM `group` g
         INNER JOIN contact_group cg ON g.id = cg.group_id
         INNER JOIN contact c ON cg.contact_id = c.id
GROUP BY g.name;

-- Вывод группы “Часто используемые”, где выводятся топ10 контактов, на которые рассылают сообщения
SELECT c.name
FROM contact c
         INNER JOIN contact_group cg ON c.id = cg.contact_id
         INNER JOIN `group` g ON cg.group_id = g.id
WHERE g.name = 'Часто используемые'
LIMIT 1;

-- Поиск контактов по ФИО/номеру
SELECT name
FROM contact
WHERE phone = '79787951475';
SELECT phone
FROM contact
WHERE name LIKE '%Александрова%';

-- Выборка контактов по группе
SELECT c.name, c.phone
FROM contact c
         INNER JOIN contact_group cg ON c.id = cg.contact_id
         INNER JOIN `group` g ON cg.group_id = g.id
WHERE g.name = 'Семья';