FROM node:14.15.1-alpine

# .env => docker-compose.yml(渡す) => Dockerfile ARG(受け取る)
ARG WORKDIR
ARG API_URL

ENV HOME=/${WORKDIR} \
    LANG=C.UTF-8 \
    # コンピュータ用の英語を文字コードUTF-8で利用する
    TZ=Asia/Tokyo \
    # コンテナのNuxt.jsをブラウザから参照するためにip:0.0.0.0に紐づける
    HOST=0.0.0.0 \
    API_URL=${API_URL}

# ENV check（このRUN命令は確認のためなので無くても良い）
RUN echo ${HOME}

WORKDIR ${HOME}

# ローカルのpackage.jsonをコンテナ上にコピーして、インストールしている
COPY package*.json ./
RUN yarn install

# frontのディレクトリを、コンテナのディレクトリにnuxtプロジェクトを一式コピー
COPY . ./

# 本番環境様にアプリを構築
RUN yarn run build