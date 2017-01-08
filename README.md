# ubuntu-django-postgres
A template docker application for django application development

# Overview
This template is aim to build a docker image along with django, it will help developer to start building a django application and python3 without using a virtual environment.
An idea is to run django along with uwsgi and nginx in the same container, developer can edit their django code and directly serve by nginx and uwsgi instead of using and internal "runserver" command.

# Usage
This template comes with a few tools to help you to start an application, an instruction to use this repository is given below.

# Setup your project
## ./setup.sh
This is a setup program, it will create your very first application and requirements folders, this template application is using django 1.10.5 and psycopg2 2.6.2

# Start you django application
## docker-compose up
We use docker-compose to launch and application and postgres database containers, at the first time, it will take sometimes to download all components, please be patient.
Once the application is built and running, you can access your application via http://localhost:8000, you will see django welcome page.

After that you can start developing you django application in the path ./application, your changes will trigger uwsgi to reload you code just like using a "runserver" command.

# Build you project
When you are going to deploy your application you need to build your image, please enter the folder "build" and you will find the "build.sh" script, you can use this script to build you application.

Usage: ./build.sh \<image name\>

it will build an application for you, then you can push it to your registry manually.

# Notes
This application is running under docker, the database credentials must be given via an containner environment variables, which are:
* DB_HOST => Database hostname
* DB_PORT => Database port
* DB_NAME => Database name
* DB_USER => Database user
* DB_PASSWORD => Database password
