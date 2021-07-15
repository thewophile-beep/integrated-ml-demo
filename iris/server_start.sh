#!/bin/bash

cd ${FLASK_PATH}

${PYTHON_PATH} /usr/irissys/bin/gunicorn --bind "0.0.0.0:8080" wsgi:app > /tmp/flask.log &

exit