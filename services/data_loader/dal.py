from pymongo import MongoClient
from .models import Soldier

class SoldierDAL:
    def __init__(self, host="localhost", port=27017, db_name="enemy_soldiers", 

    def get_all_soldiers(self):
        # get all documents, exclud mongodb internal "_id" field
        return

    def add_soldier(self):
        # insert a new solder document
        return

    def update_soldier(self):
        # update a soldier field by id
        return

    def delete_soldier(self):
        # delete soldier by id
        return