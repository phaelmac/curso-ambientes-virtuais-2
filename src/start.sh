#!/bin/bash

# Start migrations
./migrations.sh -D

# start django project
./start-app.sh -D

