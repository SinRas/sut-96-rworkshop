# Programming in `R`
## Sum
3 + 4

## Subtract
2 - 5

## Multiply
1.2 * 6.8

## Divide
(123 + 321) / 2

## Exponentiation
3^5

## Modulo
37%%9

## Assign Variable
x <- 42
z <- "salam"
y = 32

## Print
x
y

## Arithmatic with Variables
x + y
x - y
x * y
x^y
x / y
x %% y

## Arithmatic and Assignment
z = x + y
z

## Variable Types
### Numerics
x = 1.2
x = 3
### Logical
y = FALSE # `F` or `FALSE`
y = T # `T` or `TRUE`
### Character
z = "salam"

## Determine Class
class(x)
class(y)
class(z)

## Vectors
x = c(1, 2, 3)
y = c("a","b","c")
z = c(T,F,F)

## Vectors: What if Mixed?
x = c(3,T)
x = c(4,"a")
x = c(5, F, "b")

## Attributes: name
x_sleep = c(6.5, 7.5, 7, 8, 6)
x_names = c("Saturday", "Sunday", "Monday", "Tuesday", "Wednesday")
names(x_sleep) = x_names
x_sleep["Monday"]

## Vector Summation
x = c(1,2,3)
y = c(4,5,6)
x+y

## Vector Simple Functions
x = c(1.2,3.4,5.6)
sum(x)
mean(x)
median(x)
sd(x)

## Vector: Indexing
x_sleep = c(6.5, 7.5, 7, 8, 6)
x_names = c("Saturday", "Sunday", "Monday", "Tuesday", "Wednesday")
x_sleep[2]
names(x_sleep) = x_names
x_sleep["Tuesday"]

## Vector Slicing
x_sleep[2:4]
x_sleep["Sunday":"Tuesday"]
y = c(4,3,1)
x_sleep[y]
x_sleep[c("Sunday","Tuesday")]

## Vector Selection
x = sleep$extra
x_selection = x > 1.1
y = x[ x_selection ]

## Matrices
matrix( data = 1:10, byrow = T, nrow = 5 )

## Matrics: from Vectors
x = c( 460.998, 314.4 )
y = c( 290.475, 247.9 )
z = c( 309.306, 165.8 )
w = c( x, y, z )
m = matrix( data = w, byrow = T, nrow = 3 )

## Matrics: Attributes
m
colnames(m) = c("A","B")
rownames(m) = c("gozashte", "haal","aayande")

## Matrices: Slicing
m[2,]
m["haal",]
m["gozashte",1]
m[c("aayande","gozashte"),"A"]

## Matrices: simple Functions
rowSums(m)
colSums(m)
colMeans(m)
rowMeans(m)


## Matrices: rbind, cbind
cbind( m, rowSums(m) )
rbind( m, colSums(m) )

## Matrices: scalar arithmatics
m + 1000
m - 1000
m * 2
m / 5
m %% 3

## Matrices: multiply by vector
m * c(10,100,1000)
m * c(1, 0)

## Matrices: Matrix Multiplications
m %*% c(1,0)
c(1,0,0) %*% m
t(m) %*% m
m %*% t(m)

## Factors
x = c("m","f","f","m","m")
factor(x)

## Factors: Ordered
x = c("a","a","c","b","c","a")
y = factor( x, ordered = T, levels = c("c","b","a") )

## Factors: Levels
levels(y) = c("A","B","C")
y

## Factors: summary
summary(x)
summary(y)

## Factors: comparison
y[3] > y[1]

## DataFrames: example
class(mtcars)
typeof(mtcars)
help("mtcars")

## DataFrames: head
head(mtcars)

## DataFrames: str
str(mtcars)

## DataFrames: summary
summary(mtcars)

## DataFrames: constructor
names = c("Yashar","Sina","Hoda","Maryam")
ages = c(22,24,22,21)
row_ids = c(1,1,2,2)
class_df = data.frame(names, ages, row_ids)
class_df

## DataFrames: slicing
class_df[1,1]
class_df[2,]
class_df[,3]
class_df[1:2,2:3]
class_df[,1]
class_df$names
class_df[,"row_ids"]

## DataFrames: subset
subset( class_df, subset = ( ages < 23 ) )

## DataFrames: order
a = c(3,1,4,5,2)
order(a)
a[ order(a) ]

class_df[order(class_df$ages), ]

## Lists: construction
a = 1:10
b = matrix(1:10, byrow = T, nrow = 5)
c = mtcars[1:10,]
my_list = list( a,b,c )
my_list

## Lists: names
my_list = list( W = a, U = b, V = c )
my_list

names(my_list) = c("A","B","C")
my_list

## Lists: slicing
my_list$A
my_list[[3]]