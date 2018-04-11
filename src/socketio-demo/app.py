#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
  Usage: test socketio
  Author: ssj
"""

from gevent import monkey
monkey.patch_all()

import os
import sys
import logging
from flask import Flask
from flask_socketio import SocketIO

project_home = os.path.split(os.path.realpath(__file__))[0]
sys.path.insert(0, project_home)

logger_path = os.path.join(project_home, "logs", "demo.log")


from etc import config

logging.basicConfig(level=logging.DEBUG,
                    format="%(asctime)s %(filename)s(%(lineno)s) %(levelname)s %(message)s",
                    datefmt="%Y-%m-%d %H:%M:%S",
                    filename=logger_path,
                    filemode="w")

app = Flask(__name__)
config.socketio = SocketIO(app, **config.socketio_config)

from views import demo
