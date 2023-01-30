FROM ruby:3.0.5-slim

RUN useradd -ms /bin/bash passenger \
    && apt-get update \
    && apt-get install gcc make curl -y --no-install-recommends \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /app \
    && chown passenger:passenger /app

COPY --chown=passenger:passenger . /app

WORKDIR /app

USER passenger

RUN bundle install \
    && passenger-config install-standalone-runtime \
    && passenger-config build-native-support

EXPOSE 3000

CMD ["passenger", "start"]