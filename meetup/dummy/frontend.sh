#!/bin/bash


printf '$ '
sleep 3
printf 'kubectl create --namespace=minefield -f k8s/guestbook.service.yaml\n'
sleep 1
printf 'service "guestbook" created\n'

printf '$ '
sleep 3
printf 'kubectl create --namespace=minefield -f k8s/guestbook.rc.yaml\n'
sleep 1
printf 'replicationcontroller "guestbook" created\n'

printf '$ '
sleep 3
printf 'kubectl get service --namespace=minefield\n'
sleep 1
printf 'NAME                   CLUSTER-IP       EXTERNAL-IP     PORT(S)     AGE\n'
printf 'guestbook              10.167.240.175   130.211.97.59   80/TCP      58s\n'
printf 'mongodb                10.167.255.151   <none>          27017/TCP   30m\n'
printf 'mongodb-1              10.167.254.221   <none>          27017/TCP   28m\n'
printf 'mongodb-2              10.167.251.125   <none>          27017/TCP   28m\n'
printf 'mongodb-3              10.167.244.86    <none>          27017/TCP   28m\n'

printf '$\n'

sleep 5