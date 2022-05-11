import MySQLdb
import os
from dotenv import load_dotenv, find_dotenv

# Load our environment variables from the .env file in the root of our project.
load_dotenv(find_dotenv())

# Set the variables in our application with those environment variables
# host = os.environ.get("classmysql.engr.oregonstate.edu")
# user = os.environ.get("cs340_mooreja2")
# passwd = os.environ.get("5143")
# db = os.environ.get("cs340_mooreja2")

host = 'classmysql.engr.oregonstate.edu'      # MUST BE THIS
user = 'cs340_mooreja2'       # don't forget the CS_340 prefix
passwd = '5143'               # should only be 4 digits if default
db = 'cs340_mooreja2'


def connect_to_database(host=host, user=user, passwd=passwd, db=db):
    '''
    connects to a database and returns a database objects
    '''
    db_connection = MySQLdb.connect(
        'classmysql.engr.oregonstate.edu', 'cs340_mooreja2', '5143', 'cs340_mooreja2')
    return db_connection


def execute_query(db_connection=None, query=None, query_params=()):
    '''
    executes a given SQL query on the given db connection and returns a Cursor object

    db_connection: a MySQLdb connection object created by connect_to_database()
    query: string containing SQL query

    returns: A Cursor object as specified at https://www.python.org/dev/peps/pep-0249/#cursor-objects.
    You need to run .fetchall() or .fetchone() on that object to actually acccess the results.

    '''

    if db_connection is None:
        print("No connection to the database found! Have you called connect_to_database() first?")
        return None

    if query is None or len(query.strip()) == 0:
        print("query is empty! Please pass a SQL query in query")
        return None

    print("Executing %s with %s" % (query, query_params))
    # Create a cursor to execute query. Why? Because apparently they optimize execution by retaining a reference according to PEP0249
    cursor = db_connection.cursor(MySQLdb.cursors.DictCursor)

    '''
    params = tuple()
    #create a tuple of paramters to send with the query
    for q in query_params:
        params = params + (q)
    '''
    # TODO: Sanitize the query before executing it!!!
    cursor.execute(query, query_params)
    # this will actually commit any changes to the database. without this no
    # changes will be committed!
    db_connection.commit()
    return cursor


if __name__ == '__main__':
    print("Executing a sample query on the database using the credentials from db_credentials.py")
    db = connect_to_database()
    query = "SELECT * from Users;"
    results = execute_query(db, query)
    print("Printing results of %s" % query)

    for r in results.fetchall():
        print(r)
