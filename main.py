from flask import Flask
from datetime import datetime
from mypackage.models.customer import Customer
import os

app = Flask(__name__)

@app.route("/")
def home():    
    return f"Welcome to Challenger OSS"

@app.route("/getcustomers")
def get_customers():
    cust = Customer("USER","FTTH user")    
    return f"{cust} {datetime.today().strftime('%Y-%m-%d-%H-%M-%S')}"

if __name__ == "__main__":
    app.run(debug=True)
