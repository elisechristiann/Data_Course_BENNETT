#SETUP ####

##load packages ####

#install.packages ("tidyverse")
library(tidyverse)

## load data ####

dat <- read_delim("./Data/DatasaurusDozen.tsv")

unique(dat$dataset)

#how to make a subset
star <- dat[dat$dataset=="star",]
plot(star$x,star$y)

filter(dat,dataset =="star")


#how to make a pipe 
dat %>%
  filter(dataset== "star") %>% 
    ggplot(aes(x,y)) + geom_point()

