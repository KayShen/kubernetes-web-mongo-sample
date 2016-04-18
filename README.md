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
![Alt text](https://raw.githubusercontent.com/egymgmbh/kubernetes-web-mongo-sample/master/letsencryptor/letsencryptor.svg)
<img src="https://raw.githubusercontent.com/egymgmbh/kubernetes-web-mongo-sample/master/letsencryptor/letsencryptor.svg">

See: http://kubernetes.io/docs/user-guide/ingress/

We are using GCEs with internal load balancer, follow the instruction in this tutorial:
https://cloud.google.com/container-engine/docs/tutorials/http-balancer

Alternatively the nginx ingress controller proposed in: https://github.com/kubernetes/contrib/tree/master/ingress/controllers/nginx can be used.

- Create namespace: 
    `kubectl create -f k8s/minefield.namespace.yaml`
- Create a host/domain, add it to the ingress yaml and create the ingress:
    `kubectl create -f k8s/letsencryptor.ingress.yaml --namespace=minefield`
- Create a tls secret:
    `kubectl create -f k8s/letsencryptor.secret.yaml --namespace=minefield`
    
- Create persistent disks for letsencrpyt:
    `gcloud compute disks create --size 100GB server-letsencryptor-workdir --project=<YOUR_PROJECT> --zone=<ZONE>`

- Create the replication controller for the letsencryptor:
    `kubectl create -f k8s/server-letsencryptor.rc.yaml --namespace=minefield`
