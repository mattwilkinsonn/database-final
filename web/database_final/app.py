from flask import request, Flask, render_template, jsonify
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from database_final import models
from markupsafe import Markup

app = Flask(__name__)

engine = create_engine("mysql+pymysql://mysql:mysql@localhost:3306/train")
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

db = SessionLocal()


@app.route("/add_passenger", methods=["POST", "GET"])
def add_passenger():
    error = None
    if request.method == "POST":
        passenger = models.Passenger(name=request.form["name"], age=int(request.form["age"]))
        db.add(passenger)
        db.commit()
        db.refresh(passenger)
        return Markup(f'Added {passenger.name}')   
    else:
        error = "invalid"
    
    return render_template('add_passenger.html', error=error)
    
@app.route("/delete_passenger", methods=["POST", "GET"])
def delete_passenger():
    if request.method == "POST":
        name = request.form["name"]
        passenger = db.query(models.Passenger).filter(models.Passenger.name == name).first()
        db.delete(passenger)
        db.commit()
        return Markup(f'Deleted {name}') 
    
    return render_template('delete_passenger.html')

@app.route("/update_passenger", methods=["POST","GET"])
def update_passenger():
    if request.method == "POST":
        name = request.form["name"]
        age = request.form["age"]
        passenger = db.query(models.Passenger).filter(models.Passenger.name == name).first()
        passenger.age = age
        db.commit()
        return Markup(f'Updated {name}\'s age') 
    
    return render_template('update_passenger.html')

@app.route("/select_passengers", methods=["POST", "GET"])
def select_passengers():
    passengers = db.query(models.Passenger).all()
    l = []
    for passenger in passengers:
        d = {"id": passenger.id, 'name': passenger.name, 'age': passenger.age, 'vip_id': passenger.vip_id}
        l.append(d)
    

    print(l)
    return jsonify(l)


@app.route("/select_passengers_by_greater_than_age", methods=["POST", "GET"])
def select_passengers_by_greater_than_age():
    if request.method == "POST":
        age = request.form["age"]
        passengers = db.query(models.Passenger).filter(models.Passenger.age > age).all()
        l = []
        for passenger in passengers:
            d = {"id": passenger.id, 'name': passenger.name, 'age': passenger.age, 'vip_id': passenger.vip_id}
            l.append(d)
        return jsonify(l)
        
    return render_template('select_passengers_by_greater_than_age.html')

@app.route("/select_train_by_name", methods=["POST","GET"])
def select_train_by_name():
    if request.method == "POST":
        name = request.form["name"]
        train = db.query(models.Train).filter(models.Train.name == name).first()
        d = {'id': train.id, 'name': train.name, 'model': train.model, 'cars': train.cars}
        return d
    return render_template('select_train_by_name.html')