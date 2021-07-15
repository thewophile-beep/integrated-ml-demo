from app import app

# Dev:
# cd $FLASK_PATH
# $PYTHON_PATH /usr/irissys/bin/gunicorn --bind "0.0.0.0:8081" wsgi:app

if __name__ == '__main__':
    app.run()