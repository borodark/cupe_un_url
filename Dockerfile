FROM elixir:1.12-alpine
RUN      apk update && \
         apk upgrade && \
         apk --no-cache add \
         git openssh openssl-dev build-base bash vim emacs-nox busybox-extras sudo inotify-tools

RUN addgroup -S -g 1000 io && adduser -S -s /bin/bash -u 1000 io -G io

RUN echo "io ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/io \
        && chmod 0440 /etc/sudoers.d/io

USER io

RUN mix local.rebar --force &&  mix local.hex --force
