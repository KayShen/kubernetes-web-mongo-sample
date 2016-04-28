#!/bin/bash


printf "$ "
sleep 1
printf 'gcloud compute disks create --size 200GB mongodb-pd-1\n'
sleep 2
echo 'Created [https://www.googleapis.com/compute/v1/projects/test-cg/zones/us-central1-f/disks/mongodb-pd-1].'
echo 'NAME          ZONE           SIZE_GB  TYPE         STATUS'
echo 'mongodb-pd-1  europe-west1-b  200      pd-standard  READY'

printf "$ "
sleep 4
printf 'gcloud compute disks create --size 200GB mongodb-pd-2\n'
sleep 2
echo 'Created [https://www.googleapis.com/compute/v1/projects/test-cg/zones/europe-west1-b/disks/mongodb-pd-2].'
echo 'NAME          ZONE            SIZE_GB  TYPE         STATUS'
echo 'mongodb-pd-2  europe-west1-b  200      pd-standard  READY'



printf "$ "
sleep 4
printf 'gcloud compute disks create --size 200GB mongodb-pd-3 --project=test-cg --zone=europe-west1-b\n'
sleep 2

echo 'Created [https://www.googleapis.com/compute/v1/projects/test-cg/zones/europe-west1-b/disks/mongodb-pd-3].'
echo 'NAME          ZONE            SIZE_GB  TYPE         STATUS'
echo 'mongodb-pd-3  europe-west1-b  200      pd-standard  READY'

printf '$\n$\n'
