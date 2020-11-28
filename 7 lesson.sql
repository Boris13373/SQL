USE shop;
SELECT * FROM users;
SELECT * FROM orders;
SELECT * FROM products;
SELECT * FROM catalogs;
-- 1 задание
SELECT 
o.user_id,
u.name,
u.id
FROM 
orders  AS o
join
users AS u
WHERE
u.id = o.user_id
;
-- 2 задание
SELECT 
p.name,
c.name
FROM 
products AS p
join
catalogs AS c
WHERE
c.id = p.catalog_id 
;