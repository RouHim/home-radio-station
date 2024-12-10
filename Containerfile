FROM docker.io/rouhim/liquidsoap:latest

USER root

# Install curl, cron and disable package manager
RUN apt-get update && apt-get install -y curl cron \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create radio working directory
RUN mkdir /radio && chown 1000:1000 /radio
USER 1000
WORKDIR /radio

# Copy radio files
COPY --chmod=755 --chown=1000 entrypoint.sh entrypoint.sh
COPY --chmod=755 --chown=1000 news.sh news.sh
COPY --chmod=755 --chown=1000 audio-files/news-into.flac news-into.flac
COPY --chmod=755 --chown=1000 audio-files/error.mp3 error.mp3
COPY --chmod=755 --chown=1000 radio.liq radio.liq

EXPOSE 8000
ENTRYPOINT ["/radio/entrypoint.sh"]
