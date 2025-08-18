from fastapi import FastAPI
from services.data_loader.db import DataLoader
import os

app = FastAPI()
# Initialize DataLoader with environment variables
loader = DataLoader(
    host=os.environ.get("MYSQL_HOST", "localhost"),
    user=os.environ.get("MYSQL_USER", "user"),
    password=os.environ.get("MYSQL_PASSWORD", "password"),
    database=os.environ.get("MYSQL_DATABASE", "mydb")
)

# Define a route to get all data
@app.get("/data")
def read_data():
# This function retrieves all data from the database
    return loader.get_all_data()