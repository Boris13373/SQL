USE telegram;
-- фото, видео или аудио? каких меди файло больше всего?
SELECT media_type.id, COUNT( media_file.media_type_id) AS total , media_type.name
FROM media_file 
LEFT JOIN
media_type
ON media_file.media_type_id = media_type.id 
GROUP BY  media_type.id;
-- создаем индексы
-- в телеграмме все ищут по линкам (если это имя пользователя) и по названию, если это канал 
CREATE INDEX user_link_idx ON users(link);
CREATE INDEX user_name_idx ON users(first_name);
CREATE INDEX channels_name_idx ON channels(channel_name);
-- кто больше всего отправил медиа файлов
SELECT users.id,users.first_name ,
	COUNT(DISTINCT posts.media_file_id) +
	COUNT(DISTINCT messages.media_file_id) +
	COUNT(DISTINCT messages_group.media_file_id)  AS activity
FROM users
	LEFT JOIN media_file ON users.id = media_file.user_id
	LEFT JOIN posts ON users.id = posts.user_id
	LEFT JOIN messages ON users.id = messages.from_user_id
	LEFT JOIN messages_group ON users.id = messages_group.user_id	
GROUP BY users.id
ORDER BY activity DESC
LIMIT 10;
--
