# delete "miesiąc", "duma"
keywords <- c("pride", "month", "miesiąc", "dumy", "duma", "tęcza", "tęczowy", "tęczowe", "rainbow", "LGBT", "lgbt")
query <- paste(keywords, collapse = ' OR ')

tweets <- search_tweets(query, n = 100, include_rts = FALSE, lang = 'pl')
tweets %>% head(5) %>% select(text, screen_name)

ts_plot(stream, "mins") +
  labs(x = NULL, y = NULL,
       title = "Frequency of tweet",
       subtitle = paste0(format(min(tweets$created_at), "%d %B %Y"), " to ", format(max(tweets$created_at),"%d %B %Y")),
       caption = "Data collected from Twitter's REST API via rtweet") +
  theme_minimal()

stream <- search_tweets(query, n = 10000, lang = 'pl', max_id = min(stream$status_id))

stream %>% select(user_id, status_id, created_at, screen_name, text, reply_to_status_id,
                  reply_to_user_id, reply_to_screen_name, is_retweet, is_quote, favorite_count,
                  retweet_count, quote_count, reply_count) %>% write.csv("tweet_stream_4.csv")
