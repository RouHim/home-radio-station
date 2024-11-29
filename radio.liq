# Music
myplaylist = playlist("music.pls")

# Jingles
jingles = playlist("jingles.pls")

# If something goes wrong, we'll play this
security = single("error.mp3")

# Start building the feed with music
radio = myplaylist

# Now add some jingles, 1 in 5 tracks
radio = random(weights = [1, 4],[jingles, radio])

# And finally the security
radio = fallback(track_sensitive = false, [radio, security])

# Stream it out
output.icecast(
  %vorbis,
  bitrate = 320,
  host = "icecast",
  port = 8000,
  password = "hackme",
  mount = "radio.ogg",
  radio
)