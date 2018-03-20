#Twitter Tokens 
#install.packages(c("twitteR","ROAuth"))
consumer.token <- 'CWpVX762aYsmM7AzlRYQZEXO2'
consumer.secret <- 'Gggt6BP2AD5tqJYGLCbPgYkKlZvg5XLTle2ssiJNGZhsTpuI1S'
api.token <- '396442752-iPq6G6AnkYpxJ7fKZfpcbilcOjimQrNfQ3CK1HI7'
api.secret <- 'fUMySwMTFVNrfiki5eKjc5YgrI7AcAAuGP3KZQ8P5JWJT'

library(twitteR)
library(ROAuth)


download.file(url = "http://curl.haxx.se/ca/cacert.pem", destfile = "cacert.pem") #downloads the certificate

setup_twitter_oauth(consumer.token, consumer.secret, api.token, api.secret)

cred <- OAuthFactory$new(consumerKey = consumer.token,
    consumerSecret = consumer.secret,
    requestURL = 'https://api.twitter.com/oauth/request_token',
    accessURL = 'https://api.twitter.com/oauth/access_token',
    authURL = 'https://api.twitter.com/oauth/authorize')