USE telegram;
-- здесь я удаляю 101-103 строки
DELETE FROM media_type WHERE id>20;
-- тут добавляю 1-3 и правильные имена
INSERT INTO media_type (id,name) VALUES
(1,'photo'),
(2,'video'),
(3,'audio');
-- Апдейты некоторых таблиц

UPDATE messages_group SET user_id = FLOOR(1 + (RAND() * 50));
UPDATE messages_group SET media_file_id = FLOOR(1 + (RAND() * 50));
UPDATE messages SET from_user_id = FLOOR(1 + (RAND() * 50));
UPDATE posts SET user_id = FLOOR(1 + (RAND() * 50));
UPDATE favorites SET user_id = FLOOR(1 + (RAND() * 50));
UPDATE posts SET media_file_id = FLOOR(1 + (RAND() * 50));
UPDATE favorites SET messages_id  = FLOOR(100 + (RAND() * 100));
UPDATE media_file SET media_type_id = FLOOR(1 + (RAND() * 3));
UPDATE media_file SET user_id = FLOOR(1 + (RAND() * 50));
