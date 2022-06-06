from flask import Flask, render_template, url_for, json, redirect, request
import datetime
from flask_mysqldb import MySQL
import os
import database.db_connector as db

db_connection = db.connect_to_database()
from dotenv import load_dotenv, find_dotenv

load_dotenv(find_dotenv())

app = Flask(__name__)

#

mysql = MySQL(app)

# #
app.config['MYSQL_HOST'] = os.environ.get("LOCALHOST")
app.config['MYSQL_USER'] = os.environ.get("ROOT")
app.config['MYSQL_PASSWORD'] = os.environ.get("PASS")
app.config['MYSQL_DB'] = os.environ.get("AUDIOCAT_DB")
app.config["MYSQL_CURSORCLASS"] = "DictCursor"


# page routes


@app.route('/')
def index():
    return render_template("index.html")


@app.route('/artist', methods=['POST', 'GET'])
def artists():
    # Select query for artists
    query = "SELECT * FROM Artists;"
    cur = mysql.connection.cursor()
    cur.execute(query)
    data = cur.fetchall()
    # cursor = db.execute_query(db_connection=db_connection, query=query)
    # results = cursor.fetchall()
    return render_template("artist.j2", Artists=data)


@app.route('/add-artist', methods=["POST", "GET"])
def add_artist():
    if request.method == "GET":
        return render_template("add-artist.j2")

    if request.method == "POST":
        # Get input from user
        input_title = request.form["title"]
        input_bio = request.form["bio"]
        input_genre = request.form["genre"]
        input_label = request.form["label"]
        # Send query to db
        query = "INSERT INTO Artists (title, bio, genre, label) VALUES (%s, %s, %s, %s)"
        cur = mysql.connection.cursor()
        cur.execute(query, (input_title, input_bio, input_genre, input_label))
        mysql.connection.commit()

        # Redirect to artist page
        return redirect('/artist')


@app.route('/update-artist/<int:_id>', methods=['POST', 'GET'])
def update_artist(_id):
    # Retrieve artist to set locally
    artist_query = f"SELECT * FROM Artists"
    cur = mysql.connection.cursor()
    cur.execute(artist_query)
    # Get list of artist that match id and then convert back to dict
    artist = [artist for artist in cur.fetchall() if artist["artist_id"] == _id]
    artist = artist[0]

    if request.method == "POST":
        # Get input from user
        input_title = request.form["title"]
        input_bio = request.form["bio"]
        input_genre = request.form["genre"]
        input_label = request.form["label"]
        # Send query to db
        query = "UPDATE Artists SET title=%s, bio=%s, genre=%s, label=%s WHERE artist_id=%s"
        cur = mysql.connection.cursor()
        cur.execute(query, (input_title, input_bio, input_genre, input_label, _id))
        mysql.connection.commit()
        # Redirect to artist page
        return redirect('/artist')
    return render_template("update-artist.j2", artist=artist)


@app.route('/delete-artist/<int:id>')
def delete_artist(id):
    # mySQL query to delete the person with our passed id
    query = "DELETE from Artists WHERE artist_id = '%s';"
    cur = mysql.connection.cursor()
    cur.execute(query, (id,))
    mysql.connection.commit()
    return redirect('/artist')


@app.route('/users')
def users():
    query = "SELECT * FROM Users;"
    cur = mysql.connection.cursor()
    cur.execute(query)
    data = cur.fetchall()
    return render_template("users.j2", Users=data)


@app.route('/add-user', methods=["POST", "GET"])
def add_users():
    if request.method == "GET":
        return render_template("add-user.j2")

    if request.method == "POST":
        input_fname = request.form["fname"]
        input_lname = request.form["lname"]
        input_email = request.form["email"]
        input_created_at = request.form["created_at"]
        input_password = request.form["password"]
        query = "INSERT INTO Users (first_name, last_name, email, created_at, password) VALUES (%s, %s, %s, %s, %s)"
        cur = mysql.connection.cursor()
        cur.execute(query, (input_fname, input_lname, input_email, input_created_at, input_password))
        mysql.connection.commit()
        return redirect('/users')


