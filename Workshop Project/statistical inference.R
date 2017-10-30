# Required Libraries
library(dplyr)
library(ggplot2)

# Load the Data
dat = read.csv('data/LifeScience/femaleMiceWeights.csv.txt')

##
dat %>% 
  filter( Diet == "chow" ) %>%
  select( Bodyweight ) %>% 
  unlist %>% 
  hist

# Control Population
controls = dat %>% filter(Diet == "chow") %>% select(Bodyweight) %>% unlist

# Treatment
treatment = dat %>% filter(Diet == "hf") %>% select(Bodyweight) %>% unlist

# Comparison
mean(treatment)
mean(controls)

# Difference
obs = mean(treatment) - mean(controls)

# Load the whole population
population = read.csv('data/LifeScience/femaleControlsPopulation.csv.txt')
population = population$Bodyweight

# Sample Sizes
n_treatment = length(treatment)
n_control = length(controls)

# Sample from Population
sample_treatment = sample( population, size = n_treatment )
sample_control = sample(population, size = n_control )
sample_diff = mean(sample_treatment) - mean(sample_control)
sample_diff

# Make Run it many Times
N = 10000
diffs = vector(mode = "numeric", N)
for(i in 1:N){
  sample_treatment = sample(population, size = n_treatment )
  sample_control = sample(population, size = n_control )
  diffs[i] = mean(sample_treatment) - mean(sample_control)
}

# Histogram
hist(diffs)

# How rare was 'obs'?
mean( abs(diffs) > abs(obs) )

# T-Test
t.test( treatment, controls )

# Permutation Test
all_mice = c(treatment,controls)
names(all_mice) = NULL
per_treatment = sample(all_mice, n_treatment)
per_control = all_mice[ !(all_mice %in% per_treatment) ]
per_diff = mean(per_treatment) - mean(per_control)

# Permutation Test - Hist
N = 10000
per_diffs = vector(mode = "numeric", N)
for(i in 1:N){
  per_treatment = sample(all_mice, n_treatment)
  per_control = all_mice[ !(all_mice %in% per_treatment) ]
  per_diffs[i] = mean(per_treatment) - mean(per_control)
}
hist(per_diffs)
mean( abs(per_diffs) > abs(obs) )

# Your Own Statistics!
my_statistic = function(x,y){
  abs_mean_diff = abs( mean(x) - mean(y) )
  lambda = var(x) / var(y)
  return( abs_mean_diff + lambda + (1/lambda) )
}
obs_stat = my_statistic( treatment, controls )
obs_stat

# Probability Density
N = 10000
per_my_stat = vector(mode = "numeric", N)
for(i in 1:N){
  per_treatment = sample(all_mice, n_treatment)
  per_control = all_mice[ !(all_mice %in% per_treatment) ]
  per_my_stat[i] = my_statistic( per_treatment, per_control )
}
hist(per_my_stat)
mean( per_my_stat > obs_stat )