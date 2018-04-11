#!/usr/bin/env python
#-*- coding:utf8 -*-

socketio_config = {
    "async_mode": "gevent_uwsgi",
    "message_queue": "redis://socketio-redis:6379/1",
    "engineio_logger": True,
    "socketio_ping_interval": 25,
    "socketio_ping_timeout": 60,
}

demo_namespace = "/"
