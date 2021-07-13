#!/bin/bash

cd /opt/irisapp/src/flask

/usr/irissys/bin/irispython /usr/irissys/bin/gunicorn --bind "0.0.0.0:8080" wsgi:app > /tmp/flask.log &

