#!/bin/bash

printf 'Creating the guestbook frontend service...\n'

printf 'kubectl create --namespace=guestbook -f k8s/guestbook.service.yaml\n'
kubectl create --namespace=guestbook -f k8s/guestbook.service.yaml

printf 'Creating the guestbook replication controller...\n'

printf 'kubectl create --namespace=guestbook -f k8s/guestbook.rc.yaml\n'
kubectl create --namespace=guestbook -f k8s/guestbook.rc.yaml

printf 'kubectl get pod --namespace=guestbook\n'
kubectl get pod --namespace=guestbook

printf 'kubectl get service --namespace=guestbook\n'
kubectl get service --namespace=guestbook
