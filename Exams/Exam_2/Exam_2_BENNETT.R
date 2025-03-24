library(tidyverse)
library(easystats)
library(janitor)
library(modelr)
library(MASS)
library(caret)

#1. Read in the unicef data (10 pts) 2. 
#Get it into tidy format (10 pts) 
#3. Plot each country’s U5MR over time (20 points)

dat <- read_csv("unicef-u5mr.csv") %>% clean_names()
View(dat)

dat_clean <- dat %>%
  pivot_longer(cols=starts_with("u5mr"),
               names_to="year",
               values_to="u5mr",
               values_drop_na = TRUE) %>%
  mutate(year=as.numeric(gsub("u5mr_","",year)))


View(dat_clean)

plot1 <- dat_clean %>%
  ggplot(aes(x=year, y=u5mr, group=country_name)) + geom_line() + facet_wrap(~continent) +
  labs(x= "Year",
       y="U5MR")

ggsave(filename = "BENNETT_Plot_1.png", plot= plot1, dpi=300, width=10, height=6)

#. Save this plot as LASTNAME_Plot_1.png (5 pts) 

#5. Create another plot that shows the mean U5MR for all the countries within a given continent at each year (20 pts)

plot2 <- dat_clean %>%
  group_by(year, continent)%>%
  summarise(Mean_U5MR=mean(u5mr, na.rm=TRUE)) %>%
  ggplot(aes(x=year, y=Mean_U5MR, color=continent))+ geom_line(linewidth=1) + labs(x= "Year",
                                                                        y= "Mean_U5MR")


#6. Save that plot as LASTNAME_Plot_2.png (5 pts) 

ggsave(filename= "BENNETT_Plot_2.png", plot=plot2, dpi= 300, width=10, height=6)

#7. Create three models of U5MR (20 pts)

#mod1 should account for only Year
# mod2 should account for Year and Continent
#mod3 should account for Year, Continent, and their interaction term

mod1 <- dat_clean %>% 
  glm(data = ., 
      formula= u5mr~ year)

mod2<- dat_clean %>% 
  glm(data = ., 
      formula= u5mr~ year + continent)

mod3 <- dat_clean %>% 
  glm(data = ., 
      formula= u5mr~ year* continent)

# I think number 3 will be the most accurate model in comparing the death rate as a function of the year and continent and their interaction
#8. Compare the three models with respect to their performance


compare_performance(mod1, mod2, mod3)
compare_performance(mod1, mod2, mod3) %>% plot()

#9. Plot the 3 models’ predictions like so: (10 pts)
#df <- gather_predictions(iris, mod1,mod2,mod3) 

df <- gather_predictions(dat_clean, mod1,mod2,mod3)
df

plot3 <- df%>% ggplot(aes(x=year, y=pred, color=continent)) + geom_line(linewidth=1) + facet_wrap(~model) +
  labs(x= "Year",
       y= "Mean_U5MR",
       title= "Model predictions")
ggsave(filename = "BENNETT_Plot_3.png", plot= plot3, dpi=300, width=10 , height=6)

#10. BONUS - Using your preferred model, predict what the U5MR would be for Ecuador in the year 2020. 
#The real value for Ecuador for 2020 was 13 under-5 deaths per 1000 live births. How far off was your model prediction???

#Your code should predict the value using the model and calculate the difference between the model prediction and the real value (13).


ecuador <- data.frame(continent="Americas",
                      country_name="Ecuador",
                      year=2020)
ecuador$pred <- predict(object=mod3, newdata = ecuador)
ecuador$actual <- 13

ecuador$error <- abs(ecuador$pred - ecuador$actual)

View(ecuador)

mod4 <- dat_clean %>%
  glm(data=., formula=u5mr~ .)

compare_performance(mod3, mod4) %>% plot()
