-- get all Album IDS, name, release date
SELECT album_id, title, release_date FROM albums;

-- get all User IDS and account info for all users
SELECT user_id, last_name, email, created_at, password FROM users
ORDER BY first_name ASC;

-- get all Artist IDs and artist info
SELECT artist_id, title, bio, genre, label FROM artists
ORDER BY title ASC;

-- get all Playlist IDs and playlist info
