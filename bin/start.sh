#!/bin/bash
docker rm -f socketio-demo socketio-redis
docker build -t socketio-demo .
docker run -idt --name socketio-redis redis
docker run --privileged -idt --link socketio-redis -p 127.0.0.1:80:80 --name socketio-demo socketio-demo
