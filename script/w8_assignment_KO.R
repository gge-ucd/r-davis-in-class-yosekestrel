# Week 8 Assignment

#### Part 1 =====
# Download a new American River data set using this piece of code:
  
library(tidyverse)
library(lubridate)

am_riv <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/2015_NFA_solinst_08_05.csv", skip = 13)
#should have a data frame with 35,038 obs of 5 variables

  # 1. Make a datetime column by using paste to combine the date and time columns; remember to convert it to a datetime!

am_riv$datetime <- paste(am_riv$Date, " ", am_riv$Time, sep = "")

am_riv$datetime <- ymd_hms(am_riv$datetime)

## Why does piping not work: am_riv$datetime <- paste(am_riv$Date, " ", am_riv$Time, sep = "") %>% ymd_hms(am_riv$datetime)
# Why does adding tz = "America/Los_Angeles" NOT WORK, gives "Warning: 4 failed to parse".

  # 2. Calculate the weekly mean, max, and min water temperatures and plot as a point plot (all on the same graph)

# group by week and calculate mean temp
am_riv_calculations <- am_riv %>% 
  mutate(weeks = week(Date)) %>%
  group_by(weeks) %>% 
  summarize(avg_temp = mean(Temperature), max_temp = max(Temperature), min_temp = min(Temperature))
  
am_riv_calculations %>%
  ggplot() +
  geom_point(mapping = aes(x = weeks , y = avg_temp, color = "blue")) +
  geom_point(mapping = aes(x =weeks, y = max_temp, color = "pink")) +
  geom_point(mapping = aes(x =weeks, y = min_temp, color = "green"))

# what's up with ggplot labeling pink "blue"??

# I first did this:
#am_riv_calculations <- am_riv %>% mutate(weeks = week(Date)) %>% group_by(weeks) %>% mutate(Temperature_mean = mean(Temperature)) WHICH created a new column in am_riv. I think I am getting hung up on the "disappearance" of columns, like here I now have only the grouped data, and below the key as well.
## Below is from key. I need a better understanding of what, where, when, why, and how the "$", I don't get it. Maybe because it has 'invisible steps'?
am_riv$wk <- week(am_riv$datetime)

  # 3. Calculate the hourly mean Level for April through June and make a line plot (y axis should be the hourly mean level, x axis should be datetime) I'm trying this one their way...

am_riv$hrly <- hour(am_riv$datetime)

#dt1 <- as.Date("2017-07-11")  This did not work.
#dt2 <- as.Date("2016-04-22")

# had to peek. I did not imtuit that I have to also make a column for month...
am_riv$month <- month(am_riv$datetime)

april_june_calc <- am_riv %>% 
  filter(month == 4 | month == 5 | month == 6) %>% 
  group_by(hrly, month, datetime) %>% 
  summarize(avg_level = mean(Level))

april_june_calc %>% 
    ggplot() +
    geom_line(mapping = aes(x=datetime, y = avg_level), color = "blue") +
    ylim(1.1, 1.9)

#### Part 2 ====

# Use the mloa_2001 data set (if you don’t have it, download the .rda file from the resources tab on the website). Remeber to remove the NAs (-99 and -999) and to create a datetime column (we did this in class).
  
load("data/mauna_loa_met_2001_minute.rda")
  
mloa_2001$datetime <- paste0(mloa_2001$year, "-", mloa_2001$month, "-", mloa_2001$day, " ", mloa_2001$hour24, ":", mloa_2001$min)

mloa_2001$datetime<- ymd_hm(mloa_2001$datetime)  

mloa_2001 %>% 
  filter(windSteady < 0, baro_hPa < 0)

mloa2 <- mloa_2001 %>% 
  filter(rel_humid != -99, rel_humid != -999) %>% 
  filter(temp_C_2m!= -99, temp_C_2m != -999) %>% 
  filter(windSpeed_m_s!= -99, windSpeed_m_s != -999)
  
# Then, write a function called plot_temp that returns a graph of the temp_C_2m for a single month. The x-axis of the graph should be pulled from a datetime column (so if your data set does not already have a datetime column, you’ll need to create one!)

# Hint! Take a look at the Challenge problem at the bottom of the functions lesson (https://gge-ucd.github.io/R-DAVIS/lesson_functions.html) to figure out how to feed a function a dataframe


plot_temp <- function(singlemonth, dat = mloa2){
  dataframe <- filter(dat, month == singlemonth)
  plot <- dataframe %>% 
    ggplot()+ geom_line(aes(x=datetime, y = temp_C_2m), color = "red")
  return(plot)
}

plot_temp(4)
  
# Save the code from Part 1 and 2 in your scripts folder and name is w8_assignment_ABC.R with your initials.
  