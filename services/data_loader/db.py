from pymongo import MongoClient

class MongoDBClient:
    def __init__(self, host="localhost", port=27017, database="enemy_soldiers", collection="soldier_details"):

    def get_collection(self):
        return self.collection