library(academictwitteR)

set_bearer()

tweets2 <-
  get_all_tweets(
    query = "#Teslabot lang:en",
    start_tweets = "2020-01-01T00:00:00Z",
    end_tweets = "2021-11-12T00:00:00Z",
    file = "blmtweets",
    data_path = "data2/",
    n = 100000,
)

df <- as.data.frame(tweets2$text)
text2 <- write.csv(df, "output.csv")
