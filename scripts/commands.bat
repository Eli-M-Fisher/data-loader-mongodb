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



# 1. connecte -Namespace
# enter in to OpenShift
oc login --token=*******

# i cchoose a project
oc project eliyahu-dev

# 2. Cleaning up an old project now
oc delete all --all -n eliyahu-dev
oc delete pvc --all -n eliyahu-dev

# 3.  Build & Push Docker Image

# dockerhub login
docker login -u elif2

# to enable buildx
docker buildx create --use

# and build image
docker buildx build --platform linux/amd64 \
  -t elif2/enemy-soldiers-api:latest \
  . --push

# now i pushing to DockerHub
docker push elif2/enemy-soldiers-api:latest

# 4. make secret to dockerhub once

# i delet the old one first
oc delete secret dockerhub-secret -n eliyahu-dev

# now make new secret
oc create secret docker-registry dockerhub-secret \
  --docker-username=elif2 \
  --docker-password=******** \
  --docker-server=https://index.docker.io/v1/ \
  -n eliyahu-dev

oc secrets link default dockerhub-secret --for=pull -n eliyahu-dev

# 5. now i deploy mongobd
oc apply -f infrastructure/k8s/mongo-deployment.yaml
oc get pods

# 6. deploy backend (fastapi
oc apply -f infrastructure/k8s/backend-deployment.yaml
oc get pods

# 7.  deploy route
oc apply -f infrastructure/k8s/route.yaml
oc get route

# 8. check:
oc get routes

# GET
curl https://enemy-soldiers-route-eliyahu-dev.apps.rm1.0a51.p1.openshiftapps.com/soldiersdb/

# POST
curl -X POST \
  https://enemy-soldiers-route-eliyahu-dev.apps.rm1.0a51.p1.openshiftapps.com/soldiersdb/ \
  -H "Content-Type: application/json" \
  -d '{"ID":1,"first_name":"eli","last_name":"fisher","phone_number":"12345789","rank":"Private"}'

# PUT
curl -X PUT \
  "https://enemy-soldiers-route-eliyahu-dev.apps.rm1.0a51.p1.openshiftapps.com/soldiersdb/1?field=rank&value=Captain"

# DELETE
curl -X DELETE \
  https://enemy-soldiers-route-eliyahu-dev.apps.rm1.0a51.p1.openshiftapps.com/soldiersdb/1