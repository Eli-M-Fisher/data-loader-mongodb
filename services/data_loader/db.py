from pymongo import MongoClient

class MongoDBClient:
    def __init__(self, host="localhost", port=27017, database="enemy_soldiers", collection="soldier_details"):
        # create a mongo client
        self.client = MongoClient(host, port)
        # select databas
        self.db = self.client[database]
        # select collection
        self.collection = self.db[collection]

    def get_collection(self):
        return self.collection