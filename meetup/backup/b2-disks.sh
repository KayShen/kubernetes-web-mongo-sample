#!/bin/bash

printf 'Creating persistent disks...\n'

printf 'gcloud compute disks create --size 200GB mongodb-pd-guestbook-1\n'
gcloud compute disks create --size 200GB mongodb-pd-guestbook-1

printf 'gcloud compute disks create --size 200GB mongodb-pd-guestbook-2\n'
gcloud compute disks create --size 200GB mongodb-pd-guestbook-2

printf 'gcloud compute disks create --size 200GB mongodb-pd-guestbook-3\n'
gcloud compute disks create --size 200GB mongodb-pd-guestbook-3
