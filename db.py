from app import app
from flaskext.mysql import MySQL

mysql = MySQL()

#
# app.config['MYSQL_HOST'] = 'LOCALHOST'
# app.config['MYSQL_USER'] = 'ROOT'
# app.config['MYSQL_PASSWORD'] = 'PASS'
# app.config['MYSQL_DB'] = 'AUDIOCAT_DB'
# app.config["MYSQL_CURSORCLASS"] = "DictCursor"

app.config['MYSQL_DATABASE_USER'] = 'pq1d1hou30araaxz'
app.config['MYSQL_DATABASE_PASSWORD'] = 'yq9rdq3axv65sxt7'
app.config['MYSQL_DATABASE_DB'] = 'wqu793vt17ypbptl'
app.config['MYSQL_DATABASE_HOST'] = 'eyvqcfxf5reja3nv.cbetxkdyhwsb.us-east-1.rds.amazonaws.com'
mysql.init_app(app)