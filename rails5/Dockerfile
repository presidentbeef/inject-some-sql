FROM ruby:2.7.1-slim

RUN apt-get update; \
    apt-get install -y --no-install-recommends \
            build-essential \
            patch \
            sqlite3 \
            libsqlite3-dev;

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./

RUN gem install bundler -v 1.17.3; \
    bundle install;

COPY . .

RUN rails db:setup db:seed

CMD ["rails", "s", "-b", "0.0.0.0"]
