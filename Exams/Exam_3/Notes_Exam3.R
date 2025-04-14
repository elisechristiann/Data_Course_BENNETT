library(tidyverse)

dat <- read_csv("FacultySalaries_1995.csv")
View(dat)

#1. clean data so that it matches the graph

#pull out tier, pull out salary

dat1 <- dat %>%
  filter(Tier %in% c("I", "IIA","IIB")) %>%
  select("Tier", Full="AvgFullProfSalary", Assoc="AvgAssocProfSalary", Assist="AvgAssistProfSalary") %>%
  pivot_longer(cols= c(Full,Assoc, Assist),
               names_to= "Rank", values_to = "Salary")
View(dat1)

dat1 %>%
  ggplot(aes(x=Rank, y=Salary, fill = Rank)) + geom_boxplot() + facet_wrap("Tier") + theme_minimal() + 
  theme(axis.text.x = element_text(angle=45))
