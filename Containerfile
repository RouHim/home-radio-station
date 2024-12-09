FROM docker.io/phasecorex/liquidsoap:latest

USER root

# Create radio working directory
RUN mkdir /radio && chown 1000:1000 /radio
USER 1000
WORKDIR /radio

# Copy radio files
COPY --chmod=755 --chown=1000 entrypoint.sh entrypoint.sh
COPY --chmod=755 --chown=1000 error.mp3 error.mp3
COPY --chmod=755 --chown=1000 radio.liq radio.liq

EXPOSE 8000
ENTRYPOINT ["/radio/entrypoint.sh"]
