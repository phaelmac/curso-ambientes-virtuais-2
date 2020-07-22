FROM python:3.7-slim
MAINTAINER "Raphael Mendonça"

ENV PYTHONUNBUFFERED 1

ARG DEBUG_ARG
ARG ALLOWED_HOSTS_ARG
ARG SECRET_KEY_ARG
ARG USER_ARG
ARG PASSWORD_ARG
ARG HOST_ARG
ARG DBNAME_ARG

ENV TINI_VERSION v0.19.0
ENV SECRET_KEY=${SECRET_KEY_ARG}
ENV ALLOWED_HOSTS=${ALLOWED_HOSTS_ARG}
ENV DEBUG=${DEBUG_ARG}
ENV DATABASE_URL=postgres://${USER_ARG}:${PASSWORD_ARG}@${HOST_ARG}:5432/${DBNAME_ARG}

RUN apt update && \
    apt install -y libjpeg-dev zlib1g-dev python3-dev build-essential

RUN mkdir /src
WORKDIR /src
COPY ./Pipfile.lock ./Pipfile.lock
COPY ./Pipfile ./Pipfile

RUN pip install pip --upgrade && pip install pipenv && pipenv install --system --ignore-pipfile --deploy

ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

RUN useradd -ms /bin/bash usuario

USER usuario

