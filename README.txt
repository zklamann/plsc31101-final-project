## Short Description

Give a short, 1-2 paragraph description of your project. Focus on the code, not the theoretical / substantive side of things. 

## Dependencies

1. R, 3.6.1
2. QGIS Desktop, 3.10.1

'tmap'
'raster'
'animate'
'sp'
'spatial'
'rmapshaper'
'lubridate'
'tidyverse'
'tidyr'
'magickr'
'rgdal'

## Files

#### /

1. Narrative.Rmd: Provides a 4-page summary of the challenges encountered when coding this along with one of the visualizations.
2. Narrative.pdf: A knitted pdf of Narrative.Rmd. 
3. pvw.pptx: Slideshow presenting the work

#### Code/
1. 01_collect.R: This is just loading the files to provide a look at the base files on which the remainder is based
2. 02_cleaning_merging_t1.R: cleaning and merging of data for the visualization of major violent events throughout Germany between 1918-1923
3. 03_cleaning_merging_t2.R: cleaning and merging of data for the visualization of major violent events in the Spartacist Uprising
3. 03_visualizatons.R: Creates the two maps from the cleaned data.

#### Data/

1. map1919.shp: Shapefile of Germany in 1919 from the Mosaic Project. Found here: https://censusmosaic.demog.berkeley.edu/data/historical-gis-files
2. violent_events.csv: self-coded datasets of major violent events in Weimar between the Kiel Mutiny and the Beer Hall Putsch; based on historical sources
3. violent_events_spart.csv: self-coded datasets of major violent events during the Spartacist Uprising in January 1919; based on historical sources
4. Orsteile_Berlin.shp: created by the German government for European datasharing initiatives. Found here: https://opendata-esri-de.opendata.arcgis.com/datasets/9f5d82911d4545c4be1da8cab89f21ae_0
5. Berlin.geotiff: created using QGIS based on the Orsteile_Berlin shapefile and a map found here: https://www.mapsland.com/europe/germany/berlin/large-scale-detailed-old-map-of-berlin-city-1920
6. nazi1930.shp: Shapefile connected to Nazi voteshare in the 1930 election by Kreise and some basic demographic data. Found in the supplemental files of this paper: https://www.cambridge.org/core/journals/political-analysis/article/electoral-geography-of-weimar-germany-exploratory-spatial-data-analyses-esda-of-protestant-support-for-the-nazi-party/27431B8A8984258212CE892A345235B4#fndtn-supplementary-materials
#### Results/
1. berlin_map.jpg: maps violent events from the Spartacist Uprising onto mapfile created
2. map1919_animation.gif: animated map of major violent events in Weimar Germany
## More Information

