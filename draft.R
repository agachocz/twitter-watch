# installing packages

install.packages("rtweet")
install.packages("tidyverse")
install.packages("httpuv")
install.packages("devtools")
install.packages("textclean")
devtools::install_github("hadley/emo")
library(rtweet)
library(tidyverse)
library(emo)
library(textclean)

# define searching phrases
economics <- c("ekonomia", "ekonomiczna", "ekonomiczny", "ekonomiczne", "gospodarka", "gospodarczy", 
               "gospodarce", "gospodarką", "rynek", "rynkowe", "rynkowa", "rynku", "rynki")
econ_query <- paste(economics, collapse = ' OR ')

tweets <- search_tweets(econ_query, n = 100, include_rts = FALSE, lang = 'pl')
tweets %>% head(5) %>% select(text, screen_name)

tweets %>% 
  sample_n(5) %>%
  select(created_at, screen_name, text, favorite_count, retweet_count)

ts_plot(tweets, "mins") +
  labs(x = NULL, y = NULL,
       title = "Frequency of tweet",
       subtitle = paste0(format(min(tweets$created_at), "%d %B %Y"), " to ", format(max(tweets$created_at),"%d %B %Y")),
       caption = "Data collected from Twitter's REST API via rtweet") +
  theme_minimal()

# most of the tweets don't have set location
tweets %>% 
  filter(!is.na(place_full_name)) %>% 
  count(place_full_name, sort = TRUE) %>% 
  top_n(5)

tweets %>% 
  arrange(-favorite_count) %>%
  slice(1) %>% 
  select(screen_name, status_id)

# tweet_screenshot(tweet_url("Mikey_Satoshi", "1444713486383190036")) function doesn't exist???

tweets %>% 
  count(screen_name, sort = TRUE) %>%
  top_n(10) %>%
  mutate(screen_name = paste0("@", screen_name))


tweets %>%
  mutate(emoji = ji_extract_all(text)) %>%
  unnest(cols = c(emoji)) %>%
  count(emoji, sort = TRUE) %>%
  top_n(10)


# stream of tweets
stream <- search_tweets('a OR o OR e OR i OR u OR y', n = 1000, lang = 'pl')

stream %>% select(status_id, text) %>% write.csv("tweet_stream.csv")

                  