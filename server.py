from flask import Flask, abort, current_app, render_template, request, session, url_for, redirect, flash, jsonify
import mysql.connector
from flask_mysqldb import MySQL
from database import Database


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
                return render_template("home.html",name=myresult)
        else:    
            return render_template("login.html")
    except:
        print("Login Error")



        
if __name__ == '__main__':
    app.run(debug=True)
