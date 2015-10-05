FROM ruby:2.2.2

ENV LANG C.UTF-8

RUN apt-get update -qy
RUN apt-get upgrade -y
RUN apt-get update -qy
RUN apt-get install -y build-essential

# for postgres
RUN apt-get install -y libpq-dev

# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

RUN apt-get install -y imagemagick
RUN apt-get install -y graphicsmagick-libmagick-dev-compat
RUN apt-get install -y libmagickcore-dev libmagickwand-dev

# for capybara-webkit
#RUN apt-get install -y libqt4-webkit libqt4-dev xvfb

# for a JS runtime
RUN apt-get install -y nodejs

ENV APP_HOME /myapp
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle install

ADD . $APP_HOME
