FROM python:3.7-buster as build
WORKDIR /opt
RUN python3 -m venv /venv
ENV PATH=/venv/bin:$PATH
WORKDIR /opt/MusicBot
COPY . .
COPY ./wheels/wheels /tmp/wheels
RUN pip3 install -r requirements.txt --no-index --find-links=/tmp/wheels

FROM python:3.7-slim-buster
RUN apt-get update && apt-get install -y \
    ffmpeg \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
COPY --from=build /venv /venv
COPY --from=build /opt/MusicBot /opt/MusicBot
ENV PATH=/venv/bin:$PATH
WORKDIR /opt/MusicBot
VOLUME [/opt/MusicBot/config]
ENV APP_ENV=docker
ENTRYPOINT ["python3", "dockerentry.py"]