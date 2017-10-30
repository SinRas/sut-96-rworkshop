# HIGHCHARTER
## Load DataSets
data(diamonds, economics_long, mpg, package = "ggplot2")
## Load Libraries
library(dplyr)
library(highcharter)
## Scatter
hchart(mpg, "scatter", hcaes(x = displ, y = hwy, group = class))
## Bar
mpgman2 <- mpg %>% 
  count(class, year) %>% 
  glimpse()

hchart( mpgman2, "column", aes(x = year, y = n, group = class) )
## TreeMap
mpgman3 <- mpg %>% 
  group_by(manufacturer) %>% 
  summarise(n = n(), unique = length(unique(model))) %>% 
  arrange(-n, -unique) %>% 
  glimpse()
hchart(mpgman3, "treemap", hcaes(x = manufacturer, value = n, color = unique))
## Line
economics_long2 <- economics_long %>% 
  filter(variable %in% c("pop", "uempmed", "unemploy")) %>% 
  print()
hchart(economics_long2, "line", hcaes(x = date, y = value01, group = variable))
## Histogram
hchart(diamonds$price) 
## Density Plot
hchart(density(diamonds$price), type = "area", color = "#B71C1C", name = "Price")
## Bar
hchart(diamonds$cut, type = "column")
## Time Series Decomposition
x <- stl(log(AirPassengers), "per")
hchart(x)
## ForeCast
library("forecast")
x <- forecast(ets(USAccDeaths), h = 48, level = 95)
hchart(x)
## IGRAPH
library("igraph")
N <- 40

net <- sample_gnp(N, p = 2/N)
wc <- cluster_walktrap(net)

V(net)$label <- seq(N)
V(net)$name <- paste("I'm #", seq(N))
V(net)$page_rank <- round(page.rank(net)$vector, 2)
V(net)$betweenness <- round(betweenness(net), 2)
V(net)$degree <- degree(net)
V(net)$size <- V(net)$degree
V(net)$comm <- membership(wc)
V(net)$color <- colorize(membership(wc))

hchart(net, layout = layout_with_fr)
## `xts`
library(quantmod)
x <- getSymbols("USD/JPY", src = "oanda", auto.assign = FALSE)
hchart(x)

## `AutoCorrelation`
x <- acf(diff(AirPassengers), plot = FALSE)
hchart(x)

## Principal Components
hchart(princomp(USArrests, cor = TRUE))

## Matrix
data(volcano)
hchart(volcano) %>% 
  # changing default color
  hc_colorAxis(stops = color_stops(colors = viridis::inferno(10)))

## Distance Matrix
mtcars2 <- mtcars[1:20, ]
x <- dist(mtcars2)
hchart(x)


## Correlation Matrix
hchart(cor(mtcars))

## Full Example
data("favorite_bars")
data("favorite_pies")

highchart() %>% 
  # Data
  hc_add_series(favorite_pies, "column", hcaes(x = pie, y = percent), name = "Pie") %>%
  hc_add_series(favorite_bars, "pie", hcaes(name = bar, y = percent), name = "Bars") %>%
  # Optiosn for each type of series
  hc_plotOptions(
    series = list(
      showInLegend = TRUE,
      pointFormat = "{point.y}%"
    ),
    column = list(
      colorByPoint = TRUE
    ),
    pie = list(
      colorByPoint = TRUE, center = c('30%', '10%'),
      size = 120, dataLabels = list(enabled = FALSE)
    )) %>%
  # Axis
  hc_yAxis(
    title = list(text = "percentage of tastiness"),
    labels = list(format = "{value}%"), max = 100
  ) %>% 
  hc_xAxis(categories = favorite_pies$pie) %>%
  # Titles and credits
  hc_title(
    text = "This is a bar graph describing my favorite pies
    including a pie chart describing my favorite bars"
  ) %>%
  hc_subtitle(text = "In percentage of tastiness and awesomeness") %>% 
  hc_credits(
    enabled = TRUE, text = "Source: HIMYM",
    href = "https://www.youtube.com/watch?v=f_J8QU1m0Ng",
    style = list(fontSize = "12px")
  )
## 
highchart() %>% 
  hc_add_series( data = mpg, "scatter", hcaes(x = mpg$cyl, y = mpg$displ), name = "Sc" ) %>% 
  hc_add_series( data = mpg, "column", hcaes(x = mpg$displ, y = mpg$hwy), name = "MP" )

## Extend
library(dplyr)
library(stringr)
library(purrr)

n <- 5

set.seed(123)

colors <- c("#d35400", "#2980b9", "#2ecc71", "#f1c40f", "#2c3e50", "#7f8c8d")
colors2 <- c("#000004", "#3B0F70", "#8C2981", "#DE4968", "#FE9F6D", "#FCFDBF")


df <- data.frame(x = seq_len(n) - 1) %>% 
  mutate(
    y = 10 + x + 10 * sin(x),
    y = round(y, 1),
    z = (x*y) - median(x*y),
    e = 10 * abs(rnorm(length(x))) + 2,
    e = round(e, 1),
    low = y - e,
    high = y + e,
    value = y,
    name = sample(fruit[str_length(fruit) <= 5], size = n),
    color = rep(colors, length.out = n),
    segmentColor = rep(colors2, length.out = n)
  )

create_hc <- function(t) {
  
  dont_rm_high_and_low <- c("arearange", "areasplinerange",
                            "columnrange", "errorbar")
  
  is_polar <- str_detect(t, "polar")
  
  t <- str_replace(t, "polar", "")
  
  if(!t %in% dont_rm_high_and_low) df <- df %>% select(-e, -low, -high)
  
  
  highchart() %>%
    hc_title(text = paste(ifelse(is_polar, "polar ", ""), t),
             style = list(fontSize = "15px")) %>% 
    hc_chart(type = t,
             polar = is_polar) %>% 
    hc_xAxis(categories = df$name) %>% 
    hc_add_series(df, name = "Fruit Consumption", showInLegend = FALSE) 
  
}

hcs <- c("line", "spline",  "area", "areaspline",
         "column", "bar", "waterfall" , "funnel", "pyramid",
         "pie" , "treemap", "scatter", "bubble",
         "arearange", "areasplinerange", "columnrange", "errorbar",
         "polygon", "polarline", "polarcolumn", "polarcolumnrange",
         "coloredarea", "coloredline")
## Stocks
x <- getSymbols("GOOG", auto.assign = FALSE)
y <- getSymbols("AMZN", auto.assign = FALSE)

highchart(type = "stock") %>% 
  hc_add_series(x) %>% 
  hc_add_series(y, type = "ohlc")

## HighMap
cities <- data_frame(
  name = c("London", "Birmingham", "Glasgow", "Liverpool"),
  lat = c(51.507222, 52.483056,  55.858, 53.4),
  lon = c(-0.1275, -1.893611, -4.259, -3),
  z = c(1, 2, 3, 2)
)

hcmap("countries/gb/gb-all", showInLegend = FALSE) %>% 
  hc_add_series(data = cities, type = "mapbubble", name = "Cities", maxSize = '10%') %>% 
  hc_mapNavigation(enabled = TRUE)

## 