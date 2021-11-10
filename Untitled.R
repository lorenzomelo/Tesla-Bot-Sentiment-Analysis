# Install the rtweet from CRAN
install.packages("rtweet")
install.packages("tidytext")

# Load rtweet package
library(rtweet)
library(dplyr)
library(tidyr)
library(tidytext)

# Authenticate using your credentials to Twitter’s API by creating an access token. 
# Steps on getting Twitter access tokens: https://cran.r-project.org/web/packages/rtweet/vignettes/auth.html

# Store api keys
api_key <- "rxTqQ97Bi4VL4R5KnL6eLTb6v"
api_secret_key <- "b7Xvpj0rnaZqFsQ2RYfUXrNah4nh7WXB21CPgpnoEU7RJ58Iaw"
access_token <- "1450915637547708425-zugL8tCvtKISQWKge1LhACqEVk9aoi"
access_token_secret <- "yy1ZY8VsBtqKfWcuqrMDAT5XGuQkRCNffTAa6jsziPArN"

token <- create_token (app = "Tesla Bot Sentiment Analysis",
             consumer_key = api_key,
             consumer_secret = api_secret_key,
             access_token = access_token,
             access_secret = access_token_secret)

sample1 <- search_tweets("#TeslaBot", n = 5, include_rts = FALSE)
sample1
