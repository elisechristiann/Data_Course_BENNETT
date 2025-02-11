# YOUR TASKS:
library(tidyverse)

#I.
 # Read the cleaned_covid_data.csv file into an R data frame. (20 pts)

dat <- 
  read.csv("cleaned_covid_data.csv")
view(dat)

  
  #II.
  #Subset the data set to just show states that begin with "A" and save this as an object called A_states. (20 pts)
  
  #+ Use the *tidyverse* suite of packages
#+ Selecting rows where the state starts with "A" is tricky (you can use the grepl() function or just a vector of those states if you prefer)

A_states <- 
  dat %>%
  filter(grepl(pattern="^A", x=Province_State, ignore.case=TRUE )) 
view(A_states)

#III.
 #Create a plot _of that subset_ showing Deaths over time, with a separate facet for each state. (20 pts)

# convert Last_Update data type from chr to Date 
A_states_dates <- A_states %>%
  mutate(Last_Update = as.Date(Last_Update))

  #+ Create a scatterplot
#+ Add loess curves WITHOUT standard error shading
#+ Keep scales "free" in each facet
A_states_dates %>%
  ggplot(aes(x=Last_Update, y=Deaths)) + geom_point(size=0.3) +
  geom_smooth(method="loess", se=FALSE, color='orange', linewidth=1) + 
  facet_wrap(~ Province_State, scales="free") + theme_minimal() +
  labs( x="Dates",
        y="Deaths",
        title="COVID-19 Deaths in select states between 2020-2022")

  

#*IV.** Back to the full dataset
#*Find the "peak" of Case_Fatality_Ratio for each state and save this as a new data frame object called state_max_fatality_rate. (20 pts)**
  
state_max_fatality_rate <- 
  dat %>%
  group_by(Province_State) %>%
  summarise(Maximum_Fatality_Ratio = max(Case_Fatality_Ratio, na.rm=TRUE)) %>% 
  arrange(desc(Maximum_Fatality_Ratio))
view(state_max_fatality_rate)
 
# I'm looking for a new data frame with 2 columns:

 #+ "Province_State"
 #+ "Maximum_Fatality_Ratio"
 #+ Arrange the new data frame in descending order by Maximum_Fatality_Ratio
 
#This might take a few steps. Be careful about how you deal with missing values!




#V.
#Use that new data frame from task IV to create another plot. (20 pts)**

#+ X-axis is Province_State
#+ Y-axis is Maximum_Fatality_Ratio
#+ bar plot
#+ x-axis arranged in descending order, just like the data frame (make it a factor to accomplish this)
#+ X-axis labels turned to 90 deg to be readable

state_max_fatality_rate %>%
  mutate(Province_State= factor(Province_State, levels=Province_State)) %>%
  ggplot(aes(x=Province_State, y=Maximum_Fatality_Ratio)) + geom_bar(stat='identity') +
  theme(axis.text.x = element_text(angle=90)) + labs( x="States",
                                                      y="Maximum Fatality Ratio",
                                                      title="State vs Maximum Fatality Ratio")

 
#Even with this partial data set (not current), you should be able to see that (within these dates), different states had very different fatality ratios.

#VI.** (BONUS 10 pts)
#Using the FULL data set, plot cumulative deaths for the entire US over time**

#You'll need to read ahead a bit and use the dplyr package functions group_by() and summarize() to accomplish this.

cumulative_deaths_us <- dat %>%
  group_by(Last_Update) %>%
  reframe(Cumulative_Deaths= cumsum(Deaths)) %>%
  arrange(Last_Update)

cumulative_deaths_us %>%
  ggplot(aes(x=Last_Update,y=Cumulative_Deaths)) + geom_line() +
  labs( x="Date from 2020-2022",
       y="Cumulative Deaths",
       title="Cumulative Deaths in US")


