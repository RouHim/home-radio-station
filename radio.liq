# Common config
log.stdout := true

# https://www.liquidsoap.info/doc-2.3.0/reference.html#enable_autocue_metadata
enable_autocue_metadata()

# Music
music = medialib.sqlite(database="/radio/database/music.db", "/radio/music/")
music_playlist = music.find()
music_playlist = list.shuffle(music_playlist)
music_list = playlist.list(music_playlist)

# Jingles
jingles = medialib(persistency="/radio/database/jingles.json", "/radio/jingles/")
jingles_playlist = jingles.find()
jingles_playlist = list.shuffle(jingles_playlist)
jingles_list = playlist.list(jingles_playlist)

# Now add some jingles, 1 in 5 tracks
radio = random(weights = [1, 4],[jingles_list, music_list])

# Apply cross fading
radio = crossfade(radio)

# And finally the security
fallback_message = single("error.mp3")
radio = fallback(track_sensitive = false, [radio, fallback_message])

# Stream it out
output.icecast(
  # https://www.liquidsoap.info/doc-2.2.5/encoding_formats.html
  %vorbis(quality=0.8),
  host = "icecast",
  port = 8000,
  # TODO: use env var
  password = "haXX0r-Deströyer_123666_1337",
  mount = "radio.ogg",
  radio
)
