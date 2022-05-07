from flask import Flask, render_template, url_for, json
import os
import database.db_connector as db
db_connection = db.connect_to_database()


app = Flask(__name__)


# page routes


@app.route('/')
def index():
    return render_template("index.html")


@app.route('/artist')
def artists():
    return render_template("artist.j2")
    # # Select query for artists
    # query = "SELECT * from Artists;"
    # cursor = db.execute_query(db_connection=db_connection, query=query)
    # results = cursor.fetchall()
    # return render_template("artist.j2", Artists = results)



@app.route('/add-artist')
def add_artist():
    return render_template("add-artist.j2")


@app.route('/update-artist')
def update_artist():
    return render_template("update-artist.j2")


@app.route('/delete-artist')
def delete_artist():
    return render_template("delete-artist.j2")


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
    port = int(os.environ.get('PORT', 8829))
    app.run(port=port, debug=True)
