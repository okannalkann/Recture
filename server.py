from flask import Flask, abort, current_app, render_template, request, session, url_for, redirect, flash, jsonify
import mysql.connector
from flask_mysqldb import MySQL
from database import Database
from datetime import datetime   

app = Flask(__name__)
app.secret_key = "SportBuddy"
db = Database("127.0.0.1", 3306, "root", "qwerty123456", "rectureDB")
db.con.cursor()    



@app.route('/',methods=['GET','POST'])
def deneme():
    if request.method == "GET":
        # query="SELECT * FROM rectureDB.user WHERE username= 'alkano'"
        # db.cursor.execute(query)
        # myresult = db.cursor.fetchone()
        # print(myresult)
        # response = jsonify(myresult)
        # # response.headers.add("Access-Control-Allow-Origin", "*")

        # return response
        return render_template("home.html")

@app.route('/chat', methods=['GET','POST'])
def chat():
    if 'user' in session:
        username = session['user']
        Session_user_id = session['user_id']
        if request.method == "GET":
            query="SELECT * FROM rectureDB.messageforpanel"
            db.cursor.execute(query)
            myresult = db.cursor.fetchall()
            return render_template("chat.component.html",messages=myresult,len=(len(myresult)),username=username)

        else:
            message = request.form["message"] # form textbox
            print(message)
            now = datetime.now()
            query="INSERT INTO recturedb.messageforpanel (User_idUser,messages,Date) VALUES (%s,%s,%s)" # insert query
            val=(Session_user_id,message,now) # our values
            db.cursor.execute(query, val) #added the database
            db.con.commit() #database updated
            query="SELECT * FROM rectureDB.messageforpanel"
            db.cursor.execute(query)
            myresult = db.cursor.fetchall()
            return render_template("chat.component.html",messages=myresult,len=(len(myresult)),username=username)

@app.route('/contact', methods=['GET','POST'])
def contact():
    if request.method == "POST":
        print("ilgin")
        name = request.form["name"] # form textbox
        email = request.form["email"] # form textbox
        message = request.form["message"] # form textbox
        messageType = request.form["messageType"] # form textbox
        query="INSERT INTO recturedb.contact (name, email, Message, messageType, Date) VALUES (%s,%s,%s,%s,%s)" # insert query
        now = datetime.now()
        val=(name,email,message,messageType,now) # our values
        db.cursor.execute(query, val) #added the database
        db.con.commit() #database updated
        return render_template("contact.html")
    else:
        return render_template("contact.html")

@app.route('/application', methods=['GET','POST'])
def application():
    if request.method == "POST":
        print("ilgin")
        cv = request.form["cv"] # form textbox
        Description = request.form["Description"] # form textbox
        name = request.form["name"] # form textbox
        username = request.form["username"] # form textbox
        surname = request.form["surname"] # form textbox
        password = request.form["password"] # form textbox
        email = request.form["email"] # form textbox
        image = request.form["image"] # form textbox
        query="""INSERT INTO recturedb.application (cv, Description, IsApproved, name, username, surname, password, email, ImageUrl) 
        VALUES (%s, %s, %s, %s, %s, %s, %s,%s,%s)""" # insert query

        val=(cv,Description,0,name,username,surname,password,email,image) # our values
        db.cursor.execute(query, val) #added the database
        db.con.commit() #database updated
        return render_template("application.html")
    else:
        return render_template("application.html")



@app.route('/sign_up', methods=['GET','POST'])
def sign_up():
    if request.method == "POST":
        name = request.form["name"]
        surname = request.form["surname"]
        username = request.form["username"]
        password = request.form["password"]
        email = request.form["email"]
        imageURL = request.form["imageURL"]
        query="INSERT INTO rectureDB.user (name, surname, username, userType, password, email,ImageUrl) VALUES (%s,%s,%s,%s,%s,%s,%s)"
        val = (name,surname,username,"nonPremium",password,email,imageURL)
        db.cursor.execute(query, val) #added the database
        db.con.commit()
        query="SELECT * FROM rectureDB.user WHERE username= '"+username+"'"
        db.cursor.execute(query)
        myresult = db.cursor.fetchone()
        print(myresult)
        response = jsonify(myresult)
        return response
    else:
        return render_template("login.html")

@app.route('/sign_in', methods=['GET','POST'])
def sign_in():
    try:
        if request.method == "POST": 
            usern = request.form["username"] #take username from website textbox
            password = request.form["password"] #take password from website textbox
            print(usern,password)
            # query="SELECT * FROM rectureDB.user WHERE (username = "'%s'" and password="'%s'")",(usern,password)
            query="SELECT * FROM rectureDB.user WHERE username =\"" + usern + "\""

            # query="""SELECT * FROM rectureDB.user WHERE (username = "balkani" and password= 123)"""
            print(query)
            db.cursor.execute(query)
            print("alsdlasdlasl")
            myresult = db.cursor.fetchone()
            print(myresult)
            if myresult ==[]:
                return render_template("login.html")
            else:
                session["user"] = myresult[1]
                session["user_id"] = myresult[0]
                return render_template("home.html",name=myresult)
        else:    
            return render_template("login.html")
    except:
        print("Login Error")



        
if __name__ == '__main__':
    app.run(debug=True)
