#!/bin/bash

if [ -z "$1" ]; then
	echo "Build application with the given image name"
	echo "  Usage: $0 <image name>"
else
	# build from base Dockerfile and extended
	cp ../Dockerfile ./Dockerfile
	cat ./Dockerfile-extend >> ./Dockerfile
	sed -i "s/build\/build-files/build-files/g" ./Dockerfile
	# start build product
	rm -rf ./app
	mkdir ./app
	# start build docker image
	cp -R ../application ./app/application
	cp -R ../requirements ./app/requirements
	# build docker
	docker build --rm -t $1 .
	# remove code when done
	rm -rf ./app
fi
