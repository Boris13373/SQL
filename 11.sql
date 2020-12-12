-- Оптимизация запросов
-- 1 задание
USE shop;
CREATE TABLE logs (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    created_at datetime DEFAULT CURRENT_TIMESTAMP,
    table_name varchar(50) NOT NULL,
    row_id INT UNSIGNED NOT NULL,
    row_name varchar(255)
) ENGINE = Archive;
CREATE TRIGGER inusers AFTER INSERT ON users
FOR EACH ROW
BEGIN
    INSERT INTO logs VALUES (NULL, DEFAULT, "users", NEW.id, NEW.name);
END;

CREATE TRIGGER incatalogs AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
    INSERT INTO logs VALUES (NULL, DEFAULT, "catalogs", NEW.id, NEW.name);
END;

CREATE TRIGGER inproducts AFTER INSERT ON products
FOR EACH ROW
BEGIN
    INSERT INTO logs VALUES (NULL, DEFAULT, "products", NEW.id, NEW.name);
END;
-- NoSQL
-- 1
127.0.0.1:6379> HINCRBY adress '12.45.45' 1
(integer) 1
127.0.0.1:6379> HGETALL adress
1) "12.45.45"
2) "1"
127.0.0.1:6379> HINCRBY adress '12.50.50' 1
(integer) 1
127.0.0.1:6379> HGETALL adress
1) "12.45.45"
2) "1"
3) "12.50.50"
4) "1"
127.0.0.1:6379> HGET adress '12.50.50'
"1"
127.0.0.1:6379> 

-- 2 задание 
127.0.0.1:6379> HSET emails 'boris' 'boris42322@mail.ru'
(integer) 1
127.0.0.1:6379> HSET emails 'ivan' 'ivan42322@yandex.ru'
(integer) 1
127.0.0.1:6379> HGET emails 'boris'
"boris42322@mail.ru"
127.0.0.1:6379> HGET emails 'ivan'
"ivan42322@yandex.ru"
127.0.0.1:6379> HSET users 'lena@yandex.ru' 'lena'
(integer) 1
127.0.0.1:6379> HGET users 'lena@yandex.ru'
"lena"
