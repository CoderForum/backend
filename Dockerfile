FROM elixir:1.14.3-alpine AS build

ENV MIX_ENV=prod

WORKDIR /app

# get deps first so we have a cache
ADD mix.exs mix.lock /app/
RUN \
  cd /app && \
  mix local.hex --force && \
  mix local.rebar --force && \
  mix deps.get

# then make a release build
ADD . /app/
RUN \
  mix compile && \
  mix release

EXPOSE 80

CMD ["mix", "phx.server"]