tw <- userTimeline("BarackObama", n = 3200)
tw <- twListToDF(tw)
vec1 <- tw$text

#Extract HashTag
hash.patterns <- "#[[:alpha:]]+"
have.hash <- grep(x = vec1, pattern = hash.patterns) #stores the tweets which have hashes
hash.matches <- gregexpr(pattern = hash.patterns, text = vec1[have.hash])
extracted.hash <- regmatches(x = vec1[have.hash], m = hash.matches)

hash.tag.df <- data.frame(table(tolower(unlist(extracted.hash))))
colnames(hash.tag.df) <- c("tag", "freq")
hash.tag.df = hash.tag.df[order(hash.tag.df$freq, decreasing = T),]

dat <- head(hash.tag.df, 50)
dat2 <- transform(dat, tag = reorder(tag, freq))
?transform

install.packages('ggplot2')
library(ggplot2)
p = ggplot(dat2, aes(x = tag, y = freq)) + geom_bar(stat = "identity", fill = "blue")
p + coord_flip() + labs(title= "Hashtag frequencies in th tweets of the Obama team (@BarackObama)")