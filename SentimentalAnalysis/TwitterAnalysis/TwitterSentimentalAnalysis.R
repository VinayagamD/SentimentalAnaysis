#install recommended packages

#data preparation




#Trump Tweets
trump.tweets <- searchTwitter("DonaldTrump", n = 150)

#Convert List to dataframe
?do.call
trump.df <- do.call("rbind", lapply(trump.tweets, as.data.frame))

#Descriptive Statistics
head(trump.df)
dim(trump.df)
colnames(trump.df)
head(trump.df$text)


#Clean the tweet in twitter

trump.df$text <- sapply(trump.df$text, function(row) iconv(row, "latin1","ASCII", sub = ""))
trump_text <- sapply(trump.df$text, function(row) iconv(row, "latin1","ASCII", sub = ""))
trump.df$text <- gsub("(f|ht)tp(s?)://(.*)[.][a-z]", "", trump.df$text)

pos.words <- scan('positive-words.txt', what = 'character', comment.char = ";")
neg.words <- scan('negative-words.txt', what = 'character', comment.char = ";")

#additional words included
pos.words <- c(pos.words, 'Congrats', 'prizes', 'prize', 'thanks', 'thnx', 'Grt', 'gr8', 'plz', 'trending', 'recovering', 'brainstorm', 'leader')
neg.words <- c(neg.words, 'Fight', 'fighting', 'wtf', 'arrest', 'no', 'not')

sample <- trump.df$text



result <- score.sentiment(sample, pos.words, neg.words)

install.packages('reshape')
library(reshape)
test1 = result[[1]]
test2 = result[[2]]
test3 = result[[3]]

test1$text = NULL 
test2$text = NULL 
test3$text = NULL

q1 <- test1[1,]
q2 <- test2[1,]
q3 <- test3[1,]

qq1 = melt(q1, , var = 'Score')
qq2 = melt(q2, , var = 'Positive')
qq3 = melt(q3, , var = 'Negative')

qq1$Score = NULL
qq2$Positive = NULL
qq3$Negative = NULL

table1 = data.frame(Text = result[[1]]$text, Score = qq1)
table2 = data.frame(Text = result[[2]]$text, Score = qq2)
table3 = data.frame(Text = result[[3]]$text, Score = qq3)

table_final = data.frame(Text = table1$Text, Score = table1$value, Positive = table2$value, Negative = table3$value)

table_final

#Visualizing the data

#Histogram
hist(table_final$Positive, col=rainbow(10))
hist(table_final$Negative, col=rainbow(10))
hist(table_final$Score, col = rainbow(10))

#Pie
slices <- c(sum(table_final$Positive), sum(table_final$Negative))
labels <- c("Positive", "Negative")
#pie(slices, labels = labels, col = rainbow(length(labels)), main = "Sentiment Analysis")
install.packages('plotrix')
library(plotrix)

pie3D(slices, labels = labels, col = rainbow(length(labels)), explode = 0.25, main = "Sentimental Analysis")

