#!/bin/bash

printf '$ '
sleep 3
printf 'kubectl rolling-update --namespace=minefield guestbook --image=eu.gcr.io/test-cg/guestbook:meetup-0.2\n'
sleep 1
printf 'Created guestbook-99bbfd4aa2a8aeb4c00fea9ec7d1ddf4\n'
printf 'Scaling up guestbook-99bbfd4aa2a8aeb4c00fea9ec7d1ddf4 from 0 to 2, scaling down guestbook from 2 to 0 (keep 2 pods available, don\x27t exceed 3 pods)\n'
printf 'Scaling guestbook-99bbfd4aa2a8aeb4c00fea9ec7d1ddf4 up to 1\n'
sleep 5
printf 'Scaling guestbook down to 1\n'
sleep 3
printf 'Scaling guestbook-99bbfd4aa2a8aeb4c00fea9ec7d1ddf4 up to 2\n'
sleep 5
printf 'Scaling guestbook down to 0\n'
sleep 3
printf 'Update succeeded. Deleting old controller: guestbook\n'
printf 'Renaming guestbook-99bbfd4aa2a8aeb4c00fea9ec7d1ddf4 to guestbook\n'
printf 'replicationcontroller "guestbook" rolling updated\n'

printf '$\n'
sleep 2