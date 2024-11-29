# TODO: anstatt manueles genereiren iner playlist, liquidsoap feature verwenden: https://www.liquidsoap.info/doc-2.2.5/cookbook.html#generating-playlists-from-a-media-library

# Common config
log.stdout := true

# Music
music_playlist = playlist("music.pls")

# Jingles
jingles_playlist = playlist("jingles.pls")

# If something goes wrong, we'll play this
security = single("error.mp3")

# Start building the feed with music
radio = music_playlist

# Now add some jingles, 1 in 5 tracks
radio = random(weights = [1, 4],[jingles_playlist, radio])

# Apply cross fading
radio = crossfade(duration=5., fade_out=5., fade_in=5., radio)

# And finally the security
radio = fallback(track_sensitive = false, [radio, security])

# Stream it out
output.icecast(
  %vorbis(samplerate=44100, channels=2, quality=1),
  host = "icecast",
  port = 8000,
  password = "haXX0r-Deströyer_123666_1337",
  mount = "radio.ogg",
  radio
)