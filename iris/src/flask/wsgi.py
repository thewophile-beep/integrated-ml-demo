from app import app

# /usr/irissys/bin/irispython /usr/irissys/bin/gunicorn --bind "0.0.0.0:8080" wsgi:app

if __name__ == '__main__':
    app.run()