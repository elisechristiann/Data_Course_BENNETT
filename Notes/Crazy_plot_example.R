library(tidyverse)
library(palmerpenguins)
library(plotly)
library(RColorBrewer)


install.packages("palmerpenguins")
install.packages("plotly")

#how to put a graph into an object
p<-
iris %>%
  ggplot(aes(x=Petal.Length,
             y=Petal.Width, color=Species)) + geom_point()
#plot penguins (do not include Sex=NA) showing sex, bill, flipper

#my initial rough attempt (do not follow this it's bad)
penguins %>% names
dat<- penguins
dat$sex
is.na(dat$sex)
withsex <- 
  dat$sex[na.rm=FALSE]
dat$flipper_length_mm
dat$bill_length_mm
peng <-
  penguins %>% 
  ggplot(aes(x=flipper_length_mm, y=bill_length_mm, color=withsex)) +
  geom_point()

#the answer to how to build a graph with the above traits
penguins %>%
  filter(!is.na(sex)) %>%
  ggplot(aes(x=bill_length_mm, y=flipper_length_mm, color=sex)) +
  geom_point() + facet_wrap(~species)
  
#plot of male penguins only and body mass for each species

#how to make a custom color palette
grad <-
  RColorBrewer::brewer.pal(name='PuRd', n=3)

#crazy plot- practice for aes, scales, color, all customizations
penguins %>%
  filter(penguins$sex=="male") %>%
  ggplot(aes(x=species, y=body_mass_g, fill=species)) +
  geom_boxplot() + 
  scale_fill_viridis_d(option = 'inferno', end=0.8,begin=0.3) +
  labs( x="Penguin Species",
        y="Body Mass in grams",
        title = "Species vs Body Mass") + theme(legend.position = 'none') + 
  geom_jitter(width=0.05, color='black', alpha=0.25, aes(shape=species), size=30) +
  theme_minimal() + theme(panel.grid.major = element_line(color='black',
                                                          linetype=2),
                          panel.grid.minor = element_line(color="gray50")) +
  scale_shape_manual(values=c(8,11,23)) +
  theme(plot.background = element_rect(fill="yellow"), legend.title=element_text(face='bold', 
                                                                                 angle = 71,
                                                                                 hjust=0.5, 
                                                                                 color='orange',
                                                                                 size= 40),
        axis.title=element_text(color='#f705cb', size=22), legend.text=element_text(angle=180)) 


