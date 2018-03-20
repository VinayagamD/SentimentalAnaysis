#Information Analysis using wordcloud
install.packages(c('tm', 'wordcloud'))

library(tm)
trum.corpus <- Corpus(VectorSource(trump_text)) #corpus collection of texgt document from NLP package in R

? Corpus
inspect(trum.corpus[2])

library(wordcloud)
trump_clean <- tm_map(trum.corpus, removePunctuation)
trump_clean <- tm_map(trum.corpus, content_transformer(tolower))
trump_clean <- tm_map(trump_clean, removeWords, stopwords("english"))
trump_clean <- tm_map(trump_clean, removeNumbers)
trump_clean <- tm_map(trump_clean, stripWhitespace)
wordcloud(trump_clean, random.order = F, max.words = 80, col = rainbow(50), scale = c(3.5, 1))

