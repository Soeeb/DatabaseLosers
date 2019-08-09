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
			select_sql = "SELECT tblworkshops.workshopId as id, tblworkshops.date as date, tblworkshops.room as room, tblworkshops.subject as subject, tblworkshops.workshopId as summary, tblworkshops.teachers as teachers, tblworkshops.maxStudents as maxStudents,  tblworkshops.enrolledStudents as enrolled FROM tblworkshops"
			cursor.execute(select_sql)
			data = cursor.fetchall()
			data = list(data)
			print(data)
	finally:
		connection.close()
	return data

@app.route('/')
def hello():
	if session.get('logged_in'):
		username_session=escape(session['username']).capitalize()
		data = allWorkshops()
		return render_template("index.html", datas = data, session_user_name=username_session, session=session)
	return render_template('index.html')

@app.route('/login', methods=["GET","POST"])
def login():
	connection=create_connection()
	try:
		with connection.cursor() as cursor:
			if request.method == "POST":
				username_form = request.form['username']
				select_sql = "SELECT COUNT(1) FROM tblusers WHERE username = %s"
				val=(username_form)
				cursor.execute(select_sql, val)

				if not list(cursor.fetchone())[0]:
					raise ServerError('Invalid username')

				select_sql = "SELECT password, roleId, userId FROM tblusers WHERE username = %s"
				cursor.execute(select_sql,val)
				holder = cursor.fetchone()
				print (holder)

				password_form = request.form['password']
				select_sql = "SELECT Password FROM tblusers WHERE username = %s"
				cursor.execute(select_sql,val)
				data = list(cursor.fetchall())
				print(data)
				for row in data:
					print(md5(password_form.encode()).hexdigest())
					if md5(password_form.encode()).hexdigest()==row["Password"]:
						session['username'] = request.form['username']
						session['logged_in'] = True
						session['role'] = holder['roleId']
						session['userId'] = holder['userId']
						return redirect(url_for('hello'))


				raise ServerError('Invalid password')

	except ServerError as e:
		error = str(e)
		session['logged_in']= False
	return redirect(url_for("hello"))

#@app.route('/enroll', methods=["GET","POST"])
#def enroll():
#	connection=create_connection()
#	try:
#		with connection.cursor() as cursor:
#			if request.method == "POST":
#				userId = session['roleId']


@app.route('/register', methods=["GET","POST"])
def register():
	connection=create_connection()
	try:
		with connection.cursor() as cursor:
			if request.method == "POST":
				username_form = request.form['username']
				firstName_form = request.form['firstName']
				lastName_form = request.form['lastName']
				email_form = request.form['email']
				mobileNumber_form = request.form['mobileNumber']
				
				password_form = request.form['password']
				password_form = hashlib.md5(password_form.encode()).hexdigest()

				select_sql = "INSERT INTO `tblusers` (firstName, familyName, email, mobileNumber, username, password, roleId) VALUES (%s, %s, %s, %s, %s, %s, 3)"
				val=(firstName_form, lastName_form, email_form, mobileNumber_form, username_form, password_form)
				print(val)
				cursor.execute(select_sql, val)
				print('yeet')
		connection.commit()
	finally:
		connection.close()
	return redirect(url_for("hello"))

@app.route('/logout')
def logout():
	session['logged_in'] = False
	session.pop('username', None)
	session.pop('role', None)
	return redirect(url_for("hello"))

if __name__ == '__main__':
	import os
	HOST = os.environ.get('SERVER_HOST', 'localhost')
	try:
		PORT = int(os.environ.get('SERVER_PORT', '5555'))
	except ValueError:
		PORT = 5555
	app.run(HOST, PORT, debug=True)
