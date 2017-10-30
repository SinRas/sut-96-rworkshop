# Linear Regression
## Libraries
library(ISLR)
library(MASS)
?Boston
names(Boston)
str(Boston)

## Linear Model
fit1 = lm( data = Boston, medv ~ lstat )
summary(fit1)
plot( Boston$lstat, Boston$medv )
points( Boston$lstat, fitted(fit1), col="red", pch=20 )

## Nonlinear Model
### Interaction
fit2 = lm( data = Boston, medv ~ lstat*age )
# plot( Boston$lstat, Boston$medv )
points( Boston$lstat, fitted(fit2), col="blue", pch=20 )
### Quadratic
fit3 = lm( data = Boston, medv ~ lstat + I(lstat^2) )
# plot( Boston$lstat, Boston$medv )
points( Boston$lstat, fitted(fit3), col="green", pch=20 )
### Polynomial
fit4 = lm( data = Boston, medv ~ poly(lstat,4) )
# plot( Boston$lstat, Boston$medv )
points( Boston$lstat, fitted(fit4), col="purple", pch=20 )
legend("topright",
       legend=c("Data","Linear","Interaction","Quadratic","Polynomial"),
       col=c("black","red","blue","green","purple")
       )
