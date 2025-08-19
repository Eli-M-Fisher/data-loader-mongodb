from pymongo import MongoClient
from .models import Soldier

class SoldierDAL:
    def __init__(self, host="localhost", port=27017, db_name="enemy_soldiers", collection_name="soldier_details"):
        self.client = MongoClient(host, port)
        self.db = self.client[db_name]
        self.collection = self.db[collection_name]

    def get_all_soldiers(self):
        # get all documents, exclud mongodb internal "_id" field
        return list(self.collection.find({}, {"_id": 0}))

    def add_soldier(self, soldier: Soldier):
        # insert a new solder document
        self.collection.insert_one(soldier.dict())
        return {"status": "success", "message": "Soldier added"}

    def update_soldier(self, ID: int, field: str, value: str):
        # update a soldier field by id
        result = self.collection.update_one({"ID": ID}, {"$set": {field: value}})
        return {"status": "success" if result.modified_count > 0 else "failed"}

    def delete_soldier(self, ID: int):
        # delete soldier by id
        result = self.collection.delete_one({"ID": ID})
        return {"status": "success" if result.deleted_count > 0 else "failed"}