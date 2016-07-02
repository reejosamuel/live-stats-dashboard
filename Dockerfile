FROM alpine:3.2
MAINTAINER jari@kontena.io

RUN apk update && apk --update add ruby ruby-irb ruby-json ruby-rake \
    ruby-bigdecimal ruby-io-console libstdc++ tzdata postgresql-client nodejs

ADD Gemfile /app/
ADD Gemfile.lock /app/

RUN apk --update add --virtual build-dependencies build-base ruby-dev openssl-dev \
    postgresql-dev libc-dev linux-headers && \
    gem install bundler && \
    cd /app ; bundle install --without development test && \
    apk del build-dependencies

ADD . /app
RUN chown -R nobody:nogroup /app
USER nobody

ENV RAILS_ENV production
ENV SECRET_KEY_BASE d7f2ff73171113d344f14c78a6359c2a2133ed1cdf66e87bea5ae667d885521447ac04f5a9f8aec0bfceca54f091a3423c249484bc527c0306646e53364add82
WORKDIR /app

EXPOSE 8080

# CMD ["bundle", "exec", "unicorn", "-p", "8080"]
CMD ["bundle", "exec", "rails", "s", "-p", "8080"]


