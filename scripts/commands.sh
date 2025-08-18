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



oc login --token=.....

oc project eliyahu-dev

# Complete cleaning of the project
oc delete all --all -n eliyahu-dev
oc delete pvc --all -n eliyahu-dev

# Build & Push of the Docker Image
# It is mandatory to use buildx with --platform linux/amd64.
docker login -u elif2

docker buildx create --use  
docker buildx build --platform linux/amd64 \
  -t elif2/data-loader-app:mongo \
  .
docker push elif2/data-loader-app:mongo

# Setting a Secret for DockerHub (once per project)
oc create secret docker-registry dockerhub-secret \
  --docker-username=elif2 \
  --docker-password=..... \
  --docker-server=https://index.docker.io/v1/

oc secrets link default dockerhub-secret --for=pull

# MongoDB deployment
oc apply -f infrastructure/k8s/mongo-deployment.yaml
oc get pods

# MongoDB service
oc apply -f infrastructure/k8s/backend-deployment.yaml
oc get pods

# Data Loader deployment
oc apply -f infrastructure/k8s/route.yaml
oc get route

# Data Loader service
curl -k https://data-loader-route-eliyahu-dev.apps.rm1.0a51.p1.openshiftapps.com/data
