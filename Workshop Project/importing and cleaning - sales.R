# Required Libraries
library(dplyr)
library(tidyr)
library(stringr)
library(lubridate)

# Import the Data
sales = read.csv('data/DataCamp/Importing and Cleaning Data in R - Case Studies/sales.csv', stringsAsFactors = FALSE)

# View dimension of sales
dim(sales)

# Inspect first 6 rows of sales
head(sales, n = 6)

# View Column names of sales
names(sales)

# Look at structure of sales
str( sales )

# View summary of sales
summary(sales)

# Get a glimpse of sales
glimpse(sales)

# Remove first column: sales2
sales2 = sales[,-1]

# Define a vector of column indices: keep
# Remove first 4 and last 15 columns
keep = 5 : (ncol(sales2)-15)

# Select desired columns: sales3
sales3 = sales2[,keep]

# Split event_date_time: sales4
sales4 = separate(sales3, event_date_time, sep = " ", into = c("event_dt", "event_time") )

# Split sales_ord_create_dttm: sales5
# Possible?
sales5 = separate(sales4, sales_ord_create_dttm, sep = " ", into = c("ord_create_dt", "ord_create_time") )

# Let's find the problem!
## Let's split by " "
#2 bad_indices = c()
for( i in 1:nrow(sales4) ){
  current_value = sales4$sales_ord_create_dttm[i]
  n_splits = length( strsplit(current_value, split = " ")[[1]] )
  if( n_splits != 2 ){
    #2 bad_indices = c( bad_indices, i )
    show( current_value )
  }
}
#2 bad_indices

# Now split for non-null
names(sales4)[14] = "event_dt.1"
sales5 = sales4[!( 1:nrow(sales4) %in% bad_indices ), ]
sales5 = separate(sales5, sales_ord_create_dttm, sep = " ", into = c("ord_create_dt", "ord_create_time") )

# Find columns of sales5 containing "dt": date_cols
date_cols = str_detect(names(sales5), pattern = "dt")

# Coerce date columns into Date Object
sales5[ ,date_cols ] = lapply( X = sales5[ ,date_cols ], FUN = ymd )

# Missing values logical vector
missing = lapply( sales5[ ,date_cols], is.na )

# Count missing values
num_missing = sapply( missing, sum )
num_missing

# Pase columns: sales6
sales6 = unite( sales5, "venue_city_state", c("venue_city","venue_state"), sep = ", ")