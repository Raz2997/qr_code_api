#!/bin/sh
mkdir -p /myapp/qr_codes
chmod -R 777 /myapp/qr_codes
exec gunicorn -k uvicorn.workers.UvicornWorker -w 4 -b 0.0.0.0:8000 app.main:app
