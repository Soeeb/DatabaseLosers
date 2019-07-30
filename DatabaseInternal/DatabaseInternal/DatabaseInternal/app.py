import pymysql, hashlib
from flask import Flask, render_template, request, url_for, redirect, escape, session
from hashlib import md5
#from flaskext.mysql import MySQL
app = Flask(__name__)
app.secret_key="Samuel Dosado is stupid"
# Make the WSGI interface available at the top level so wfastcgi can get it.
class ServerError(Exception):
   """Base class for other exceptions"""
   pass
wsgi_app = app.wsgi_app
# Connect to the database
def create_connection():
	return pymysql.connect(host='localhost',
							user='root',
							password='13COM',
							db='workshopdb',
							charset='utf8mb4',
							cursorclass=pymysql.cursors.DictCursor)

@app.route('/')
def hello():
	"""Renders a sample page."""
	return render_template('index.html')

if __name__ == '__main__':
	import os
	HOST = os.environ.get('SERVER_HOST', 'localhost')
	try:
		PORT = int(os.environ.get('SERVER_PORT', '5555'))
	except ValueError:
		PORT = 5555
	app.run(HOST, PORT)
