# Week 6 Assignment



library(tidyverse)

gapminder <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv")

# 1A.Modify the following code to make a figure that shows how life expectancy has changed over time:

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) + 
  geom_point()

ggplot(gapminder, aes(x = year , y = lifeExp)) + 
  geom_point()

# 1B. Look at the following code. What do you think the scale_x_log10() line is doing? What do you think the geom_smooth() line is doing?
  
#Hint: There’s no cost to tinkering! Try some code out and see what happens with or without particular elements.

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), size = .25) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()

# ANSWER:  It appears that the scale_x_log10 line is scaling the x axis such that the points are spread out and easier to observe a comparison, and the geom_smooth is centering the scaled data arond a central line.


# 1C. (Challenge!) Modify the above code to size the points in proportion to the population of the county. Hint: Are you translating data to a visual feature of the plot? 
#Save this code in your scripts folder and name is w6_assignment_ABC.R with your initials.

ggplot(gapminder, mapping =  aes(x = gdpPercap, y = lifeExp)) + 
  geom_point(aes(color = continent, size = pop)) +
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()






