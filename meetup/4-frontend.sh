#!/bin/bash

cd ..

printf 'Creating the guestbook frontend service...\n'

printf 'kubectl create --namespace=minefield -f k8s/guestbook.service.yaml\n'
kubectl create --namespace=minefield -f k8s/guestbook.service.yaml

printf 'Creating the guestbook replication controller...\n'

printf 'kubectl create --namespace=minefield -f k8s/guestbook.rc.yaml\n'
kubectl create --namespace=minefield -f k8s/guestbook.rc.yaml

printf 'kubectl get pod --namespace=minefield\n'
kubectl get pod --namespace=minefield

printf 'kubectl get service --namespace=minefield\n'
kubectl get service --namespace=minefield

cd meetup