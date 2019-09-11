From ubuntu:latest

RUN apt-get update 

RUN apt-get install -y python python-pip virtualenv libssl-dev libpq-dev git build-essential libfontconfig1 libfontconfig1-dev

RUN apt-get install -y locales

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen

RUN export LC_ALL=en_US.UTF-8

RUN export LANG=en_US.UTF-8

RUN export LANGUAGE=en_US.UTF-8

RUN pip install setuptools pip --upgrade --force-reinstall

RUN pip install djangocms-installer

RUN apt-get install dnsutils -y

#RUN export myip=$(dig +short myip.opendns.com @resolver1.opendns.com) 

RUN mkdir -p /myproject

WORKDIR /myproject

RUN djangocms -f -s -p . mysite

RUN ip=$(dig +short myip.opendns.com @resolver1.opendns.com)

RUN sed -i  -e 's/ALLOWED_HOSTS.*/ALLOWED_HOSTS = ['$ip']/' /myproject/mysite/settings.py

#ENTRYPOINT ["./run_app.sh"]

CMD python manage.py migrate

CMD python manage.py runserver 0.0.0.0:80

EXPOSE "80:80"
