#!/bin/bash

# Start Migrations
./migrations.sh -D

# Run Server
./start-app.sh -D
