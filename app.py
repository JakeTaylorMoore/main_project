from flask import Flask, render_template, url_for, json, redirect, request
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


@app.route('/update-artist/<int:artist_id>', methods=['POST', 'GET'])
def update_artist(artist_id):
    if request.method == "GET":
        return render_template("update-artist.j2", artist_id=artist_id)
    if request.method == "POST":
        # Get input from user
        input_title = request.form["title"]
        input_bio = request.form["bio"]
        input_genre = request.form["genre"]
        input_label = request.form["label"]
        # Send query to db
        query = "UPDATE Artists SET title=%s, bio=%s, genre=%s, label=%s WHERE artist_id=%"
        cur = mysql.connection.cursor()
        cur.execute(query, (input_title, input_bio, input_genre, input_label))
        mysql.connection.commit()

        # Redirect to artist page
        return redirect('/artist')


@app.route('/delete-artist/<int:id>')
def delete_artist(id):
    #mySQL query to delete the person with our passed id
    query = "DELETE from Artists WHERE artist_id = '%s';"
    cur = mysql.connection.cursor()
    cur.execute(query, (id,))
    mysql.connection.commit()
    return redirect('/artist')


@app.route('/users')
def users():
    return render_template("users.j2")


@app.route('/add-users')
def add_users():
    return render_template("add-user.j2")


@app.route('/update-user')
def update_user():
    return render_template("update-user.j2")


@app.route('/delete-user')
def delete_user():
    return render_template("delete-user.j2")


@app.route('/albums')
def albums():
    return render_template("albums.j2")


@app.route('/add-album')
def add_album():
    return render_template('add-album.j2')


@app.route('/update-album')
def update_album():
    return render_template('update-album.j2')


@app.route('/delete-album')
def delete_album():
    return render_template('delete-album.j2')


@app.route('/songs')
def songs():
    return render_template("songs.j2")


@app.route('/add-song')
def add_song():
    return render_template("add-song.j2")


@app.route('/update-song')
def update_song():
    return render_template("update-song.j2")


@app.route('/delete-song')
def delete_song():
    return render_template("delete-song.j2")


@app.route('/playlists')
def playlists():
    return render_template("playlists.j2")


@app.route('/add-playlist')
def add_playlist():
    return render_template("add-playlist.j2")


@app.route('/update-playlist')
def update_playlist():
    return render_template("update-playlist.j2")


@app.route("/delete-playlist")
def delete_playlist():
    return render_template("delete-playlist.j2")


if __name__ == '__main__':
    port = int(os.environ.get('PORT', 31523))
    app.run(port=port, debug=True)
