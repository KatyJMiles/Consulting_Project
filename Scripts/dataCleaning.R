## This script is the first step in data cleaning of the original data

library(readxl)
library(tidyverse)

# Read in original data
original_data = read_excel("Input/James Musetti Thesis Data Summary.xlsx")

# Extract column names
colnames = colnames(original_data)
groupings = c(rep("Predictors", 9),
              rep("Process Data", 6),
              rep("Biochemical Data", 17),
              rep("Sensory Data", 19))


# Create column for groups
colnames(original_data) = original_data[1,]
clean_data = original_data[-(1:2),]
clean_data = rbind(groupings, clean_data)

# Create a long format
long_data = pivot_longer(clean_data[-1,], cols = 10:51, names_to = "Response")
groupings = c(rep("Process Data", 6),
              rep("Biochemical Data", 17),
              rep("Sensory Data", 19))
long_data = cbind(Grouping = rep(groupings, 16), long_data)

write.csv(long_data, "Input/longData.csv")