@app.route('/update-user/<int:_id>', methods=['POST', 'GET'])
def update_user(_id):
    user_query = f"SELECT * FROM Users"
    cur = mysql.connection.cursor()
    cur.execute(user_query)
    user = [user for user in cur.fetchall() if user["user_id"] == _id]
    user = user[0]

    if request.method == "POST":
        input_fname = request.form["fname"]
        input_lname = request.form["lname"]
        input_email = request.form["email"]
        input_created_at = request.form["created_at"]
        input_password = request.form["password"]
        query = "UPDATE Users SET first_name=%s, last_name=%s, email=%s, created_at=%s, password=%s WHERE user_id=%s"
        cur = mysql.connection.cursor()
        cur.execute(query, (input_fname, input_lname, input_email, input_created_at, input_password, _id))
        mysql.connection.commit()
        return redirect('/users')
    return render_template("update-user.j2", user=user)


@app.route('/delete-user/<int:id>')
def delete_user(id):
    query = "DELETE from Users WHERE user_id = '%s';"
    cur = mysql.connection.cursor()
    cur.execute(query, (id,))
    mysql.connection.commit()
    return redirect('/users')


@app.route('/albums')
def albums():
    query = "SELECT * FROM Albums;"
    cur = mysql.connection.cursor()
    cur.execute(query)
    data = cur.fetchall()
    print(data)
    return render_template("albums.j2", Albums=data)


@app.route('/add-album', methods=['POST', 'GET'])
def add_album():
    if request.method == "GET":
        return render_template('add-album.j2')

    if request.method == "POST":
        input_title = request.form["title"]
        input_release_date = request.form["release_date"]
        query = "INSERT INTO Albums (title, release_date) VALUES (%s, %s)"
        cur = mysql.connection.cursor()
        cur.execute(query, (input_title, input_release_date))
        mysql.connection.commit()

        return redirect('/albums')


@app.route('/update-album/<int:_id>', methods=['POST', 'GET'])
def update_album(_id):
    album_query = f"SELECT * FROM Albums"
    cur = mysql.connection.cursor()
    cur.execute(album_query)
    album = [album for album in cur.fetchall() if album["album_id"] == _id]
    album = album[0]

    if request.method == "POST":
        input_title = request.form["title"]
        input_release_date = request.form["release_date"]
        query = "UPDATE Albums SET title=%s, release_date=%s WHERE album_id=%s"
        cur = mysql.connection.cursor()
        cur.execute(query, (input_title, input_release_date, _id))
        mysql.connection.commit()
        return redirect('/albums')

    return render_template('update-album.j2', album=album)


@app.route('/delete-album/<int:id>')
def delete_album(id):
    query = "DELETE FROM Albums WHERE album_id = %s;"
    cur = mysql.connection.cursor()
    cur.execute(query, (id,))
    mysql.connection.commit()
    return redirect('/albums')


@app.route('/songs')
def songs():
    query_one = f"SELECT * FROM Songs;"
    cur = mysql.connection.cursor()
    cur.execute(query_one)
    data = cur.fetchall()
    query_two = f"SELECT * FROM Artists_Songs;"
    cur = mysql.connection.cursor()
    cur.execute(query_two)
    Artists_Songs = cur.fetchall()
    return render_template("songs.j2", Songs=data, Artists_Songs=Artists_Songs)


@app.route('/add-song', methods=['POST', 'GET'])
def add_song():
    if request.method == "GET":
        return render_template('add-song.j2')

    if request.method == "POST":
        input_title = request.form["title"]
        input_length = request.form["song_length"]
        input_release_date = request.form["release_date"]
        query = "INSERT INTO Songs (title, song_length, release_date) VALUES (%s, %s, %s)"
        cur = mysql.connection.cursor()
        cur.execute(query, (input_title, input_length, input_release_date))
        mysql.connection.commit()

        return redirect('/songs')


@app.route('/update-song/<int:_id>', methods=['POST', 'GET'])
def update_song(_id):
    song_query = f"SELECT * FROM Songs"
    cur = mysql.connection.cursor()
    cur.execute(song_query)
    song = [song for song in cur.fetchall() if song["song_id"] == _id]
    song = song[0]

    if request.method == "POST":
        input_title = request.form["title"]
        input_length = request.form["song_length"]
        input_release_date = request.form["release_date"]
        query = "UPDATE Songs SET title=%s, song_length=%s, release_date=%s WHERE song_id=%s"
        cur = mysql.connection.cursor()
        cur.execute(query, (input_title, input_length, input_release_date, _id))
        mysql.connection.commit()
        return redirect('/songs')

    return render_template('update-song.j2', song=song)


