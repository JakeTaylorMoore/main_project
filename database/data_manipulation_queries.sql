-- CREATE
-- add album
INSERT INTO albums (album_id, title, release_date)
VALUES (:album_id_input, :title_input, :release_date_input);

-- add user
INSERT INTO users (user_id, last_name, email, created_at, password)
VALUES (:user_id_input, :last_name_input, :email_input, :created_at_input, :password_input);

-- add artist
INSERT INTO artists (artist_id, title, bio, genre, label)
VALUES (:artist_id_input, :title_input, :bio_input, :genre_input, :label_input)

-- add playlist
INSERT INTO playlists (playlist_id, created_at, title, user_id)
VALUES (:playlist_id, :created_at, :title, :user_id)

-- add song
INSERT INTO songs (song_id, title, length, release_date, album_id)
VALUES (:song_id, :title, :length, :release_date, :album_id)

-- READ
-- get all Album IDS, name, release date
SELECT album_id, title, release_date FROM albums;

-- get all User IDS and account info for all users
SELECT user_id, last_name, email, created_at, password FROM users
ORDER BY first_name ASC;

-- get all Artist IDs and artist info
SELECT artist_id, title, bio, genre, label FROM artists
ORDER BY title ASC;

-- get all Playlist IDs and playlist info
SELECT playlist_id, created_at, title, user_id FROM playlists
ORDER BY title ASC;

-- get all Song IDs and Song info
SELECT song_id, title, length, release_date, album_id FROM songs
ORDER BY title ASC;

-- UPDATE
-- update album
UPDATE albums 
SET title= :title_input, release_date= release_date_input
WHERE album_id= :albun_id_input;

-- update user
UPDATE users 
SET last_name= :last_name_input, email= :email_input, created_at= :created_at_input
WHERE user_id= :user_id_input

-- update artist
UPDATE artists
SET title= :title_input, length= length_input, release_date= :release_date_input
WHERE artist_id= :artist_id_input

-- update playlist
UPDATE playlists
SET created_at= :created_at_input, title= :title_input
WHERE playlist_id= :playlist_id_input

-- update song
UPDATE songs
SET title= :title_input, length= :length_input, release_date= :release_date_input
WHERE song_id= :song_id_input

-- DELETE
-- delete album
DELETE FROM albums
WHERE album_id = :album_id_input;

-- delete user
DELETE FROM users
WHERE user_id = :user_id_input;

-- delete artist
DELETE FROM artists
WHERE artist_id = :artist_id_input;

-- delete playlist
DELETE FROM playlists
WHERE playlist_id = :playlist_id_input;

-- delete song
DELETE FROM songs
WHERE song_id = :song_id_input;
