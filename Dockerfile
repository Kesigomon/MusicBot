FROM python:3.7-buster as build
WORKDIR /opt
RUN python3 -m venv /venv
ENV PATH=/venv/bin:$PATH
WORKDIR /opt/MusicBot
COPY . .

### Wheelビルドなしバージョン
### arm向けにビルドしないならこっちのほうが良いです
RUN pip3 install -r requirements.txt
### ここまでビルドなしバージョン


### Wheelビルドありバージョン
### arm向けにビルドするならこっち
### こちらを利用する場合、あらかじめ/wheels/build.pyを実行しておくこと
#COPY ./wheels/wheels /tmp/wheels
#RUN mv wheels/wheels /tmp/wheels && rm -r wheels \
#    && pip3 install -r requirements.txt --no-index --find-links=/tmp/wheels
### ここまでビルドありバージョン

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
ENTRYPOINT "python3 dockerentry.py"