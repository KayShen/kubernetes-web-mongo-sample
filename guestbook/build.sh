#!/bin/bash
# Wrapper that runs the tasks triggered by jenkins on review in order to build frontend-web in server-leadgen

function run() {
	echo Running $*
	$*
	STATUS=$?
	if [ $STATUS -ne 0 ]; then
		echo $1 FAILED with status $STATUS
		exit $STATUS
	fi
	echo $1 SUCCESS
}

function createDockerDir() {
	mkdir -p target/docker && rm -rf target/docker/* && cp docker/* target/docker && cp -R target/universal/stage target/docker
}

run ./activator ';clean;test;stage'

run createDockerDir

cd target/docker

run docker build -t 'guestbook' . < Dockerfile