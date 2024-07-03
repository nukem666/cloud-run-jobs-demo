FROM python:alpine3.20

RUN mkdir /app
COPY app/. /app
WORKDIR /app

ENTRYPOINT [ "python3", "demo.py" ]