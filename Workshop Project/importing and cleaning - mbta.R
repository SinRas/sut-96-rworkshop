# Required Librarires
library(readxl)
library(tidyr)
library(reshape2)

# Load the data
mbta = read_excel('data/DataCamp/Importing and Cleaning Data in R - Case Studies/mbta.xlsx', skip = 1)

# Structure of mbta
str(mbta)

# First rows
head(mbta, 6)

# Summary
summary(mbta)

# Remove rows 1, 7 and 11 of mbta: mbta2
mbta2 = mbta[-c(1,7,11), ]

# Remove first column
mbta3 = mbta2[, -1]

# Gather -> Wide to Long: mbta4
mbta4 = gather( mbta3[,-1], key = 'month', value = 'thou_riders' )

# Convert to numeric
mbta4$thou_riders = as.numeric( mbta4$thou_riders )

# 