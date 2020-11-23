-- 1 задание
USE shop;
SHOW TABLES;

SELECT * FROM users;
UPDATE users SET created_at=NULL,updated_at=NULL;
UPDATE users SET created_at = NOW(), updated_at = NOW();
SELECT * FROM users;
-- 2 задание
UPDATE users SET created_at = STR_TO_DATE(created_at, '%d.%m.%Y %H:%i'); 
UPDATE users SET updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %H:%i');
ALTER TABLE users MODIFY created_at DATETIME DEFAULT CURRENT_TIMESTAMP; 
ALTER TABLE users MODIFY updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
-- 3 задание
 SELECT * FROM storehouses_products;
 SELECT id, value, IF(value > 0,0,1) AS sort FROM storehouses_products ORDER BY value;
 -- Агрегация данных
-- 1 задание
ALTER TABLE users ADD age INT NOT NULL;

UPDATE users SET age = TIMESTAMPDIFF(YEAR, birthday_at, NOW());

SELECT AVG(age) FROM users;
-- 2 задание
SELECT CASE WEEKDAY(birthday_at) WHEN 0 THEN 'Понедельник' WHEN 1 THEN 'Вторник' WHEN 2 THEN 'Среда' WHEN 3 THEN 'Четверг' WHEN 4 THEN 'Пятница' WHEN 5 THEN 'Суббота' WHEN 6 THEN 'Воскресенье' ELSE -1 END as wd, COUNT(birthday_at) as num FROM users GROUP BY wd ORDER BY FIELD(wd,'Понедельник','Вторник','Среда','Четверг','Пятница','Суббота','Воскресенье');
