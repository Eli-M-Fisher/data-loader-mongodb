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

oc delete all --all -n eliyahu-dev
oc delete pvc --all -n eliyahu-dev

docker build -t elif2/data-loader-app:mongo .

docker login -u elif2

docker push elif2/data-loader-app:mongo

oc apply -f infrastructure/k8s/mongo-deployment.yaml

oc get pods

oc apply -f infrastructure/k8s/backend-deployment.yaml

oc get pods

oc apply -f infrastructure/k8s/route.yaml
