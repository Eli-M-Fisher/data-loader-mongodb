# **mongodb CRUD Server**

### (and OpenShift mongodb Docker (in v1))

# Goal:


A service that exposes CRUD operations to MongoDB for a database for enemy soldiers
Within the framework of these operations, the following should be enabled:
Retrieve
Insert
Update
Delete
The operations are implemented in the rest API:
HTTP GET — This method is used to read any resource.
HTTP POST — This method is used to write any resource.
HTTP PUT — This method is used to update any resource.
HTTP DELETE — This method is used to delete any resource.

The database is called enemy_soldiers
The document collection is called soldier_details
Record structure
Unique numeric field ID
first_name
last_name
phone_number
rank
