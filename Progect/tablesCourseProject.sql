-- База данных телеграмма представляет собой множество видов обмены информации как с одним человеком,
-- так и с несколькими людьми срузу путем создания групп и каналов, сохраниния важной информации "избранное" и возможность секретного чата
-- с автоматически удаляемыми сообщениями
CREATE DATABASE telegram;

USE telegram;
SHOW TABLES;
-- создаем таблицу пользователей
DROP TABLE IF EXISTS users;
CREATE TABLE `users` (
`id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `first_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Имя пользователя',
  `last_name` varchar(100) COLLATE utf8_unicode_ci  COMMENT 'Фамилия пользователя',
  `phone` varchar(100) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Телефон',
  `link` varchar(100) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Линк',
  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`),
  UNIQUE KEY `link` (`link`),
  UNIQUE KEY `phone` (`phone`)
  ) ENGINE=InnoDB;
  
  -- создаем таблицу групп
  
 DROP TABLE if exists groupss;
 CREATE TABLE `groupss` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `user_id` int(10) unsigned NOT NULL COMMENT 'Идентификатор пользователя',
  `group_name` varchar(100) COLLATE utf8_unicode_ci  COMMENT 'Имя группы',
  `messages_group_id`int(10) unsigned NOT NULL COMMENT 'сообщение в группе',
  `link_group` varchar(100) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Линк',
  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`),
  UNIQUE KEY `link_group` (`link_group`)
  ) ENGINE=InnoDB;
  -- создаем таблицу сообщений
  -- в послледствии будет добавлен тригер на то что строка 'body' и строка 'mediafile' не должны быть оба нулевыми 
  DROP TABLE IF EXISTS messages;
  CREATE TABLE `messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `from_user_id` int(10) unsigned NOT NULL COMMENT 'Ссылка на отправителя сообщения',
  `to_user_id` int(10) unsigned NOT NULL COMMENT 'Ссылка на получателя сообщения',
  `body` text COLLATE utf8_unicode_ci COMMENT 'Текст сообщения',
  `media_file_id`  int(10) unsigned COMMENT 'Медиа файл',
  `is_reading` tinyint(1) DEFAULT NULL COMMENT 'Признак прочитанности',
  `is_delivered` tinyint(1) DEFAULT NULL COMMENT 'Признак доставки',
  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Время создания строки',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Сообщения';

-- создаем таблицу медиа
DROP TABLE IF EXISTS media_file;
CREATE TABLE `media_file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `user_id` int(10) unsigned NOT NULL COMMENT 'Ссылка на пользователя, который загрузил файл',
  `filename` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Путь к файлу',
  `size` int(11) NOT NULL COMMENT 'Размер файла',
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Метаданные файла' CHECK (json_valid(`metadata`)),
  `media_type_id` int(10) unsigned NOT NULL COMMENT 'Ссылка на тип контента',
  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

-- Создаем таблицу типов медиа данных
DROP TABLE IF EXISTS media_type;
CREATE TABLE `media_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Название типа',
  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Типы медиафайлов';

-- Создаем таблицу Каналов
DROP TABLE IF EXISTS channels;
 CREATE TABLE `channels` (
`id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `user_id` int(10) unsigned NOT NULL COMMENT 'Идентификатор пользователя',
  `channel_name` varchar(100) COLLATE utf8_unicode_ci  COMMENT 'Имя группы',
   `posts_id`  int(10) unsigned COMMENT 'Пост',
  `link_channel` varchar(100) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Линк',
  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`),
  UNIQUE KEY `link_channel` (`link_channel`)
 );
 
 -- Создаем таблицу постов
 DROP TABLE IF EXISTS posts;
 CREATE TABLE `posts` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `user_id` INT UNSIGNED NOT NULL COMMENT 'идентификатор пользователя',
  `body` text COLLATE utf8_unicode_ci COMMENT 'Текст поста',
  `media_file_id` INT UNSIGNED COMMENT 'Медиа файл',
  `is_public` BOOLEAN DEFAULT TRUE,
  `is_archived` BOOLEAN DEFAULT FALSE,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (`id`)
);

-- создаем таблицу избранное 
-- в дальнейшем будет тригер что если в таблице message from и to _user_id совпадают то сторока 
-- добавляется в избранное(что то тип сообщения самому себе)
DROP TABLE IF EXISTS favorites;
  CREATE TABLE `favorites` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `user_id` int(10) unsigned NOT NULL COMMENT 'Ссылка на отправителя сообщения',
  `messages_id`  int(10) unsigned COMMENT 'Медиа файл',
  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Время создания строки',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Сообщения';

-- создаем таблицу сообщений в группе
DROP TABLE IF EXISTS messages_group;
  CREATE TABLE `messages_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `user_id` int(10) unsigned NOT NULL COMMENT 'Ссылка на отправителя сообщения',
  `body` text COLLATE utf8_unicode_ci COMMENT 'Текст сообщения',
  `media_file_id`  int(10) unsigned COMMENT 'Медиа файл',
  `is_reading` tinyint(1) DEFAULT NULL COMMENT 'Признак прочитанности',
  `is_delivered` tinyint(1) DEFAULT NULL COMMENT 'Признак доставки',
  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Время создания строки',
  PRIMARY KEY (`id`)
) ;
-- создаем таблицу comments
DROP TABLE IF EXISTS comments;
CREATE TABLE `comments` (
`id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
 `user_id` int(10) unsigned NOT NULL COMMENT 'Ссылка на отправителя сообщения',
  `posts_id`  int(10) unsigned COMMENT 'Пост',
  `body` text COLLATE utf8_unicode_ci COMMENT 'Текст сообщения',
  `media_file_id`  int(10) unsigned COMMENT 'Медиа файл',
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (`id`)
);
