#!/bin/bash

cd ..

printf 'Choose an image. Available images are:\n'
printf '[1] guestbook:meetup-0.1\n'
printf '[2] guestbook:meetup-0.2\n'

read input

if[input]

if [ "$input" -eq "1" ]; then
	printf 'kubectl rolling-update --namespace=guestbook guestbook --image=eu.gcr.io/test-cg/guestbook:meetup-0.1\n'
	kubectl rolling-update --namespace=guestbook guestbook --image=eu.gcr.io/test-cg/guestbook:meetup-0.1
fi

if [ "$input" -eq "2" ]; then
	printf 'kubectl rolling-update --namespace=guestbook guestbook --image=eu.gcr.io/test-cg/guestbook:meetup-0.2\n'
	kubectl rolling-update --namespace=guestbook guestbook --image=eu.gcr.io/test-cg/guestbook:meetup-0.2
fi

cd meetup
