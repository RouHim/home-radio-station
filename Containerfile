####################
#    Run Image     #
####################
FROM docker.io/alpine:3

# Install liquidsoap using opam
RUN apk update && apk add git wget curl bash

# Install liquidsoap dependencies
RUN apk update && apk add opam build-base git curl-dev ffmpeg-dev flac-dev libogg-dev linux-headers opus-dev pcre-dev libvorbis-dev pkgconf

# Create non root user
RUN adduser -D radio -u 1000
RUN addgroup radio radio
RUN mkdir /radio && chown radio:radio /radio

USER radio
WORKDIR /radio

RUN opam init --disable-sandboxing --auto-setup --yes
RUN opam install ffmpeg opus flac ogg cry vorbis liquidsoap --confirm-level=unsafe-yes

COPY --chmod=755 build-pls.sh build-pls.sh
COPY --chmod=755 entrypoint.sh entrypoint.sh
COPY --chmod=755 radio.liq radio.liq
COPY --chmod=755 error.mp3 error.mp3

EXPOSE 8000
ENTRYPOINT ["/radio/entrypoint.sh"]