# **OpenShift SQL Docker**

Goal:
Build a service that returns all the information in a single table (called data) to a GET request.

The project includes the following:

* A MySQL database running on OpenShift (use the image downloaded from DockerHub)
* Implementation of a data access layer (Class DataLoader)
* Setting up a FastAPI server - which accesses MySQL and returns the table data to a dedicated endpoint.
* The API is exposed using Route so that you can open a browser and see the data coming from the DB. (Or using another testing method - Python script, CURL, postman, etc.)

###### Websites that helped me and I used them:

[https://pretius.com/blog/openshift-tutorial](https://pretius.com/blog/openshift-tutorial)

[https://pretius.com/blog/openshift-tutorial](https://pretius.com/blog/openshift-tutorial)

[https://cloudowski.com/articles/why-managing-container-images-on-openshift-is-better-than-on-kubernetes/](https://cloudowski.com/articles/why-managing-container-images-on-openshift-is-better-than-on-kubernetes/)

https://www.docker.com/blog/blog-docker-desktop-red-hat-openshift/

https://medium.com/@Shamimw/installing-mysql-on-openshift-cluster-using-yamls-3860b3495118

![output](/Users/elifisher/Desktop/Screenshot\ 2025-08-14\ at\ 17.08.23.png )
