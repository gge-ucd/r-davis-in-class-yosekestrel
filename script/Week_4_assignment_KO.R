## Week_4_assignment

surveys <- read.csv(file = "data/portal_data_joined.csv")

#remember that [1,1] is [row,column]
surveys_subset <- surveys[ 1:400,c(1, 5:8) ]


#surveys_subset[ ,5]

#surveys_subset[["hindfoot_length"]]

#hindfoot_length <- surveys_subset[ ,5]

#hindfoot_length > 32

#surveys_subset[c(hindfoot_length > 32), ]

surveys_long_feet <-surveys_subset[c(hindfoot_length > 32), ]

surveys_long_feet[c(hindfoot_length > 32), ]

# I am not sure why I can not separating only the rows I want, the ones with hindfoot_length >32...
 
surveys_long_feet <- surveys_subset[["hindfoot_length"]]


hist(hindfoot_length, )  #???
hist(surveys_long_feet,)


as.character(hindfoot_length)
hist(hindfoot_length)

## Ummm, a bit lost on this last bit, #4&6
