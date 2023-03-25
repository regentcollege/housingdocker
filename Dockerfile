FROM ruby:3-buster

ENV APP_DIR=/var/www/housing/current

RUN apt-get update && apt-get -y upgrade

RUN mkdir -p $APP_DIR
WORKDIR $APP_DIR

# Cache bundle install
COPY Gemfile $APP_DIR/
COPY Gemfile.lock $APP_DIR/

ENV RAILS_ENV=production

RUN apt-get -y install git-core curl rsync zlib1g-dev build-essential default-mysql-client libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 pkg-config libxml2-dev libxslt-dev libcurl4-openssl-dev software-properties-common libffi-dev nodejs imagemagick
RUN cd $APP_DIR; gem install bundler --version 2.2.15
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle config deployment production; bundle config without development test
RUN bundle install

EXPOSE 9292