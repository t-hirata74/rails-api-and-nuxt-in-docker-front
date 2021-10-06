FROM node:14.15.1-alpine

# .env => docker-compose.yml(渡す) => Dockerfile ARG(受け取る)
ARG WORKDIR

ENV HOME=/${WORKDIR} \
    LANG=C.UTF-8 \
    # コンピュータ用の英語を文字コードUTF-8で利用する
    TZ=Asia/Tokyo \
    # コンテナのNuxt.jsをブラウザから参照するためにip:0.0.0.0に紐づける
    HOST=0.0.0.0

# ENV check（このRUN命令は確認のためなので無くても良い）
RUN echo ${HOME}

WORKDIR ${HOME}