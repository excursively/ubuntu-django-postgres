#!/bin/bash

# install requirements
if [ -n "$INSTALL_REQUIREMENT" ]; then
  echo
  echo "###################################################"
  echo "# Installing application's requirements..         #"
  echo "###################################################"
  pip3 install -r /home/web/app/requirements/base.txt
fi

# collecting static files
echo
echo "###################################################"
echo "# Collecting static files..                       #"
echo "###################################################"
cd /home/web/app && su web -c "python3 /home/web/app/application/manage.py collectstatic --noinput"

# migrate db
echo
echo "###################################################"
echo "# Migrating database..                            #"
echo "###################################################"
cd /home/web/app && su web -c "python3 /home/web/app/application/manage.py migrate --noinput"

# start applications
echo
echo "###################################################"
echo "# Starting applications..                         #"
echo "###################################################"
supervisord -n -c /etc/supervisor/supervisord.conf
