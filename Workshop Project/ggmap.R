## GGMAP
library(data.table)
library(dplyr)
library(ggplot2)
library(ggmap)
## Load the Data
dat = fread('data/Kaggle/New York City Taxi Trip Duration.csv')
## MAKEMAP
#' create map slices
make.map<-function(map, frame){
  mname <- names(map)
  stopifnot(frame[1]*frame[2]==length(mname))
  sq <- as.numeric(attr(map[[mname[1]]],"bb"))
  sq <- t(matrix(sq,2,2))
  sq <- data.frame(sq)
  colnames(sq)<-c("lon","lat")
  width = (sq[2,1]-sq[1,1])/frame[2]
  height = (sq[2,2]-sq[1,2])/frame[1]
  wsize = floor(ncol(map[[mname[1]]])/frame[2])
  hsize = floor(nrow(map[[mname[1]]])/frame[1])
  p <- ggplot(aes(x=lon,y=lat),data=sq) + geom_point(alpha=0)
  ii <- 0
  for (i in 1:frame[2]-1)
    for (j in 1:frame[1]-1){
      ii <- ii+1
      p <- p + annotation_raster(map[[mname[ii]]][(1+j*hsize):((j+1)*hsize),(1+i*wsize):((i+1)*wsize)],xmin=sq[1,1]+i*width,xmax=sq[1,1]+(i+1)*width,ymin=sq[1,2]+height*j,ymax=sq[1,2]+(j+1)*height)
      p <- p + annotate("text",x=sq[1,1]+(i+0.35)*width, y=sq[1,2]+(j+0.1)*height,label=mname[ii],col="red",size=6)
      #p <- p + geom_text(data = NULL,x=sq[1]+(i-0.7)*width, y=sq[2],label=mname[i])
    }
  p+xlab("Long.") + ylab("Lat.")
}
## 
map = list()
source = "google"
map$base <- get_map("New York City", source=source)
map$roadmap <- get_map("New York City",maptype='roadmap', source=source)
map$hybird <- get_map("New York City",maptype='hybrid', source=source)
map$satellite <- get_map("New York City",maptype='satellite', source=source)
map$terrain <- get_map("New York City",maptype='terrain', source=source)
##
make.map(map,c(1,5))
##
to_plot = sample_n( dat, size = 1000 )
qmap( location = "new york city" )
qmplot( data = to_plot, pickup_longitude, pickup_latitude, source = "google" )
##
to_map = get_map("New York City", source=source, zoom = 13)
ggmap(to_map) + 
  geom_point( data = to_plot, aes( x = pickup_longitude, y = pickup_latitude ), size = 1 )
## 
to_plot = sample_n( dat, size = 1000 )

range_lat = extendrange(to_plot$pickup_latitude)
range_lon = extendrange(to_plot$pickup_longitude)
zoom = calc_zoom(range_lon, range_lat)

zoom = calc_zoom(make_bbox( data = to_plot, lon = pickup_longitude, lat = pickup_latitude ))

to_map = get_map( location = c( lon = mean(range_lon), lat = mean(range_lat) ), zoom = zoom )

ggmap(to_map) + 
  geom_point( data = to_plot, aes( x = pickup_longitude, y = pickup_latitude ), size = 1 )

ggmap(to_map) +
  geom_point(data = to_plot, aes(pickup_longitude, pickup_latitude), size = 0.5 ) +
  geom_density_2d( data = to_plot, aes( pickup_longitude, pickup_latitude ) )

## Bounding Box
to_plot = sample_n( dat, size = 10 )
range_lat = extendrange(to_plot$pickup_latitude)
range_lon = extendrange(to_plot$pickup_longitude)

to_map = get_map( c(range_lon[1],range_lat[1],range_lon[2],range_lat[2]) )

ggmap(to_map) + 
  geom_point( data = to_plot, aes( x = pickup_longitude, y = pickup_latitude ), size = 0.3 ) +
  geom_segment( data = to_plot, aes( x = pickup_longitude, y = pickup_latitude, xend = dropoff_longitude, yend = dropoff_latitude ), arrow = arrow( length = unit(0.03, "npc") ) )
