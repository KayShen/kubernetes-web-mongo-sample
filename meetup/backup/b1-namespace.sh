#!/bin/bash

printf 'Creating the guestbook namespace...\n'

printf 'kubectl create -f k8s/guestbook.namespace.yaml\n'
kubectl create -f k8s/guestbook.namespace.yaml

printf 'kubectl get namespace\n'
kubectl get namespace