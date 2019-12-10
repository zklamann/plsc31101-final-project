#Second task, we need a map of Berlin and point data on the major violent events in Berlin in January 1919
library(sf)
library(tidyr)
library(dplyr)
library(foreign)
library(tidyverse)
library(sp)
library(raster)
library(rgdal)
library(stringr)
library(maptools)
library(lubridate)

#Need the map of Berlin. I made this in QGIS using the georeferencing tool. I found the original 1920 map
#from the internet then loaded in a map of the Berlin boroughs. From there it was finding the coordinates of key
#poinst in Berlin on the map, finding them online in longitude and latitude then transferring them to the correct
#CRS system. This then mapped the image onto the map of Berlin. I then layered the borough map over it with 30%
#opacity. It's not a perfect map, clearly, but it very close and very accurate in the center. I then exported
#this to a .tiff file to load in. 

raster_berlin <- stack("../Data/spatial_data/berlin_geotiff.tiff")

#let's plot it to take a look
plotRGB(raster_berlin)


#We now need a SPDF for the location of violent events during the January Uprising 
violent_events_berlin <- read.csv("../Data/spatial_data/Original datasets/violent_events_spart.csv")
coordinates(violent_events_berlin) <- c("POINT_Y", "POINT_X")
projection(violent_events_berlin) <- "+init=epsg:4326"


#We need to get these in the same CRS
crs(raster_berlin)
violent_events_berlin <- spTransform(violent_events_berlin, crs("+proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=3210000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"))


bbox(violent_events_berlin)
extent(raster_berlin)

#We should now be able to plot them simultaneously
plotRGB(raster_berlin)
plot(violent_events_berlin, add = T, lwd = 2)

#Need to clean up the data-types, as well
violent_events_berlin$ve_date <- mdy(violent_events_berlin$ve_date)

violent_events_berlin$ve_part <- as.numeric(violent_events_berlin$ve_part)

#Write these files
writeOGR(obj = violent_events_berlin, dsn = "../Data/spatial_data/violent_events_Berlin/violent_events_berlin.shp", layer = "ve_berlin", driver = "ESRI Shapefile")
#We haven't edited the map file, so no need to save it.
