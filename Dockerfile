# Local preview only. GitHub Actions builds the live site.
# Keep the Ruby version in step with .ruby-version (used by the Action).
FROM ruby:3.4.12-slim-trixie

RUN apt-get update \
 && apt-get install -y --no-install-recommends build-essential git \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /site
COPY Gemfile Gemfile.lock ./
RUN bundle install

EXPOSE 4000 35729
