#!/bin/bash

docker cp mistserver:/config.json ./config.json
docker build -t mistserver-stream .
docker run -d -p 1935:1935 --network=host --name mist-server mistserver-stream

