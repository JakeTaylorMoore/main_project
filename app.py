from flask import Flask, render_template, url_for
import os


app = Flask(__name__)

# page routes


@app.route('/')
def index():
    return render_template("index.html")


@app.route('/artist')
def artists():
    return render_template("artist.j2")


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


@app.route('/albums')
def albums():
    return render_template("albums.j2")


@app.route('/playlists')
def playlists():
    return render_template("playlists.j2")

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 8828))
    app.run(port=port, debug=True)
