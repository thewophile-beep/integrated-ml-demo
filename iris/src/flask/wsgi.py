from app import app

# Dev:
# cd /tmp/iris/src/flask
# /usr/irissys/bin/irispython /usr/irissys/bin/gunicorn --bind "0.0.0.0:8081" wsgi:app -w 3 --threads=2

if __name__ == '__main__':
    app.run()