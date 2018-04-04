## data 
## http://www.nfl.com/stats/player?seasonId=2014&seasonType=PRE&Submit=Go

## click complete list of cgarging yard:
## http://www.nfl.com/stats/categorystats?tabSeq=0&statisticCategory=PASSING&conference=null&season=2014&seasonType=PRE&d-447263-s=PASSING_YARDS&d-447263-o=2&d-447263-n=1


library(rvest)
library(ggplot2)
library(dplyr)
library(lubridate)
library(stringr)

## page 1

page1= "http://www.nfl.com/stats/categorystats?tabSeq=0&statisticCategory=PASSING&conference=null&season=2014&seasonType=PRE&d-447263-s=PASSING_YARDS&d-447263-o=2&d-447263-n=1"

page2= "http://www.nfl.com/stats/categorystats?tabSeq=0&season=2014&seasonType=PRE&d-447263-n=1&d-447263-o=2&d-447263-p=2&conference=null&statisticCategory=PASSING&d-447263-s=PASSING_YARDS"


page3= "http://www.nfl.com/stats/categorystats?tabSeq=0&season=2014&seasonType=PRE&d-447263-n=1&d-447263-o=2&statisticCategory=PASSING&conference=null&d-447263-p=3&d-447263-s=PASSING_YARDS"



## open html --> inspect of table -->  copy xpath


p1 = page1 %>%
  read_html() %>%
  html_nodes(xpath='//*[@id="result"]') %>%  ## here we have use node
  html_table()

## diff between date and data frame:

p1= p1[[1]]  ## This is to make sure to access 1st element of our dataframe


p2 = page2 %>%
  read_html() %>%
  html_nodes(xpath='//*[@id="result"]') %>%  ## here we have use node
  html_table()


p2= p2[[1]] 


### combined two tables : Rbind or cbind ??? Diff??


p3 =page3 %>%
  read_html() %>%
  html_nodes(xpath='//*[@id="result"]') %>%  ## here we have use node
  html_table()

p3= p3[[1]]

riable
data = rbind(p1,p2,p3)


## create the the data plot to show the top 10 players using
## the Rate Varibale




## using dplr

top_1o =  data %>%
   top_n(10, Rate) 

## remeber: Rate need to be X and y need reorder
ggplot(top_1o, aes(x=Rate, y=reorder(Player, Rate))) +
  geom_point() +
  xlab("Rate") +
  ylab("") +
  ggtitle("Highest Players by Rates") +
  theme(axis.title = element_text(size = 18, face = "bold"),
        axis.title.x = element_text(size =12 ),
        title = element_text(size = 20, face = "bold"))


#### List of counties by polutaion https://en.wikipedia.org/wiki/List_of_countries_and_dependencies_by_population
## get each country
## total polutaion of the world

pop_url = "https://en.wikipedia.org/wiki/List_of_countries_and_dependencies_by_population"

pop_list = pop_url %>%
  read_html() %>%
  html_nodes(xpath='//*[@id="mw-content-text"]/div/table[2]') %>%  ## here we have use node
  html_table()

pop_list= pop_list[[1]] 

## notic that below code will not work because it has , and converion fails
sum(as.numeric(pop_list$Population))


## Poluation has comman. Need to remove the , 

pop_list$Population = str_replace_all(pop_list$Population,
                                      pattern = ",",
                                      replace= "")

pop_list$Population = as.numeric(pop_list$Population)

sum(pop_list$Population)


###########chnage date to redable date by R

pop_list$Date = mdy(pop_list$Date)





  

