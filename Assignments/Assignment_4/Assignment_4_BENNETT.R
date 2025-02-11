library(tidyverse)

#Fake plot using fake data on effectors
#This is a very bad fake data set but I'm realizing how much data there is (lots)

dat <- read.csv("Fake_data_effectors_project.csv")

#This graph compares the amount of GC content in each effector depending on which pathogen it is from

dat %>%
  ggplot(aes(x=Effector, y=Percent_GC, fill=Pathogen)) + geom_col() +
  scale_fill_viridis_d(option="magma") + theme(axis.text.x =element_text(angle=90)) +
  labs( x="Effector",
        y="GC Content",
        title="Comparing GC Content among Different Effectors")
#As I learn more, I will hopefully be able to compare this data better in a more organized format
#I will hopefully be able to better compare each type of effector
#I will also hopefully have real data, but I am still searching for exactly what I want
