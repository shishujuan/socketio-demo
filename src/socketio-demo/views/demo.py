#!/usr/bin/env python
# -*- coding: utf-8 -*-

from flask import Blueprint, request, session, g
from flask_socketio import join_room, leave_room, send, emit
from etc.config import socketio, demo_namespace
import logging

@socketio.on("connect", namespace=demo_namespace)
def test_connect():
    logging.info("sid:%s connected" % request.sid)

@socketio.on("disconnect", namespace=demo_namespace)
def test_disconnect():
    logging.info("sid:%s disconnected" % request.sid)

@socketio.on("client_event", namespace=demo_namespace)
def test_client_event(msg):
    logging.info("sid:%s client event, msg:%s" % (request.sid, msg))
    emit("server_response", {"data": msg["data"].upper()})
