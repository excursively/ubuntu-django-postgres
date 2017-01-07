#!/bin/bash

DJANGO_VERION=1.10.5
PSYCOPG2_VERSION=2.6.2

if [ -d "./application" ]; then
    # do nothing
    echo "You've already has django application, setup will now exit"
else
	source `which virtualenvwrapper.sh`
	mkvirtualenv application --python=`which python3`
	pip install django==$DJANGO_VERION
	django-admin startproject application
	mkdir ./application/application/settings
	mkdir ./requirements
	mv ./application/application/settings.py ./application/application/settings/base.py
	cp ./build/build-files/application-config.py ./application/application/settings/app.py
	echo "django==$DJANGO_VERION" > requirements/base.txt
	echo "psycopg2==$PSYCOPG2_VERSION" >> requirements/base.txt
	deactivate
	rmvirtualenv application
fi
