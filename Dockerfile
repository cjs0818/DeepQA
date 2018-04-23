## Dockerfile to build DeepQ&A container image

#FROM python:3.5.2
FROM gcr.io/tensorflow/tensorflow:1.5.0-rc0-py3


## Dependencies

RUN \
apt-get -qq -y update && apt-get -y install unzip default-jdk
#apt-get -qq -y update && apt-get -y install unzip
#python3 python3-pip

RUN python3 -m pip install pip --upgrade

## DeepQA baseline
RUN  \
  pip3 install -U nltk \
  tqdm \
  django==1.10 \
  asgi_redis \
  channels==1.1.8 

## PyCharm
ADD https://download.jetbrains.com/python/pycharm-community-2018.1.tar.gz /tmp/ide.tar.gz
RUN mkdir -p /opt/ide && \
    tar zxvf /tmp/ide.tar.gz --strip-components=1 -C /opt/ide && \
    rm /tmp/ide.tar.gz
ENV PYCHARM_JDK=/usr/lib/jvm/default-java
RUN export PATH=$PATH:/opt/ide/bin

## Tensorflow
#ARG TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.11.0-cp35-cp35m-linux_x86_64.whl
#RUN \
#  pip3 install -U $TF_BINARY_URL

RUN pip3 install asgiref==2.2.0

#----------------------------------------
#  KoNLPy
RUN pip3 install konlpy Jpype1
RUN python3 -m nltk.downloader punkt
RUN apt-get -qq -y update && apt-get -y install python3-tk

#  LISTEN
RUN pip3 install openpyxl termcolor
#----------------------------------------


#COPY ./ /root/DeepQA
COPY ./.bashrc /root/

## Run Config

# You should generate your own key if you want deploy it on a server
ENV CHATBOT_SECRET_KEY="e#0y6^6mg37y9^+t^p_$xwnogcdh=27)f6_=v^$bh9p0ihd-%v"
ENV CHATBOT_REDIS_URL="redis"

# Important for using KoNLPy
ENV PYTHONIOENCODING=utf-8

EXPOSE 8000

WORKDIR /root
#WORKDIR /root/DeepQA/chatbot_website
#RUN python3 manage.py makemigrations
#RUN python3 manage.py migrate

# Launch the server
CMD python3 manage.py runserver 0.0.0.0:8000
