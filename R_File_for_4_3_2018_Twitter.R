## Twitter 

library(twitteR)
library(tm)
library(ggplot2)
library(dplyr)
library(wordcloud)
library(stringr)

library(syuzhet) ## lib for sentiments..There are aorund 10 classidied based on thousands of words


## setup twitter authenication

api_key = "yEgletu6TqMVo5TJDprhLYfib"
api_secret="zXuI4dSsJINJfIxIllgHm099EYuzhzkYhY5ZGkbMyu8W0aWe08"
access_token="981309851488964614-lMDG3MblVlKAjunLnRBSvmmx0lwcjSK"
access_token_secret="W7uKYkBTSBYdcGtdfXnkhwh8KVyITCzQslOSf8Ki7nP9R"


setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)


## serach data

uscTweets = searchTwitter("USC", n=100)
USCTW = twListToDF(uscTweets)  ## list to data farme

## analyize particuler person tweet ##########

### What is USCMarshall tweeting

user = getUser("USCMarshall")
usc= userTimeline(user, n=1000)
tweets = twListToDF(usc)


## clean the tweets and visualize them using a workcloud


nohandles = str_replace_all(tweets$text, 
                            pattern = "@\\w+", ## ?? what is this pattern??
                            replacement = "")
  

wordCorpus = Corpus(VectorSource(nohandles)) %>%  ## this text cleaup. Nothing do with Tweeter
    tm_map(removePunctuation) %>%
    tm_map(content_transformer(tolower)) %>%
    tm_map(removeWords, stopwords("english")) %>% ## a, are, is like
    tm_map(stripWhitespace)

set.seed(100) ##---> To get same putput... from everyone..not needed always
wordcloud(wordCorpus) 


wordcloud(wordCorpus,
          random.order =  FALSE,
          col="red") 


### sentiments analysis for USCMarshall tweets

library(syuzhet)

uscSentiments = get_nrc_sentiment(tweets$text)

data = apply(uscSentiments, MARGIN = 2, FUN = sum) ## marhhin can be 1 or 2, 1: row, 2: col, FUN --> funcation

data = data.frame(count = data)  ### ?? try to understand why he did it... 
data$emotion = row.names(data) ## add new column

ggplot(data, aes(y=count,x=reorder(emotion, count) )) +
  geom_col()


















