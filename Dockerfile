FROM python:3.8-slim-bullseye

WORKDIR /celery_app

RUN apt-get update && apt-get install -y \
  build-essential \
  git \
  && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN ln /usr/local/bin/python ./python
RUN ln /usr/local/bin/python3 ./python3
RUN ln /usr/local/bin/python3.8 ./python3.8

CMD scalene --profile-interval 5.0 --profile-all --cpu-sampling-rate 1.0 --column-width 1000 --html --outfile /celery_app/profiling.html /usr/local/bin/celery -A tasks worker --loglevel=DEBUG --without-gossip --without-heartbeat
