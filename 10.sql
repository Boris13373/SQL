-- 1 задание 
CREATE INDEX profiles_birthday_idx ON profiles(birthday);
CREATE INDEX profiles_city_idx ON profiles(city);
-- думаю еще часто ищут по тексту сообщения
CREATE INDEX messages_body_idx ON messages(body(10));
-- 2 задание
SELECT DISTINCT communities.name,
COUNT(communities_users.community_id) OVER w / MAX(users.id) OVER () * 100 AS "% от всех пользователей",
MAX(profiles.birthday) OVER w AS "Самый молодой пользователь",
MIN(profiles.birthday) OVER w AS "Самый старший пользователь",
COUNT(communities_users.community_id) OVER w AS "Всего в группе",
MAX(users.id) OVER () AS "Всего пользователей",
AVG( communities_users.user_id) OVER() AS "ss"
FROM communities_users, users
JOIN communities, profiles
WHERE communities.id = communities_users.community_id AND profiles.user_id = communities_users.user_id AND users.id = profiles.user_id 
WINDOW w AS (PARTITION BY communities.name);
-- Среднее колличество пользователей я к сожалению не смог посчитать, сколько ни пытался все равно выходит что-то не то.