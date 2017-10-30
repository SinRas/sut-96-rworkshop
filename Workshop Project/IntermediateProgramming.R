# Intermediate `R`
## Equality
T == F
(-6*14) != (17-101)
"useR" == "user"
F == 0

## Inequalities
(1+2) > 3
"b" < "c"
T <= F

## Vector Operations
a = rnorm(10)
b = rnorm(10)
a > 0
a <= b

## Matrices
m = matrix( c(a,b), byrow = T, nrow = 2 )
m > 0
m[ m > 0 ]

## Logical
a = 1:10
(2 < a) & (a < 5)
(2 > a) | (a > 5)

## DataFrames
row_select = (mtcars$am == 0) & (mtcars$gear == 3)
mtcars[ row_select, ]

## if
if( max(rivers) > 10000 ){
  print("Wrong Values!")
} else if ( min(rivers) < 0 ) {
  print("Hello World!")
} else {
  print("What happened?")
}

## while
i = 1
while( rivers[i] < 1000 ){
  print(i)
  i = i + 1
  if( i > 5 ){
    break
  }
}

## for
for( i in 1:5 ){
  print(i)
}

for( i in c(5,2,3,1,4) ){
  print(i)
}

x = c(6,3,4,5,1)
for( i in 1:length(x) ){
  print(x[i])
}

## help
help("sample")
?sample
args(sample)
sample() # CTRL+SPACE

## mean
x = c(1,NA,2,3)
mean(x)
mean(x,na.rm = T)

## paste
paste("hello","world",sep = ";")
paste0("hello","world")

## write functions
my_fun = function(x,y){
  return( x & y )
}
x = c(T,T,F)
y = c(F,T,F)
my_fun(x,y)

## function: throw die
throw_die = function(){
  return( sample(1:6, size = 1) )
}
throw_die()

## function: throw dice
throw_dice = function(n = 1){
  return( sample(1:6, size = n, replace = T) )
}
throw_dice()
throw_dice(5)

## plot
plot(x = mtcars$mpg, y = mtcars$hp, pch=20, cex = 2)

## library
library(dplyr)
library(data.table)

## 
lapply