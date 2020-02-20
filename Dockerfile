FROM python:3.7-slim-buster
MAINTAINER Jonatas Oliveira

ARG SECRET_KEY_ARG
ARG ALLOWED_HOSTS_ARG
ARG DEBUG_ARG

ENV PYTHONUNBUFFERED 1
ENV SECRET_KEY=${SECRET_KEY_ARG}
ENV ALLOWED_HOSTS=${ALLOWED_HOSTS_ARG}
ENV DEBUG=${DEBUG_ARG}

RUN apt update && \
    apt install -y libjpeg-dev zlib1g-dev python3-dev build-essential

RUN mkdir /src
WORKDIR /src
COPY ./requirements.txt /requirements.txt

RUN pip install pip --upgrade && pip install -r /requirements.txt

RUN useradd -ms /bin/bash user

RUN chown -R user:user /src && \
    chmod -R 775 /src/

USER user

