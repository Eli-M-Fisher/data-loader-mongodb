from pymongo import MongoClient

# DataLoader class to handle mongodb connection and queries
class DataLoader:
    def __init__(self, host="localhost", port=27017, database="mydb"):
        # create a mongodb client (connects to mongobd server)
        self.client = MongoClient(host, port)
        # select the datbase by nam
        self.db = self.client[database]
        #  the clection (equivalent to a table in sql)
        self.collection = self.db["data"]

        # If the clection is empty, insert 5 inital document
        if self.collection.count_documents({}) == 0:
            docs = [
                {"id": 1, "first_name": "Alice", "last_name": "Smith"},
                {"id": 2, "first_name": "Bob", "last_name": "Brown"},
                {"id": 3, "first_name": "Charlie", "last_name": "Johnson"},
                {"id": 4, "first_name": "Dana", "last_name": "White"},
                {"id": 5, "first_name": "Eli", "last_name": "Fisher"},
            ]
            self.collection.insert_many(docs)

    # method to retrieve all documents from the collection
    def get_all_data(self):
        # find all documents, exclude the mongodb internal "_id" field
        result = list(self.collection.find({}, {"_id": 0}))
        return result