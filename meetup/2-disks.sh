#!/bin/bash

printf 'Creating persistent disks...\n'

printf 'gcloud compute disks create --size 200GB mongodb-pd-1\n'
gcloud compute disks create --size 200GB mongodb-pd-1

printf 'gcloud compute disks create --size 200GB mongodb-pd-2\n'
gcloud compute disks create --size 200GB mongodb-pd-2

printf 'gcloud compute disks create --size 200GB mongodb-pd-3\n'
gcloud compute disks create --size 200GB mongodb-pd-3
