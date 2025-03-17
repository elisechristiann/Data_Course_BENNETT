library(tidyverse)
library(janitor)
library(gganimate)

dat <- 
  read.csv("BioLog_Plate_Data.csv") %>% clean_names()
View(dat)

#Cleans this data into tidy (long) form
#each column is one variable
#combine time points to find absorbance
#remove "well" column if needed (might not be)

clean_dat <- dat %>%
  pivot_longer(cols= c("hr_24","hr_48","hr_144"),
               names_to = "timepoint",
               values_to = "absorbance") %>%
  mutate(timepoint = as.numeric(gsub("hr_", "", timepoint)))
#gsub removes the Hr_ from the time points and converts to numeric


#Creates a new column specifying whether a sample is from soil or water
#new column who dis

#making separate lists to keep track of everything

water_column <-  c("Clear_Creek", "Waste_Water")
soil_column <- c("Soil_2", "Soil_1")

#making the column
source_dat <- clean_dat %>%
  mutate(source = case_when(
    sample_id %in% soil_column ~ "soil",
    sample_id %in% water_column ~ "water" ))
View(source_dat)

#Generates a plot that matches this one (note just plotting dilution == 0.1

source_dat %>%
  filter(dilution == 0.1) %>%
  ggplot(aes(x=timepoint, y=absorbance, color=source)) + geom_smooth(se=FALSE) + facet_wrap("substrate") +
  labs( x= "Time",
        y= "Absorbance",
        title= "Just dilution 0.1")
#Generates an animated plot that matches this one (absorbance values are mean of all 3 replicates for each group):
#This plot is just showing values for the substrate “Itaconic Acid”

source_dat %>%
  filter(substrate == "Itaconic Acid") %>%
  group_by(sample_id, dilution, timepoint) %>%
  summarize(Mean_absorbance=mean(absorbance, na.rm=TRUE)) %>%
  ggplot(aes(x= timepoint, y=Mean_absorbance, color=sample_id)) + geom_line() + facet_wrap("dilution") +
  transition_reveal(timepoint)

#I think done??


