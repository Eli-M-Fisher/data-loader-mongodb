#!/bin/bash

# 0. creating folders and boting
cd ~/Dev
mkdir -p data-loader
cd data-loader
touch Dockerfile requirements.txt README.md

git init
git branch -M main

python3 -m venv venv
source venv/bin/activate

git remote add origin https://github.com/Eli-M-Fisher/data-loader.git
git add .
git commit -m "Initial commit"
git push -u origin main
# 1. Building and pushing Docker Image with linux/amd64docker login -u elif2
docker buildx create --use
docker buildx build --platform linux/amd64 -t elif2/data-loader-app:fixed .
docker push elif2/data-loader-app:fixed

# 2. K8s/OpenShift configuretionoc apply -f infrastructure/k8s/mysql-deployment.yaml
oc apply -f infrastructure/k8s/backend-deployment.yaml
oc apply -f infrastructure/k8s/route.yaml

# 3. add a Secret to Puling Images from docker huboc create secret docker-registry dockerhub-secret \
  --docker-username=elif2 \
  --docker-password=<DOCKERHUB_PAT> \
  --docker-server=https://index.docker.io/v1/
oc secrets link default dockerhub-secret --for=pull

# 4. Uploading sql scripts to Mysql in a pod
# 4.1 Findng Mysql pod...
MYSQL_POD=$(oc get pods | grep mysql | grep Running | awk '{print $1}')

# 4.2 copying SQL script into pod: $MYSQL_POD
oc cp scripts/create_data.sql $MYSQL_POD:/tmp/create_data.sql
oc cp scripts/insert_data.sql $MYSQL_POD:/tmp/insert_data.sql

# 4.3 Running SQL initialization scripts..
oc rsh $MYSQL_POD <<EOF
mysql -u user -ppassword mydb < /tmp/create_data.sql
mysql -u user -ppassword mydb < /tmp/insert_data.sql
exit
EOF
# 5. check the data in the databaseoc rsh mysql-<pod>
mysql -u user -ppassword mydb
SELECT * FROM data;
exit
# 6. testing the API from the Clusteroc run curl --image=radial/busyboxplus:curl -i --tty --rm
/ $ curl http://data-loader-service:8000/data
/ $ curl -k https://data-loader-route-eliyahu-dev.apps.rm1.0a51.p1.openshiftapps.com/data