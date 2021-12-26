# Sentiment Analysis is a process of extracting opinions that can be classified with
# different scores like positive, negative or neutral.
# Sentiment analysis is used to track attitudes and feelings on the web especially for 
# measuring performance of products, brands and services. 

# Upload the Resort data set (see below)

# It includes textual reviews from both online (e.g., TripAdvisor) 
# and offline (e.g., Guests' book) sources from the Areias do Seixo Eco-Resort (Portugal).

library(readxl)
library(ggplot2)
library(tidyverse)
sentiment2 <- read_excel("sentiment2.xlsx")
View(sentiment2)


# Dictionary-based methods --> find the total sentiment of a text 
# by adding up the individual sentiment scores for each word in the text.
# These methods are opposed to machine-learning based methods where it is not
# required to have a dictionary.
# Hence, dictionary-based methods relies on the use of a dictionary that contains a 
# list of negative/positive/neutral words and (eventually) their associated polarity scores. 


library(SentimentAnalysis) # Install this package, it takes some minutes
# https://cran.r-project.org/web/packages/SentimentAnalysis/SentimentAnalysis.pdf


# SentimentAnalysis package entails 3 different built-in dictionaries + 1 dictionary (QDAP) coming from another package:

# 1. Harvard-IV dictionary - DictionaryGI
# 2. Henry’s Financial dictionary (Henry 2008) -  DictionaryHE
# 3. Loughran-McDonald Financial dictionary (Loughran and McDonald 2011)  - DictionaryLM

# 4. QDAP dictionary from the package qdapDictionaries 

# We can inspect each of them
data(DictionaryLM)  
str(DictionaryLM)

data(DictionaryHE)  
str(DictionaryHE)

data(DictionaryGI)  
str(DictionaryGI)

# Notice that these dictionaries do not have the polarity scores (but only positive/negative/neutral), hence in this case 
# the sentiment index is simply given by the number of positive vs negative words. 


# Let's create the corpus - tm package
corpus_sentiment <- VCorpus(VectorSource(sentiment2$Text)) 

# Perform the sentiment analysis with the function 'analyzeSentiment'.
# Within this function you can directly perform the pre-processing steps.
system.time(sentiment <- analyzeSentiment(corpus_sentiment, # put the object of class corpus
                                          language = "english", # default
                                          removeStopwords = TRUE, # default
                                          stemming = TRUE, # default
                                          removePunctuation = T,
                                          removeNumbers = T,
                                          tolower = T))
# Note that 'analyzeSentiment' supports the tm functions for pre-processing

head(sentiment) 
# Result is a matrix with sentiment values for each document across all the dictionaries.
# In particular we are interested in the "Sentiment_XX" column (e.g. SentimentGI, SentimentHE and so on..), 
# which represents the general score defined as the difference between positive and negative words count divided by the
# total number of words.


# SENTIMENT INDEX = (#POSITIVE - #NEGATIVE)/# TOTAL WORDS  --> range in [-1, 1]

# NOTE !!!! The formula is referring to those words labeled as negative/positive in each specific dictionary


# The SENTIMENT INDEX value can also be obtained as the difference between POSITIVITY_XX - NEGATIVITY_XX, where
# POSITIVITY_XX and NEGATIVITY_XX are calculated following a specific rule which involves only the number of 
# positive and negative words, respectively. 

# (Rule for NEGATIVITY_XX = Ratio of the words labeled as negative in that dictionary compared to the total number of words in the
# document. The same rule is applied to calculate POSITIVITY_XX).


head(sentiment$SentimentQDAP) # Extract dictionary-based sentiment index according to the QDAP dictionary

head(sentiment$SentimentGI)
head(sentiment$SentimentLM)
head(sentiment$SentimentHE)
# The sentiment for each document differs according to the kind of dictionary used


# View sentiment direction (i.e. positive, neutral and negative)
x <- convertToDirection(head(sentiment$SentimentQDAP))
convertToDirection(head(sentiment$SentimentLM))

# Plot for a nice visualization
plot(convertToDirection(sentiment$SentimentGI),
     xlab = "Sentiment",
     ylab = "Absolute frequency",
     col = c("red", "yellow", "green"),
     ylim = c(0,15000))
plot(convertToDirection(sentiment$SentimentLM))
plot(convertToDirection(sentiment$SentimentHE))
plot(convertToDirection(sentiment$SentimentGI))
