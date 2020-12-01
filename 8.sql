
-- 1 задание
--  Определить кто больше поставил лайков (всего) - мужчины или женщины?
SELECT p.gender, COUNT(p.gender) as total FROM likes as l 
	JOIN profiles as p ON (p.user_id = l.user_id && p.gender IN ('F','M'))
GROUP by p.gender
ORDER BY total DESC;
-- 2 задание
-- Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети
SELECT users.id,
	COUNT(DISTINCT posts.id) +
	COUNT(DISTINCT messages.to_user_id) +
	COUNT(DISTINCT media.id) +
	COUNT(DISTINCT likes.target_id) AS activity
FROM users
	LEFT JOIN media ON users.id = media.user_id
	LEFT JOIN posts ON users.id = posts.user_id
	LEFT JOIN messages ON users.id = messages.from_user_id
	LEFT JOIN likes ON users.id = likes.user_id	
GROUP BY users.id
ORDER BY activity
LIMIT 10;
-- 3 задание
-- Подсчитать общее количество лайков десяти самым молодым пользователям (сколько лайков получили 10 самых молодых пользователей).
SELECT users.id, first_name, last_name, COUNT(target_types.id) AS total_likes, profiles.birthday 
  FROM users
            LEFT JOIN profiles
          ON users.id = profiles.user_id 
    LEFT JOIN likes
      ON users.id = likes.target_id
    LEFT JOIN target_types
      ON likes.target_type_id = target_types.id
       AND target_types.name = 'users'
  GROUP BY users.id
  HAVING total_likes 
  ORDER BY profiles.birthday DESC
  LIMIT 10;
