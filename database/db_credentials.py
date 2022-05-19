# To actually have your app use this file, you need to RENAME the file to db_credentials.py
# You will find details about your CS340 database credentials on Canvas.

# the following will be used by the webapp.py to interact with the database
# You can also use environment variables

# For Local Devlelopment
# host = 'localhost'
# # can be different if you set up another username in your MySQL installation
# user = 'root'
# passwd = 'nottellingyou'                        # set accordingly
# db = 'bsg'



host = os.environ.get("LOCALHOST")
user = os.environ.get("ROOT")
passwd = os.environ.get("PASS")
db = os.environ.get("AUDIOCAT_DB")
