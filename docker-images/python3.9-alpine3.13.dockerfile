FROM python:3.9-alpine3.13

LABEL maintainer="Anton Petrov <anton.a.petrov@gmail.com>"

RUN apk add --no-cache --virtual .build-deps gcc libc-dev make \
    && pip install --no-cache-dir "uvicorn[standard]" gunicorn \
    && apk del .build-deps gcc libc-dev make
RUN /usr/local/bin/python -m pip install --upgrade pip
COPY ./start.sh /start.sh
RUN chmod +x /start.sh

COPY ./gunicorn_conf.py /gunicorn_conf.py

COPY ./start-reload.sh /start-reload.sh
RUN chmod +x /start-reload.sh

COPY ./app /app
WORKDIR /app/

ENV PYTHONPATH=/app

EXPOSE 80

# Run the start script, it will check for an /app/prestart.sh script (e.g. for migrations)
# And then will start Gunicorn with Uvicorn
CMD ["/start.sh"]
