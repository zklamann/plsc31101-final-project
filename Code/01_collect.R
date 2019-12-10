library(rgdal)
library(sp)
library(spatial)
library(raster)


#Some of the spatial data
spatial_data <- st_read("../Data/spatial_data/nazi1930.shp") 
map1919 <- readOGR(dsn = "../Data/spatial_data/mosaic_data_1931set/German_Empire_1919_Stat_v.1.0.shp")
map_berlin <- stack("../Data/spatial_data/berlin_geotiff.tiff")


#The violente events data based on historical sources describing the various events
violent_events <- read.csv("../Data/spatial_data/violent_events.csv")
violent_events_berlin <- read.csv("../Data/spatial_data/violent_events_spart.csv")
