#!/bin/bash

# Create the services
printf 'Creating the mongodb services...\n'

printf 'kubectl create --namespace=guestbook -f k8s/mongodb.service.yaml\n'
kubectl create --namespace=guestbook -f k8s/mongodb.service.yaml

printf 'kubectl create --namespace=guestbook -f k8s/mongodb-1.service.yaml\n'
kubectl create --namespace=guestbook -f k8s/mongodb-1.service.yaml

printf 'kubectl create --namespace=guestbook -f k8s/mongodb-2.service.yaml\n'
kubectl create --namespace=guestbook -f k8s/mongodb-2.service.yaml

printf 'kubectl create --namespace=guestbook -f k8s/mongodb-3.service.yaml\n'
kubectl create --namespace=guestbook -f k8s/mongodb-3.service.yaml

# Create the RCs
printf 'Creating the mongodb replicaiton controllers...\n'

printf 'kubectl --namespace=guestbook create -f k8s/mongodb-1.rc.yaml\n'
kubectl --namespace=guestbook create -f k8s/mongodb-1.rc.yaml

printf 'kubectl --namespace=guestbook create -f k8s/mongodb-2.rc.yaml\n'
kubectl --namespace=guestbook create -f k8s/mongodb-2.rc.yaml

printf 'kubectl --namespace=guestbook create -f k8s/mongodb-3.rc.yaml\n'
kubectl --namespace=guestbook create -f k8s/mongodb-3.rc.yaml

# Get the pods
printf 'kubectl get pods --namespace=guestbook\n'
kubectl get pods --namespace=guestbook
