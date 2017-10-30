# GGPLOT2
library(ggplot2)

## First Example
ggplot(
  data = mtcars, 
  aes(
    x = cyl,
    y = mpg
    )
  ) +
  geom_point()
## First Example: Colored
ggplot(mtcars, aes(x = factor(cyl), y = mpg)) +
  geom_point()
## Size
p = ggplot(mtcars, aes(x = wt, y = mpg, size = disp, col = factor(gear), shape = factor(cyl) ) )
p + geom_point()
## Diamonds Data
ggplot(diamonds, aes(x = carat, y = price)) + geom_point()
## Fit Smooth Function
ggplot(diamonds, aes(x = carat, y = price)) + 
  geom_point() +
  geom_smooth()

## Fit for each Clarity
ggplot(diamonds, aes(x = carat, y = price, colour = clarity))
+ geom_smooth()

## Different Colors
ggplot(diamonds, aes(x = carat, y = price, colour = clarity)) + geom_point(alpha = 0.4) + geom_smooth()

## Same Plot, Another Way
dia_plot = ggplot( data = diamonds, aes( x = carat, y = price) )
dia_plot + geom_point( aes( col = clarity) )

## Smooth without Error
dia_plot +
  geom_smooth( aes( col = clarity ), se = FALSE )

## Linear Model
dia_plot +
  geom_point( ) +
  geom_smooth( se = FALSE, method = "lm" ) +
  ggtitle("hello")

## Format of the Data!

## Facet_Wrap
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  facet_wrap(~class, nrow = 4)

## Facet_Grid
p <- ggplot(mpg, aes(displ, cty)) + geom_point()
### Horizontal
p + facet_grid(. ~ cyl)
### Vertical
p + facet_grid(drv ~ .)
### 2D
p + facet_grid(drv ~ cyl)
### Add Reference
p +
  facet_grid(. ~ cyl) +
  geom_point( aes( x = 5, y = 25 ), colour = "red", size = 4 )
### Scale
p +
  facet_grid(. ~ cyl, scales = "free")
### Labels
p <- ggplot(mtcars, aes(wt, mpg)) + geom_point()
p +
  facet_grid(vs ~ cyl, labeller = label_both)
### Parsed Labels
mtcars$cyl2 <- factor(mtcars$cyl, labels = c("alpha", "beta", "sqrt(x, y)"))
ggplot(mtcars, aes(wt, mpg)) +
  geom_point() +
  facet_grid(. ~ cyl2, labeller = label_parsed)
### BQuote
p + facet_grid(. ~ vs, labeller = label_bquote(cols = alpha ^ .(vs)))


## Another Dataset
### Box Plot
ggplot(
  data=PlantGrowth,
  aes(x=group, y=weight, fill=group)
  ) + 
  geom_boxplot()
### Histogm
ggplot( data = PlantGrowth, aes(x = weight, fill = group) ) +
  geom_histogram( position="dodge" ) 
+ 
  facet_wrap(~group)
