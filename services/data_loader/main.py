from fastapi import FastAPI
import os
from .dal import SoldierDAL
from .models import Soldier

# creat the fastapi application
app = FastAPI(title="Enemy Soldiers CRUD API")

# initialize dal with environmnt varibles
dal = SoldierDAL(
    host=os.environ.get("MONGO_HOST", "localhost"),
    port=int(os.environ.get("MONGO_PORT", "27017")),
    db_name=os.environ.get("MONGO_DATABASE", "enemy_soldiers"),
    collection_name=os.environ.get("MONGO_COLLECTION", "soldier_details")
)

# route
@app.get("/soldiersdb/")
def read_soldiers():
    return dal.get_all_soldiers()

@app.post("/soldiersdb/")
def create_soldier(soldier: Soldier):
    return dal.add_soldier(soldier)

@app.put("/soldiersdb/{ID}")
def update_soldier(ID: int, field: str, value: str):
    return dal.update_soldier(ID, field, value)

@app.delete("/soldiersdb/{ID}")
def delete_soldier(ID: int):
    return dal.delete_soldier(ID)