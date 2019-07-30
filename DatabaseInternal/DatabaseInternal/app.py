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

def allWorkshops():
	connection=create_connection()
	try:
		with connection.cursor() as cursor:
			select_sql = "SELECT tblworkshops.workshopId as id, tblworkshops.date as date, tblworkshops.room as room, tblworkshops.subject as subject, tblworkshops.workshopId as Summary, tblworkshops.teachers as teachers, tblworkshops.maxStudents as maxStudents,  tblworkshops.enrolledStudents as enrolled FROM tblworkshops"
			cursor.execute(select_sql)
			data = cursor.fetchall()
			data = list(data)
			print(data)
	finally:
		connection.close()


@app.route('/', methods=["GET","POST"])
def hello():
	allWorkshops()
	return render_template('index.html')

@app.route('/login', methods=["GET","POST"])
def login():
	connection=create_connection()
	try:
		with connection.cursor() as cursor:
			if request.method == "POST":
				username_form = request.form['username']
				password_form = request.form['password']
				print(username_form)
				print(password_form)
			else:
				pass
	finally:
		connection.close()
	return redirect(url_for("hello"))

if __name__ == '__main__':
	import os
	HOST = os.environ.get('SERVER_HOST', 'localhost')
	try:
		PORT = int(os.environ.get('SERVER_PORT', '5555'))
	except ValueError:
		PORT = 5555
	app.run(HOST, PORT, debug=True)
