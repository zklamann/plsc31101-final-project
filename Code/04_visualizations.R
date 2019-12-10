#load some packages
library(sp)
library(maps)
library(rmapshaper)
library(magick)
library(tmap)
library(animation)
library(rgdal)
library(raster)


#For task 1
#Need to read in the files
map1919 <- readOGR(dsn = "../Data/spatial_data/map1919/map1919.shp")
violent_events <- readOGR(dsn = "../Data/spatial_data/violent_events/violent_events.shp")

#Clean up map1919 a bit and check everything is working
map1919_no_borders <- ms_dissolve(map1919)
plot(map1919_no_borders)
plot(violent_events, add = T, col = "red", lwd = 10)

violent_events$vlnt___<- as.character(violent_events$vlnt___)

#Now we try to get the animation working
map1919_animation <- tm_shape(map1919_no_borders) +
  tm_fill("skyblue") +
  tm_layout(frame = F, 
            title = "Major Violent Events of the Weimar Republic",
            title.position = c("left", "top"),
            title.bg.color = "gray80",
            title.bg.alpha = .5,
            bg.color = "gray80",
            legend.outside = T,
            legend.outside.position = "bottom") +
  tm_shape(violent_events) + 
  tm_bubbles("ve_part",
             col = "blue", 
             scale = 3,
             alpha = .4, 
             border.col = "black",
             title.size = "Participants in violent events") +
  tm_facets(along = "ve_date", free.coords = FALSE, as.layers = T, scale.factor = 1)+
  tm_credits(violent_events$vlnt___, position = c("center", "top"), size = 1) +
  tm_layout(inner.margins = .15)


tmap_animation(map1919_animation, file = "../visualizations/map1919_animation.gif", delay = 250, restart.delay = 500, loop = T, width = 2000)



#This did not work initially so troubleshooting
library(animation)
Sys.setenv(PATH = paste("C:/Program Files/ImageMagick/bin",
                        Sys.getenv("PATH"), sep = ";"))
library(installr)
install.ImageMagick(URL = "http://www.imagemagick.org/script/binary-releases.php")
install.packages("magick")




#For task 2
#Read in the files
raster_berlin <- brick("../Data/spatial_data/berlin_geotiff.tiff")
ve_berlin <- readOGR(dsn = "../Data/spatial_data/violent_events_Berlin/violent_events_berlin.shp")

#Check everything is okay
plotRGB(raster_berlin)
plot(ve_berlin, add = T, lwd = 10)

#okay, but with a raster object, plotting it trickier. So we need to get it down to RBG.
nbands(raster_berlin)

#okay, there's four layers, which I'm assuming are R, G, B, and alpha, so suggestion from the internet is to drop the fourth
raster_berlin <- dropLayer(raster_berlin, 4)

#check if this worked
tm_shape(raster_berlin) + 
  tm_rgb()
#It did! Moving on.


#Set up this animation
Berlin_map <- tm_shape(raster_berlin) +
  tm_rgb() +
  tm_layout(frame = F, 
            title = "Spartacist Uprising",
            title.position = c("left", "top"),
            title.bg.color = "gray80",
            title.bg.alpha = .5,
            bg.color = "gray80",
            legend.outside = T,
            legend.outside.position = "bottom") +
  tm_shape(ve_berlin) + 
  tm_bubbles("ve_part",
             col = "blue", 
             scale = 5,
             alpha = .4, 
             border.col = "black",
             title.size = "Participants in violent events")

tmap_save(tm = Berlin_map, filename ="../visualizations/berlin_map.jpg", width = 20, units = "in")
