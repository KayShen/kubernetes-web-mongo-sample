#!/bin/bash


printf "$ "
sleep 3
printf 'kubectl create -f k8s/minefield.namespace.yaml\n'
sleep 1
echo 'namespace "minefield" created'

printf '$\n'
