# **OpenShift mongodb Docker**

# Goal:

The project includes the following:
MongoDB database running on OpenShift (use the image downloaded from DockerHub)
Implementation of a data access layer (Class DataLoader)
Setting up a FastAPI server - which accesses MongoDB and returns the table data to a dedicated endpoint.
The API is exposed using Route so that you can open a browser and see the data coming from the DB. (Or using another way of testing - Python script, CURL, postman, etc.)

Prerequisites
Docker Hub account to pull and upload an image (need to connect to DockerHub via CLI).
