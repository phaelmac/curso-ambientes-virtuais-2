FROM python:3.7-slim-buster
MAINTAINER Jonatas Oliveira

ENV PYTHONUNBUFFERED 1

ARG SECRET_KEY_ARG
ARG ALLOWED_HOSTS_ARG
ARG DEBUG_ARG
ARG DB_HOST
ARG DB_NAME
ARG DB_USER
ARG DB_PASS


ENV SECRET_KEY=${SECRET_KEY_ARG}
ENV ALLOWED_HOSTS=${ALLOWED_HOSTS_ARG}
ENV DEBUG=${DEBUG_ARG}
ENV DATABASE_URL=postgres://${DB_USER}:${DB_PASS}@${DB_HOST}:5432/${DB_NAME}

RUN apt update && \
    apt install -y libjpeg-dev zlib1g-dev python3-dev build-essential

COPY ./Pipfile /Pipfile
COPY ./Pipfile.lock /Pipfile.lock

RUN mkdir /src
WORKDIR /src
COPY ./src /src

RUN pip install pipenv && \
    pipenv install --system --ignore-pipfile --deploy

ADD https://github.com/krallin/tini/releases/download/v0.10.0/tini /tini
RUN chmod +x /tini

RUN useradd -ms /bin/bash user

USER user

