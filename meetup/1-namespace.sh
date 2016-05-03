#!/bin/bash


cd ..

printf 'Creating the minefield namespace...\n'

printf 'kubectl create -f k8s/minefield.namespace.yaml\n'
kubectl create -f k8s/minefield.namespace.yaml


printf 'kubectl get namespace\n'
kubectl get namespace

cd meetup
