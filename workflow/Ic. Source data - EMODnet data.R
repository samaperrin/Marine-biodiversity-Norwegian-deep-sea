#Ia. EMODnet data. 
setwd("//workingdirectory") #setting up the working directory.   

#This package enables the API for the EMODnet server. For more information, see the documentation of the package.
remotes::install_github("EMODnet/EMODnetWFS")
library("EMODnetWFS")
View(emodnet_wfs())
wfs_bio <- emodnet_init_wfs_client(service = "biology_occurrence_data") #Select the data corresponding to the biological occurrences.
info <- emodnet_get_wfs_info(wfs_bio) #Store the information in an object.

#Set the boundaries of the AOI.
xmin= -27
ymin= 56
xmax= 38
ymax= 85

#Select the information corresponding to the AOI.
layer <- emodnet_get_layers(
  service = "biology_occurrence_data",
  layers = c("eurobis-obisenv"), 
  BBOX = paste(xmin,ymin,xmax,ymax,sep=",") )
layer <- layer[["eurobis-obisenv"]]

#Formatting EMODnet data accordingly to GBIF and OBIS fields.
names(layer)
layer <- layer[,c(35,50,4,66,16,37,38,79,52,2,81,57,48,13,40,43,10,29,32,8)]
layer <- as.data.frame(layer)

names(layer)[1] <- "coordinateUncertaintyInMeters" #"coordinateuncertaintyinmeters" to "coordinateUncertaintyInMeters"
names(layer)[3] <- "dataset" #"datasetid" to "dataset" 
names(layer)[4] <- "dateIdentified" #"dayidentified" to "dateIdentified"
names(layer)[5] <- "day" #"daycollected" to "day"
#Calculating a (mean) value for the depth:
layer$depth <- (layer$minimumdepthinmeters + layer$maximumdepthinmeters)/2
names(layer)[6] <- "minimumDepthInMeters" #"minimumdepthinmeters" to "minimumDepthInMeters"
names(layer)[7] <- "maximumDepthInMeters" #"maximumdepthinmeters" to "maximumDepthInMeters"
#Calculating an individual interval for the depthrange, which may equal to depthAccuracy:
layer$depthrange <- as.numeric(layer$depthrange)
layer$depthrange <- (layer$depthrange)/ 2
names(layer)[8] <- "depthAccuracy" #"depthrange" to "depthAccuracy"


names(layer)[11] <- "individualCount" #"individualcount" to "individualCount"
names(layer)[12] <- "flags" #"occurrenceremarks" to "flags"
names(layer)[14] <- "month" #"monthcollected" to "month"
names(layer)[15] <- "scientificName" #"scientificname" to "scientificName"
names(layer)[16] <- "taxonRank" #"taxonrank" to "taxonRank"
names(layer)[17] <- "year" #"yearcollected" to "year"
names(layer)[18] <- "decimalLatitude" #"decimallongitude" to "decimalLatitude" (inverted)
names(layer)[19] <- "decimalLongitude" #"decimallatitude" to "decimalLongitude" (inverted)
names(layer)[20] <- "eventDate" #"datecollected" to "eventDate"
layer$database <- "emodnet"
layer$XCoord <- layer$decimalLongitude
layer$YCoord <- layer$decimalLatitude
emodc <- layer[-21]
View(emodc)

##End script Ic
