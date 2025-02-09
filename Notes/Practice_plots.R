library(tidyverse)
library(RColorBrewer)

display.brewer.all()

iris %>%
  ggplot(aes(x=Petal.Length, y=Petal.Width, color=Species)) + geom_point() + 
  theme_replace() + geom_col(fill=color)
 


iris %>%
  ggplot(aes(x=Sepal.Length, y=Sepal.Width, color=Species)) + geom_point(alpha=0.85) + 
  scale_color_brewer(palette="OrRd") + geom_smooth(method="lm", alpha=0.20) +
  theme_minimal() +
  labs(
    title= "words",
    x="idk (cm)",
    y= "uhhh (cm)"
  )
midwest %>%
  ggplot(aes(x=popadults, y=area, color=state)) + geom_point() +
  scale_color_brewer(palette="YlGn")
