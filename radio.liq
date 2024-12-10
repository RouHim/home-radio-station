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

# Mix in some jingles, 1 in 5 tracks
radio = random(weights = [1, 4],[jingles_list, music_list])

# Apply cross fading
radio = crossfade(duration=10.0, fade_out=5.0, fade_in=5.0, radio)

# Add news for every hour
# https://github.com/savonet/liquidsoap/discussions/4004#discussioncomment-9962939
news_playlist = playlist("news.pls")
# Reload the news playlist shortly before playing,
# to get latest news and not old queued ones
thread.when(predicate.activates({ 59m }), fun() -> process.run("news.sh"))
thread.when(predicate.activates({ 59m45s }), fun() -> news_playlist.reload())
# Make a News source that is only active at certain times
# Hourly news 16s past the hour
# to leave room for station announcement
news = fallback(
  track_sensitive=false,
  [
    switch(
      id="news_switch",
      [(predicate.once({ (0m) and 0m16s }), news_playlist)]
    )
  ]
)
# When news source becomes active:
# Skip current track, play news, continue with new track
radio = fallback.skip(news, fallback=radio)

# TODO: add newshint every hour 00
news_into = single("news-into.flac")
radio = add([radio, switch([({0m0s},news_into)])])

# And finally the security
fallback_message = single("error.mp3")
radio = fallback(track_sensitive = false, [radio, fallback_message])

# Stream it out
output.icecast(
  # https://www.liquidsoap.info/doc-2.2.5/encoding_formats.html
  %vorbis(quality=0.9),
  host = "icecast",
  port = 8000,
  # TODO: use env var
  password = "haXX0r-Deströyer_123666_1337",
  mount = "radio.ogg",
  radio
)
