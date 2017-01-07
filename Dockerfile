FROM ubuntu:xenial

# change to the fastest repoisitiory
RUN sed -i "s/http:\/\/archive.ubuntu.com/http:\/\/mirror.kku.ac.th/g" /etc/apt/sources.list

# install required packages
RUN apt-get update
RUN apt-get install -y gcc \
    python-software-properties \
    python python-dev python-setuptools \
    python3 python3-dev python3-setuptools \
    python3-pip \
    supervisor \
    libpq-dev \
    nginx \
    wget \
    git \
    vim \
    uwsgi uwsgi-plugin-python3

# add new user
RUN adduser web --disabled-password

# add startup file
ADD build/build-files/start.sh /home/web/start.sh
RUN chmod +x /home/web/start.sh

# add component files
ADD build/build-files/supervisor-app.conf /etc/supervisor/supervisord.conf
ADD build/build-files/uwsgi_params /home/web/uwsgi_params
ADD build/build-files/uwsgi.ini /home/web/uwsgi.ini
ADD build/build-files/nginx-app.conf /etc/nginx/sites-enabled/default

# change number of nginx worker to 16
RUN sed -i -- 's/worker_processes 4;/worker_processes 16;/g' /etc/nginx/nginx.conf

# do not run nginx as daemon
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# create log folders
RUN mkdir -p /var/log/uwsgi && \
    chown web /var/log/uwsgi && \
    mkdir -p /var/log/supervisord && \
    chown web /var/log/supervisord && \
    mkdir -p /var/log/application && \
    chown web /var/log/application

# create media and static folders
RUN su web -c "mkdir /home/web/media && mkdir /home/web/static"

# expose ports
EXPOSE 80

# run startup command
CMD ["/home/web/start.sh"]
