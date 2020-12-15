-- Тригеры
-- 1 body и media_file_id не могут быть пустыми в messages
DELIMITER //
CREATE TRIGGER messages_incert BEFORE INSERT ON messages
FOR EACH ROW
BEGIN
	IF(ISNULL(NEW.body) AND ISNULL(NEW.media_file_id)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Оба поля не могут быть пустыми';
	END IF;
END //
DELIMITER ;
-- такой же тригер для сообщения в группе(messages_group)
DELIMITER //
CREATE TRIGGER messages_group_incert BEFORE INSERT ON messages_group
FOR EACH ROW
BEGIN
	IF(ISNULL(NEW.body) AND ISNULL(NEW.media_file_id)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Оба поля не могут быть пустыми';
	END IF;
END //
DELIMITER ;
-- и абсолютно такой же для постов, так как они не могут быть пустыми
DELIMITER //
CREATE TRIGGER post_incert BEFORE INSERT ON posts
FOR EACH ROW
BEGIN
	IF(ISNULL(NEW.body) AND ISNULL(NEW.media_file_id)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Оба поля не могут быть пустыми';
	END IF;
END //
DELIMITER ;
-- Favorites грубо говоря это без учета пересланных сообщений - это сообщения самому себе
-- следовательно при совпадении to и from users id в таблицe messages строка должно автоматически  
DELIMITER //
CREATE TRIGGER messages_insert AFTER INSERT ON messages
FOR EACH ROW
BEGIN
	IF(ISNULL(NEW.from_user_id) = ISNULL(NEW.to_user_id)) THEN 
    INSERT INTO favorites VALUES (DEFAULT, NEW.from_user_id, NEW.id, DEFAULT) ;
   END IF;
END //
DELIMITER ;
DROP TRIGGER telegram.messages_insert;  
