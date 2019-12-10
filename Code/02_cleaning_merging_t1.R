#For the first task, we need a map of Germany and a map of the major violent events
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
library(rmapshaper)
library(lubridate)

#For this map set, let's use a shapefile based on statistical units from the German Empire
#Statistical Office in 1919. We need the historical outline because borders have changed a lot.
map1919 <- readOGR(dsn = "../Data/spatial_data/mosaic_data_1931set/German_Empire_1919_Stat_v.1.0.shp")

#Now we need our violent events. I've created a .csv file in excel of the 16 largest events from the onset 
#of the revolution in November 1918 to the Beer Hall Putsch in 1923 in Munich, so now I'm going to load that up
violent_events <- read.csv("../Data/spatial_data/Original datasets/violent_events.csv")

#Let's take a look at the structure of this:
str(violent_events)

#Needs to be transformed to a SPDF so it can be plotted
coordinates(violent_events) <- c("POINT_X", "POINT_Y")

#Okay, so if we're going to merge these two datasets, we'll need to have the same projection so the coordinates are mutually intelligible.
proj4string(violent_events)
proj4string(map1919)

#So, our violent events dataframe doesn't have a CRS because I didn't assign it one, yet, but our other map
# is using the WSG84 projection; so let's give out violent events the same one
proj4string(violent_events) <-  CRS("+init=epsg:4326")
proj4string(violent_events)

#Still in the wrong zone of the UTM, though, so we need to transform to match
violent_events <- spTransform(violent_events, proj4string(map1919))

#let's check
proj4string(violent_events)
proj4string(map1919)

#let's check the ranges
bbox(violent_events)
bbox(map1919)

#so something has gone wrong. Let's troubleshoot here
violent_events <- read.csv("../Data/spatial_data/Original datasets/violent_events.csv")
proj4string(map1919)
coordinates(violent_events) <- c("POINT_Y", "POINT_X")
projection(violent_events) <- "+init=epsg:4326"

violent_events <- spTransform(violent_events, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")) 

map1919 <- spTransform(map1919, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))

bbox(violent_events)
bbox(map1919)

plot(map1919)
plot(violent_events, add = T, col = "red")
#SUCCESS! They now map onto the same space and look decently alright!

#Let's remove the internal borders for some clarity on the map itself.
map1919_no_borders <- ms_dissolve(map1919)

#Need to reclassify some of the violent_events SPDF to make the dates column dates and the ve_parts column as numeric
violent_events$ve_date <- mdy(violent_events$ve_date)

violent_events$ve_part <- as.character(violent_events$ve_part)
violent_events$ve_part <- as.numeric(violent_events$ve_part)

#Time to write these as .shp files
writeOGR(obj = violent_events, dsn = "../Data/spatial_data/violent_events/violent_events.shp", layer = "ve", driver = "ESRI Shapefile")
writeOGR(obj = map1919_no_borders, dsn = "../Data/spatial_data/map1919/map1919_no_borders.shp", layer = "map1919_no_borders", driver = "ESRI Shapefile")
writeOGR(obj = map1919, dsn = "../Data/spatial_data/map1919/map1919.shp", layer = "map1919", driver = "ESRI Shapefile")

