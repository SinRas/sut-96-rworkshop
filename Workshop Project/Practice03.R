# Libraries
library(data.table)
library(dplyr)
library(ggplot2)
library(tidyr)
library(readxl)
##
dat = read_excel("survey_faked.xlsx")

str(dat)

factor( dat$`Study Status` )

unique( dat$`Study Status` )

factor( x = dat$`Study Status`, levels = c("B.Sc.", "M.Sc.", "Ph.D.") )

## 
dat2 = dat
dat2$Year = 94
dat2$`Study Status` = factor( x = dat$`Study Status`, levels = c("B.Sc.", "M.Sc.", "Ph.D.") )
##
if(2 < 3){
  print("salam")
}
##
for( i in 1:5 ){
  if( i%%2 == 0 ){
    print(i)
  }
}
##
for( i in 7:16 ){
  dat[,i] = factor( unlist( dat[,i] ), levels = c("D","C","B","A"), ordered = T )
}
##
ostad = dat$Lecturer[1]

processed = dat %>% 
  filter( Lecturer == ostad ) %>% 
  select( `Question 1` ) %>% 
  unlist

tmp = table( processed )
barplot( height = tmp )
title(ostad)

dat %>%
  group_by( Lecturer ) %>% 
  summarise( N_A = sum( `Question 1` == "A" ) )

dat %>%
  group_by( Lecturer ) %>% 
  summarise( Q1_N_A = sum( `Question 1` == "A" ), Q1_N_B = sum( `Question 1` == "B" ), Q1_N_C = sum( `Question 1` == "C" ), Q1_N_D = sum( `Question 1` == "D" ) ) %>% 
  mutate( Q1_Score = 5*Q1_N_A + 3*Q1_N_B + Q1_N_C - Q1_N_D ) %>% 
  select( -(Q1_N_A:Q1_N_D) ) %>% 
  arrange( -Q1_Score )

dat %>% 
  class

mice = read.csv('../LifeScience/femaleMiceWeights.csv.txt')







