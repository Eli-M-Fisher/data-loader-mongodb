from fastapi import FastAPI
import os
from services.data_loader.db import DataLoader

# Create the fastapi application
app = FastAPI()

# initialize datloader with environment variables
# Default values: host=localhost, port=27017, database=mydb
loader = DataLoader(
    host=os.environ.get("MONGO_HOST", "localhost"),
    port=int(os.environ.get("MONGO_PORT", "27017")),
    database=os.environ.get("MONGO_DATABASE", "mydb")
)

# define a route to get all data
@app.get("/data")
def read_data():
    # this functon retrieves all data from the mongodbb collection
    return loader.get_all_data()