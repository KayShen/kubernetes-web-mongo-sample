# kubernetes-web-mongo-sample
This is a sample project containing a kubernetes setup of a webservice and mongodb database.

## Setup your kubernetes cluster
You can set up your cluster on Google container engine using the free trial: https://console.cloud.google.com/freetrial

Instructions on how to setup your cluster:
- First steps: [https://cloud.google.com/container-engine/docs/before-you-begin](https://cloud.google.com/container-engine/docs/before-you-begin)
- Creating a new Google Container Engine(GKE) cluster: [https://cloud.google.com/container-engine/docs/clusters/operations](https://cloud.google.com/container-engine/docs/clusters/operations)

## Inspect your cluster
You have to install `kubectl`, configure your project and created a new GKE cluster. After you have done that, you can use the k8s(Kubernetes) dashboard or watch your cluster from the command line:
- Watch connected cluster:
    `watch 'kubectl config current-context'`
- Watch your pods:
    `kubectl get pods --namespace=minefield --watch`


## Prepare your cluster project
The following setup will work within the `minefield` namespace. Read more about k8s namespaces  [here](https://github.com/kubernetes/kubernetes/blob/release-1.2/docs/design/namespaces.md).

- Create the `minefield` namespace:
    `kubectl create -f k8s/minefield.namespace.yaml`


## Setup the MongoDB cluster
- Create persistent disks
 - `gcloud compute disks create --size 200GB mongodb-pd-1 --project=<YOUR_PROJECT> --zone=<ZONE>`
 - `gcloud compute disks create --size 200GB mongodb-pd-2 --project=<YOUR_PROJECT> --zone=<ZONE>`
 - `gcloud compute disks create --size 200GB mongodb-pd-3 --project=<YOUR_PROJECT> --zone=<ZONE>`
- Create replication controllers
 - `kubectl --namespace=minefield create -f k8s/mongodb-1.rc.yaml`
 - `kubectl --namespace=minefield create -f k8s/mongodb-2.rc.yaml`
 - `kubectl --namespace=minefield create -f k8s/mongodb-3.rc.yaml`
- Create services. The service exposes the pod with a stable IP address and DNS name to other pods
 - `kubectl --namespace=minefield create -f k8s/mongodb-1.service.yaml`
 - `kubectl --namespace=minefield create -f k8s/mongodb-2.service.yaml`
 - `kubectl --namespace=minefield create -f k8s/mongodb-3.service.yaml`
 - `kubectl --namespace=minefield create -f k8s/mongodb.service.yaml`
- Inititate mongoDB replica set
 - Ensure the mongoDB container is started with --replSet command
 - Find the name of one of the pods
  - `kubectl --namespace=minefield get pods`
 - Get a shell in the pod and initiate the replica set
  - `kubectl --namespace=minefield exec -ti mongodb-1-$$$$$`
  - `mongo`
  - `rs.initiate()`
  - `rs.status()` should report (some fields omitted)
  ```
    {
        "set" : "rs-minefield",
        "myState" : 1,
        "term" : NumberLong(1),
        "heartbeatIntervalMillis" : NumberLong(2000),
        "members" : [
                {
                        "_id" : 0,
                        "name" : "mongodb-1-$$$$$:27017",
                        "health" : 1,
                        "state" : 1,
                        "stateStr" : "PRIMARY",
                        "configVersion" : 1,
                        "self" : true
                }
        ],
        "ok" : 1
    }
    ```
  - Check whether you can reach mongodb via its public service name
   - 'mongo mongodb-1:27017' (the port number is *required*)
   - `rs.status()` should give the same output as above
  - Build the cluster to use public service names
   - `c = rs.conf()`
   - `c.members[0].host = "mongodb-1:27017"`
   - `rs.reconfig(c)` (Overwrites our host name)
   - `rs.status()` should still indicate a healthy state using "mongodb-1" as the hostname
   - `rs.add("mongodb-2:27017")`
   - `rs.add("mongodb-3:27017")`
   - Verify the cluster is healthy. `rs.status()` should print (with some fields omitted)
   ```
   {
        "set" : "rs-minefield",
        "members" : [
                {
                        "_id" : 0,
                        "name" : "mongodb-1:27017",
                        "health" : 1,
                        "state" : 1,
                        "stateStr" : "PRIMARY",
                        "self" : true
                },
                {
                        "_id" : 1,
                        "name" : "mongodb-2:27017",
                        "health" : 1,
                        "state" : 2,
                        "stateStr" : "SECONDARY",
                        "syncingTo" : "mongodb-1:27017",
                },
                {
                        "_id" : 2,
                        "name" : "mongodb-3:27017",
                        "health" : 1,
                        "state" : 2,
                        "stateStr" : "SECONDARY",
                        "syncingTo" : "mongodb-1:27017",
                }
        ],
        "ok" : 1
    }
    ```
    - Connect to another replica set member and check this looks good, too
     - `mongo mongodb-2`
     - `rs.status()` should report same data as above, self being a secondary.


## Setup the guestbook
Build the docker image according to guestbook/README.md. Upload the docker image to your docker registry and change k8s/guestbook.rc.yaml accordingly.

- Create the replication controller for the guestbook:
    `kubectl create -f k8s/guestbook.rc.yaml --namespace=minefield`
    
- Create the service for the guestbook:
    `kubectl create -f k8s/guestbook.service.yaml --namespace=minefield`

The service will create a load balancer. The public IP will be visible after some time. Call `watch 'kubectl get services --namespace=minefield'` to inspect.

## Ingress meets Let's Encrypt
See https://github.com/egymgmbh/kubernetes-letsencrypt.
