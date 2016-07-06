FROM alpine:3.2
MAINTAINER Reejo Samuel <m@reejosamuel.com>


RUN apk update && apk --update add ruby ruby-irb ruby-json ruby-rake \
    ruby-bigdecimal ruby-io-console libstdc++ tzdata postgresql-client nodejs

# Configure the main working directory. This is the base
# directory used in any further RUN, COPY, and ENTRYPOINT
# commands.
RUN mkdir -p /app
WORKDIR /app


# Copy the Gemfile as well as the Gemfile.lock and install
# the RubyGems. This is a separate step so the dependencies
# will be cached unless changes to one of those two files
# are made.
COPY Gemfile Gemfile.lock ./

RUN apk --update add --virtual build-dependencies build-base ruby-dev openssl-dev \
    postgresql-dev libc-dev linux-headers && \
    gem install bundler && \
    bundle install --jobs 20 --retry 5 --without development test && \
    apk del build-dependencies


# RUN gem install bundler && bundle install --jobs 20 --retry 5 --without development test
# Set Rails to run in production
ENV RAILS_ENV production
ENV RACK_ENV production


# Copy the main application.
COPY . ./

# RUN chown -R nobody:nogroup /app
# USER nobody

# Precompile Rails assets
RUN bundle exec rake assets:precompile

# Start puma
CMD bundle exec puma -C config/puma.rb
