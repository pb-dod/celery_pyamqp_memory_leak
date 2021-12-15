import logging
import ssl

from celery import Celery

app = Celery('tasks', broker='amqp://guest@rabbitmq//', broker_use_ssl={"cert_reqs": ssl.CERT_NONE})

@app.task()
def add(x, y):
    return x + y
