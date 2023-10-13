FROM erlang:26-alpine

ENV ELIXIR_VERSION="v1.15.4" \
	LANG=C.UTF-8

WORKDIR /app

RUN set -xe \
	&& ELIXIR_DOWNLOAD_URL="https://github.com/elixir-lang/elixir/archive/${ELIXIR_VERSION}.tar.gz" \
	&& ELIXIR_DOWNLOAD_SHA256="302bf8065ab792a88f6c3a0c01a6bb58737be3e4fc2564c8afd418bf9792501c" \
	&& buildDeps=' \
		ca-certificates \
		curl \
		make \
        build-base \
        git \
        inotify-tools \
        openssh-client \
	' \
	&& apk add --no-cache --virtual .build-deps $buildDeps \
	&& curl -fSL -o elixir-src.tar.gz $ELIXIR_DOWNLOAD_URL \
	&& echo "$ELIXIR_DOWNLOAD_SHA256  elixir-src.tar.gz" | sha256sum -c - \
	&& mkdir -p /usr/local/src/elixir \
	&& tar -xzC /usr/local/src/elixir --strip-components=1 -f elixir-src.tar.gz \
	&& rm elixir-src.tar.gz \
	&& cd /usr/local/src/elixir \
	&& make install clean \
	&& find /usr/local/src/elixir/ -type f -not -regex "/usr/local/src/elixir/lib/[^\/]*/lib.*" -exec rm -rf {} + \
	&& find /usr/local/src/elixir/ -type d -depth -empty -delete \
    && mix local.hex --force \
    && mix local.rebar --force

COPY . .

RUN mkdir -p /root/.ssh \
	&& ssh-keyscan github.com >> /root/.ssh/known_hosts

RUN --mount=type=ssh HEX_HTTP_TIMEOUT=120 mix do deps.get, deps.compile 
