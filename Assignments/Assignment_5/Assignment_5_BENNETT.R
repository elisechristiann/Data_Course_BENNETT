library(tidyverse)
library(palmerpenguins)
library(patchwork)
library(ggimage)
library(ggthemes)


img= "https://media.tenor.com/y8rHuLxvHmYAAAAe/sad-cat.png"
img2="https://i.imgflip.com/54o27s.png"
img3= "https://www.kindpng.com/picc/m/319-3192712_sad-cat-png-transparent-png.png"



p1 <- penguins %>%
  ggplot(aes(x=flipper_length_mm, y=bill_depth_mm, fill=species)) + geom_col() +
  theme_excel() + scale_fill_gdocs() + labs( x= "i hate penguins",
                                           y= "penguin penguin penguin",
                                           title= "don't care") +
  theme(axis.title = element_text(color="purple", size=45, angle=22))
 
plot1 <- ggbackground(p1, img)


p2 <- iris %>%
  ggplot(aes(x=Petal.Length, y=Petal.Width, color=Species)) + geom_point() + theme_wsj()+
  theme(axis.title.y = element_text(color="hotpink", angle=69)) + 
  annotate("text", x = 2, y = 1.5, label = "i am ok", color = "#6e730d", size = 8)

plot2 <- ggbackground(p2, img2)

p3 <- mtcars %>%
  ggplot(aes(x=gear, y=mpg, fill=gear)) + geom_col()+ 
  annotate("text", x = 4, y = 100, label = "this is a cry for help", color = "#ff00e1", size = 8, alpha=0.40)+
  theme(legend.title=element_text(angle=180, color="#00f7ff", size= 60)) + 
  labs( x="gear", y="gear", title="gear", subtitle="car go vroom vroom") +
  theme(axis.title = element_text(color="#e3e19d", size= 40, angle=69))
  
plot3 <- ggbackground(p3, img3)

(plot1 | plot2) / plot3