@app.route('/delete-song/<int:id>')
def delete_song(id):
    query = "DELETE FROM Songs WHERE song_id = %s;"
    cur = mysql.connection.cursor()
    cur.execute(query, (id,))
    mysql.connection.commit()
    return redirect('/songs')


@app.route('/playlists')
def playlists():
    query = "SELECT * FROM Playlists;"
    cur = mysql.connection.cursor()
    cur.execute(query)
    data = cur.fetchall()
    print(data)
    return render_template("playlists.j2", Playlists=data)


@app.route('/add-playlist', methods=['POST', 'GET'])
def add_playlist():
    if request.method == "GET":
        return render_template('add-playlist.j2')

    if request.method == "POST":
        input_created_at = request.form["created_at"]
        input_title = request.form["title"]
        input_user_id = request.form["user_id"]
        query = "INSERT INTO Playlists (created_at, title, user_id) VALUES (%s, %s, %s)"
        cur = mysql.connection.cursor()
        cur.execute(query, (input_created_at, input_title, input_user_id))
        mysql.connection.commit()

        return redirect('/playlists')


@app.route('/update-playlist/<int:_id>', methods=['POST', 'GET'])
def update_playlist(_id):
    playlist_query = f"SELECT * FROM Playlists"
    cur = mysql.connection.cursor()
    cur.execute(playlist_query)
    playlist = [playlist for playlist in cur.fetchall() if playlist["playlist_id"] == _id]
    playlist = playlist[0]

    if request.method == "POST":
        input_created_at = request.form["created_at"]
        input_title = request.form["title"]
        input_user_id = request.form["user_id"]
        query = "UPDATE Playlists SET created_at=%s, title=%s, user_id=%s WHERE playlist_id=%s"
        cur = mysql.connection.cursor()
        cur.execute(query, (input_created_at, input_title, input_user_id, _id))
        mysql.connection.commit()
        return redirect('/playlists')

    return render_template('update-playlist.j2', playlist=playlist)


@app.route('/delete-playlist/<int:id>')
def delete_playlist(id):
    query = "DELETE FROM Playlists WHERE playlist_id = %s;"
    cur = mysql.connection.cursor()
    cur.execute(query, (id,))
    mysql.connection.commit()
    return redirect('/playlists')


@app.route('/add-artist-song', methods=['POST', 'GET'])
def add_artist_song():
    if request.method == "GET":
        return render_template('add-artist-song.j2')

    if request.method == "POST":
        input_artist_id = request.form["artist_id"]
        input_song_id = request.form["song_id"]
        query = "INSERT INTO Artists_Songs (artist_id, song_id) VALUES (%s, %s)"
        cur = mysql.connection.cursor()
        cur.execute(query, (input_artist_id, input_song_id))
        mysql.connection.commit()

        return redirect('/songs')


@app.route('/update-artist-song/<int:_id>', methods=['POST', 'GET'])
def update_artist_song(_id):
    artist_song_query = f"SELECT * FROM Artists_Songs"
    cur = mysql.connection.cursor()
    cur.execute(artist_song_query)
    artist_song = [artist_song for artist_song in cur.fetchall() if artist_song["artist_song_id"] == _id]
    artist_song = artist_song[0]

    if request.method == "POST":
        input_artist_id = request.form["artist_id"]
        input_song_id = request.form["song_id"]
        query = "UPDATE Artists_Songs SET artist_id=%s, song_id=%s WHERE artist_song_id=%s"
        cur = mysql.connection.cursor()
        cur.execute(query, (input_artist_id, input_song_id, _id))
        mysql.connection.commit()
        return redirect('/songs')

    return render_template('update-artist-song.j2', Artist_Song=artist_song)


@app.route('/delete-artist-song/<int:id>')
def delete_artist_song(id):
    query = "DELETE FROM Artists_Songs WHERE artist_song_id = %s;"
    cur = mysql.connection.cursor()
    cur.execute(query, (id,))
    mysql.connection.commit()
    return redirect('/songs')


@app.context_processor
def inject_today_date():
    return {'today_date': datetime.date.today()}


if __name__ == '__main__':
    port = int(os.environ.get('PORT', 31523))
    app.run(port=port, debug=True)
