USE telegram;
-- добавляем внешние ключи
-- таблица groups
ALTER TABLE groupss 
  ADD CONSTRAINT group_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT group_message_id_fk 
    FOREIGN KEY (messages_group_id) REFERENCES messages_group(id);
-- таблица messages 
ALTER TABLE messages
  ADD CONSTRAINT messages_from_user_id_fk 
    FOREIGN KEY (from_user_id) REFERENCES users(id);
   ALTER TABLE messages
  ADD CONSTRAINT messages_to_user_id_fk 
    FOREIGN KEY (to_user_id) REFERENCES users(id);
   ALTER TABLE messages 
  ADD CONSTRAINT messages_media_file_id_fk 
    FOREIGN KEY (media_file_id) REFERENCES media_file(id);
 -- таблица media_file
 ALTER TABLE media_file 
  ADD CONSTRAINT media_file_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT media_file_type_id_3_fk 
    FOREIGN KEY (media_type_id) REFERENCES media_type(id);
  -- таблица channel
   ALTER TABLE channels 
  ADD CONSTRAINT channel_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT channel_post_id_fk 
    FOREIGN KEY (posts_id) REFERENCES posts(id);
  -- таблица posts
   ALTER TABLE posts 
  ADD CONSTRAINT post_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id);
                     ALTER TABLE posts DROP FOREIGN KEY post_user_id_fk;
   ALTER TABLE posts 
  ADD CONSTRAINT post_media_file_id_fk 
    FOREIGN KEY (media_file_id) REFERENCES media_file(id);
      -- таблица favorites
   ALTER TABLE favorites 
  ADD CONSTRAINT favorites_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT favorites_messages_id_fk 
    FOREIGN KEY (messages_id) REFERENCES messages(id);
-- таблица messages_group
      ALTER TABLE messages_group 
  ADD CONSTRAINT messages_group_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id);
   ALTER TABLE messages_group 
      ADD CONSTRAINT messages_groups_media_file_id_fk 
    FOREIGN KEY (media_file_id) REFERENCES media_file(id);

 -- таблица comments 
   ALTER TABLE comments 
   ADD CONSTRAINT comments_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id),
   ADD CONSTRAINT comments_media_file_fk
    FOREIGN KEY (media_file_id) REFERENCES media_file(id);
   ALTER TABLE comments 
   ADD CONSTRAINT comments_post_id_fk
    FOREIGN KEY (posts_id) REFERENCES posts(id);

   