FROM condaforge/miniforge3

LABEL maintainer="Anton Petrov <anton.a.petrov@gmail.com>"
RUN python -m pip install --upgrade pip
RUN conda install python=3.10 --yes
RUN conda update --all --yes

RUN apt-get update && apt-get upgrade -y && \
apt-get install -y make build-essential wget curl  \
&& apt clean

RUN pip install --no-cache-dir "uvicorn[standard]" gunicorn

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