# kubernetes-web-mongo-sample
This is a sample project containing a kubernetes setup of a webservice and mongodb database.

## Setup your kubernetes cluster
You can set up your cluster on Google container engine using the free trial: https://console.cloud.google.com/freetrial

Instructions on how to setup your cluster: https://cloud.google.com/container-engine/docs/before-you-begin

## Inspect your cluster
You can use the Kubernetes dashboard or watch your cluster from the command line: 
- Watch connected cluster: 
    `kubectl config view | grep "current" --watch`
- Watch your pods: 
    `kubectl get pods --namespace=minefield --watch`


## Ingress meets lets encrypt
We are using the ingress controller proposed in: https://github.com/kubernetes/contrib/tree/master/ingress/controllers/nginx
See: http://kubernetes.io/docs/user-guide/ingress/

On GCE with internal load balancer, follow the instruction in this tutorial:
https://cloud.google.com/container-engine/docs/tutorials/http-balancer


- Create namespace: 
    `kubectl create -f k8s/minefield.namespace.yaml`
- Create the default backend replication controller and service: 
    `kubectl create -f k8s/default-http-backend.service.yaml --namespace=minefield`
    `kubectl create -f k8s/default-http-backend.rc.yaml --namespace=minefield`
- Create nginx ingress controller:
    `kubectl create -f k8s/nginx-ingress-controller.rc.yaml --namespace=minefield`
- Create a host/domain, add it to the ingress yaml and create the ingress:
    `kubectl create -f k8s/minefield.ingress.yaml --namespace=minefield`
