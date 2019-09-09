From ubuntu:latest

RUN apt-get update && apt-get install -y python python-pip virtualenv libssl-dev libpq-dev git build-essential libfontconfig1 libfontconfig1-dev

RUN apt-get install -y locales

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen

RUN export LC_ALL=en_US.UTF-8

RUN export LANG=en_US.UTF-8

RUN export LANGUAGE=en_US.UTF-8

RUN pip install setuptools pip --upgrade --force-reinstall

RUN pip install djangocms-installer

RUN mkdir -p /myproject

RUN cd myproject

RUN djangocms -f -s -p . mysite

RUN sed -i -e 's/ALLOWED_HOSTS.*/ALLOWED_HOSTS = ["$myip"]/' /myproject/mysite/settings.py

ENTRYPOINT ["./run_app.sh"]

python manage.py migrate

EXPOSE 80
