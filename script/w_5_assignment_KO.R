## WEEK 5 Assignment
#(Feel free to ingore my notes to self and questions. They are for me to remember to ask Martha & Michael during D-RUG user group time)


#Part I: Enter the Tidyverse

#1. Create a new script in your r-davis-in-class-yourname project, and name it w_5_assignment_ABC.R, with your initials in place of ABC. Save it in your scripts folder.

#2. Read portal_data_joined.csv into R using the tidyverse’s command called read_csv(), and assign it to an object named surveys.

library(tidyverse)

surveys <- read_csv("data/portal_data_joined.csv")

#3. Using tidyverse functions and pipes, subset to keep all the rows where weight is between 30 and 60, then print the first few (maybe… 6?) rows of the resulting tibble.
surveys %>%
  filter(weight > 30) %>% 
  filter(weight < 60) %>% View()

#4. Make a tibble that shows the max (hint hint) weight for each species+sex combination, and name it biggest_critters. Use the arrange function to look at the biggest and smallest critters in the tibble (use ?, tab-complete, or Google if you need help with arrange).

biggest_critters <- surveys %>% 
  select (species, sex, weight) %>% 
  group_by(species) %>% 
  arrange(species, desc(weight)) %>% View()

#not sure if we were being asked to do this for "surveys" or for the previously filtered "surveys," so I did both

biggest_critters <- surveys %>%
  filter(weight > 30) %>% 
  filter(weight < 60) %>% 
  select (species, sex, weight) %>% 
  group_by(species) %>% arrange(species, desc(weight)) %>% View()

# ????? Not sure how to make a tibble with just the max. SO far I have all in descending order...
# Not sure why biggest_critters is not a data fram and empty

#5. Try to figure out where the NA weights are concentrated in the data- is there a particular species, taxa, plot, or whatever, where there are lots of NA values? There isn’t necessarily a right or wrong answer here, but manipulate surveys a few different ways to explore this. Maybe use tally and arrange here.

#This?

surveys %>% filter(is.na(weight)) %>% arrange(plot_id, species, taxa)

surveys %>% group_by(is.na(weight)) %>% arrange(plot_id, species, taxa, plot_type, year) %>% tally()

## THIS is now giving me something more meaningful...
surveys %>% group_by(species_id, plot_id, taxa, year, weight) %>% arrange(is.na(weight)) %>% tally()

# Still cannot see just tally of each group with compared weights
# maybe....

total_NAs <- surveys %>% group_by(species_id, plot_id, taxa, year, weight) %>% arrange(is.na(weight)) %>% tally()

total_NAs %>% tally(weight) %>% View()

# %>% group_by(plot_id, year, taxa), SEEMS LIKE this is giving the same result as the filter above... I have tried all I can figure and I just can't seem to figure out how to have R tell me which variable from the plot_id, species, year, etc. are the ones with NAs, where the NAs are concentrated. The closest I have gotten is below where I can figure which has the most NAs

#This? NOPE!
surveys %>%
  group_by(is.na(weight)) %>% arrange(species_id) %>% tally()

surveys %>%
  group_by(is.na(hindfoot_length)) %>% arrange(hindfoot_length) %>% View()

surveys %>%
  group_by(is.na(weight)) %>% 
  tally()

## SENT EMAIL ASKING FOR HELP TO MARTHA, MONDAY @ 9:48 AM


#6. Take surveys, remove the rows where weight is NA and add a column that contains the average weight of each species+sex combination. Then get rid of all the columns except for species, sex, weight, and your new average weight column. Save this tibble as surveys_avg_weight. The resulting tibble should have 32,283 rows.

surveys %>%
  filter(!is.na(weight)) %>% 
  mutate(average_weight = mean(weight)) %>% View()
# why are these (above/below) not the same?
surveys %>% mutate(average_weight = mean(weight,na.rm = TRUE)) %>% View()
  
## Can't seem to figure out how to do species+sex combination...
  
#surveys %>% filter(!is.na(weight)) %>%  group_by(sex, species_id, plot_id, taxa, year) %>% summarize(average_weight = mean(weight)) %>% View()
#surveys %>% group_by(!is.na(weight)) %>% mutate(average_weight = mean(weight)) %>% View()

# THIS IS IT??!? I think :)
surveys_avg_weight <- surveys %>%
  filter(!is.na(weight)) %>% 
  mutate(average_weight = mean(weight,na.rm = TRUE)) %>% 
  group_by(sex, species) %>% select(species, sex, weight, average_weight)

#7. Challenge: Take surveys_avg_weight and add a new column called above_average that contains logical values stating whether or not a row’s weight is above average for its species+sex combination (recall the new column we made for this tibble).

# "logical values" = ????

surveys_avg_weight %>% mutate(above_average = average_weight > weight) %>% View()


#8. Extra Challenge: Figure out what the scale function does, and add a column to surveys that has the scaled weight, by species. Then sort by this column and look at the relative biggest and smallest individuals. Do any of them stand out as particularly big or small?

surveys_avg_weight$weight %>% scale(center = TRUE, scale = TRUE) %>% View()

## I have not conmpleted this last one, AND I amwaiting to hear back from Martha on #5









  