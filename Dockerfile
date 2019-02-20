FROM ruby:2.3.4

RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y locales mysql-client mecab mecab-ipadic mecab-ipadic-utf8

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
RUN localedef -f UTF-8 -i en_US en_US.utf8

ENV MECAB_PATH=/usr/lib/libmecab.so.2

RUN mkdir /app
WORKDIR /app
COPY Gemfile Gemfile.lock /app/
# Gemfile側の記述とバージョンを合わせておくこと
RUN gem install bundler -v 1.16.1 && bundle install -j4
EXPOSE  3000
VOLUME /app
