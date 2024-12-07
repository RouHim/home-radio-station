# Common config
log.stdout := true

# Music
music = medialib(persistency="/radio/database/music.json", "/radio/music/")
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
radio = crossfade(duration=5., fade_out=5., fade_in=5., radio)

# And finally the security
fallback_message = single("error.mp3")
radio = fallback(track_sensitive = false, [radio, fallback_message])

# Stream it out
output.icecast(
  %vorbis(samplerate=44100, channels=2, quality=1),
  host = "icecast",
  port = 8000,
  password = "haXX0r-Deströyer_123666_1337",
  mount = "radio.ogg",
  radio
)