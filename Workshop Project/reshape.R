# Reshape
## Libraries
library(dplyr)
library(reshape2)
library(tidyr)

## Gather
names(iris)
head(iris)

## Wide to Long
long = gather( iris, condition, measurement, Sepal.Length:Petal.Width )
gather( iris, key, value, c("Sepal.Length","Sepal.Width") )

## Long to Wide
head(long)
spread( long, condition, measurement )

## What To Do?
