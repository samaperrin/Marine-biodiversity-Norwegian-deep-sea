#V. Spatial analysis  
setwd("//workingdirectory") #setting up the working directory. 


#Producing logarithmic curves for the spatial analysis
#Exporting shapefiles to ArcGIS, to analyse with the Spatial analysis tool
namesShallowDeepshp <- c(namesShallow,namesDeep) 

rm(i,x,y)
for (i in 1:length(namesShallowDeepshp)){
  
  y <- st_as_sf(x = get(namesShallowDeepshp[i]) %>% filter(!is.na(XCoord) | !is.na(YCoord)),                         
                coords = c("XCoord", "YCoord"),
                crs = 4326)
  y <- dplyr::select(y, "day", "decimalLatitude", "decimalLongitude", "depth", "id", 
                     "month", "scientificName", "year")
  
  st_write(y, gsub(" ","", paste(namesShallowDeepshp[i],".shp")), append=FALSE)
}

#if exporting only shallow in one:
rm(i,x,y)
for (i in 1:length(namesShallow)){
  
  y <- st_as_sf(x = get(namesShallow[i]) %>% filter(!is.na(XCoord) | !is.na(YCoord)),                         
                coords = c("XCoord", "YCoord"),
                crs = 4326)
  y <- dplyr::select(y, "day", "decimalLatitude", "decimalLongitude", "depth", "id", 
                     "month", "scientificName", "year")
  if(i == 1){setshp <- y}
  if(i > 1){setshp <- rbind(setshp,y)}
  
  if(i == length(namesShallow)){
    st_write(setshp, "shallow_spatial.shp", append=FALSE)}
}

#if exporting only deep in one:
rm(i,x,y)
for (i in 1:length(namesDeep)){
  
  y <- st_as_sf(x = get(namesDeep[i]) %>% filter(!is.na(XCoord) | !is.na(YCoord)),                         
                coords = c("XCoord", "YCoord"),
                crs = 4326)
  y <- dplyr::select(y, "day", "decimalLatitude", "decimalLongitude", "depth", "id", 
                     "month", "scientificName", "year")
  if(i == 1){setshp <- y}
  if(i > 1){setshp <- rbind(setshp,y)}
  
  if(i == length(namesDeep)){
    st_write(setshp, "deep_spatial.shp", append=FALSE)}
}

#if exporting all in one:      
rm(i,x,y)
y <- st_as_sf(x = timeSeriesJoint %>% filter(!is.na(XCoord) | !is.na(YCoord)),                         
              coords = c("XCoord", "YCoord"),
              crs = 4326)
y <- dplyr::select(y, "day", "decimalLatitude", "decimalLongitude", "depth", "id", 
                   "month", "scientificName", "year")

st_write(y, "all_spatial.shp", append=FALSE)

#exporting planktonic and benthic subdatasets
namesShallowDeepPBshp <- c(namesShallowPL, namesShallowBE, namesDeepPL, namesDeepBE)

rm(i,x,y)
for (i in 1:length(namesShallowDeepPBshp)){
  
  y <- st_as_sf(x = get(namesShallowDeepPBshp[i]),                         
                coords = c("XCoord", "YCoord"),
                crs = 4326)
  
  y <- dplyr::select(y, "day", "decimalLatitude", "decimalLongitude", "depth", "id", 
                     "month", "scientificName", "year")
  
  st_write(y, gsub(" ","", paste(namesShallowDeepPBshp[i],".shp")), append=FALSE)
}

#if exporting only shallow planktonic in one:
rm(i,x,y)
for (i in 1:length(namesShallowPL)){
  
  y <- st_as_sf(x = get(namesShallowPL[i]) %>% filter(!is.na(XCoord) | !is.na(YCoord)),                         
                coords = c("XCoord", "YCoord"),
                crs = 4326)
  y <- dplyr::select(y, "day", "decimalLatitude", "decimalLongitude", "depth", "id", 
                     "month", "scientificName", "year")
  if(i == 1){setshp <- y}
  if(i > 1){setshp <- rbind(setshp,y)}
  
  if(i == length(namesShallowPL)){
    st_write(setshp, "shallowPL_spatial.shp", append=FALSE)}
}

#if exporting only shallow benthic in one:
rm(i,x,y)
for (i in 1:length(namesShallowBE)){
  
  y <- st_as_sf(x = get(namesShallowBE[i]) %>% filter(!is.na(XCoord) | !is.na(YCoord)),                         
                coords = c("XCoord", "YCoord"),
                crs = 4326)
  y <- dplyr::select(y, "day", "decimalLatitude", "decimalLongitude", "depth", "id", 
                     "month", "scientificName", "year")
  if(i == 1){setshp <- y}
  if(i > 1){setshp <- rbind(setshp,y)}
  
  if(i == length(namesShallowBE)){
    st_write(setshp, "shallowBE_spatial.shp", append=FALSE)}
}

#if exporting only deep planktonic in one:
rm(i,x,y)
for (i in 1:length(namesDeepPL)){
  
  y <- st_as_sf(x = get(namesDeepPL[i]) %>% filter(!is.na(XCoord) | !is.na(YCoord)),                         
                coords = c("XCoord", "YCoord"),
                crs = 4326)
  y <- dplyr::select(y, "day", "decimalLatitude", "decimalLongitude", "depth", "id", 
                     "month", "scientificName", "year")
  if(i == 1){setshp <- y}
  if(i > 1){setshp <- rbind(setshp,y)}
  
  if(i == length(namesDeepPL)){
    st_write(setshp, "deepPL_spatial.shp", append=FALSE)}
}

#if exporting only deep benthic in one: 
rm(i,x,y)
for (i in 1:length(namesDeepBE)){
  
  y <- st_as_sf(x = get(namesDeepBE[i]) %>% filter(!is.na(XCoord) | !is.na(YCoord)),                         
                coords = c("XCoord", "YCoord"),
                crs = 4326)
  y <- dplyr::select(y, "day", "decimalLatitude", "decimalLongitude", "depth", "id", 
                     "month", "scientificName", "year")
  if(i == 1){setshp <- y}
  if(i > 1){setshp <- rbind(setshp,y)}
  
  if(i == length(namesDeepBE)){
    st_write(setshp, "deepBE_spatial.shp", append=FALSE)}
}

####################################### 
###Processing in ArcGIS and           
#Import datatables from ArcGIS 

#Per decade
#shallow and deep datasets

library(readr)
planktonBenthos_1876_1900_sjs <- read_delim("planktonBenthos_1876_1900_sjs.csv", 
                                            delim = ";", escape_double = FALSE, trim_ws = TRUE)

planktonBenthos_1876_1900_sjd <- read_delim("planktonBenthos_1876_1900_sjd.csv", 
                                            delim = ";", escape_double = FALSE, trim_ws = TRUE)

planktonBenthos_1900_1910_sjs <- read_delim("planktonBenthos_1900_1910_sjs.csv", 
                                            delim = ";", escape_double = FALSE, trim_ws = TRUE)

planktonBenthos_1900_1910_sjd <- read_delim("planktonBenthos_1900_1910_sjd.csv", 
                                            delim = ";", escape_double = FALSE, trim_ws = TRUE)

planktonBenthos_1910_1920_sjs <- read_delim("planktonBenthos_1910_1920_sjs.csv", 
                                            delim = ";", escape_double = FALSE, trim_ws = TRUE)

planktonBenthos_1910_1920_sjd <- read_delim("planktonBenthos_1910_1920_sjd.csv", 
                                            delim = ";", escape_double = FALSE, trim_ws = TRUE)

planktonBenthos_1920_1930_sjs <- read_delim("planktonBenthos_1920_1930_sjs.csv", 
                                            delim = ";", escape_double = FALSE, trim_ws = TRUE)

planktonBenthos_1920_1930_sjd <- read_delim("planktonBenthos_1920_1930_sjd.csv", 
                                            delim = ";", escape_double = FALSE, trim_ws = TRUE)

planktonBenthos_1930_1940_sjs <- read_delim("planktonBenthos_1930_1940_sjs.csv", 
                                            delim = ";", escape_double = FALSE, trim_ws = TRUE)

planktonBenthos_1930_1940_sjd <- read_delim("planktonBenthos_1930_1940_sjd.csv", 
                                            delim = ";", escape_double = FALSE, trim_ws = TRUE)

planktonBenthos_1940_1950_sjs <- read_delim("planktonBenthos_1940_1950_sjs.csv", 
                                            delim = ";", escape_double = FALSE, trim_ws = TRUE)

planktonBenthos_1940_1950_sjd <- read_delim("planktonBenthos_1940_1950_sjd.csv", 
                                            delim = ";", escape_double = FALSE, trim_ws = TRUE)

planktonBenthos_1950_1960_sjs <- read_delim("planktonBenthos_1950_1960_sjs.csv", 
                                            delim = ";", escape_double = FALSE, trim_ws = TRUE)

planktonBenthos_1950_1960_sjd <- read_delim("planktonBenthos_1950_1960_sjd.csv", 
                                            delim = ";", escape_double = FALSE, trim_ws = TRUE)

planktonBenthos_1960_1970_sjs <- read_delim("planktonBenthos_1960_1970_sjs.csv", 
                                            delim = ";", escape_double = FALSE, trim_ws = TRUE)

planktonBenthos_1960_1970_sjd <- read_delim("planktonBenthos_1960_1970_sjd.csv", 
                                            delim = ";", escape_double = FALSE, trim_ws = TRUE)

planktonBenthos_1970_1980_sjs <- read_delim("planktonBenthos_1970_1980_sjs.csv", 
                                            delim = ";", escape_double = FALSE, trim_ws = TRUE)

planktonBenthos_1970_1980_sjd <- read_delim("planktonBenthos_1970_1980_sjd.csv", 
                                            delim = ";", escape_double = FALSE, trim_ws = TRUE)

planktonBenthos_1980_1990_sjs <- read_delim("planktonBenthos_1980_1990_sjs.csv", 
                                            delim = ";", escape_double = FALSE, trim_ws = TRUE)

planktonBenthos_1980_1990_sjd <- read_delim("planktonBenthos_1980_1990_sjd.csv", 
                                            delim = ";", escape_double = FALSE, trim_ws = TRUE)

planktonBenthos_1990_2000_sjs <- read_delim("planktonBenthos_1990_2000_sjs.csv", 
                                            delim = ";", escape_double = FALSE, trim_ws = TRUE)

planktonBenthos_1990_2000_sjd <- read_delim("planktonBenthos_1990_2000_sjd.csv", 
                                            delim = ";", escape_double = FALSE, trim_ws = TRUE)

planktonBenthos_2000_2010_sjs <- read_delim("planktonBenthos_2000_2010_sjs.csv", 
                                            delim = ";", escape_double = FALSE, trim_ws = TRUE)

planktonBenthos_2000_2010_sjd <- read_delim("planktonBenthos_2000_2010_sjd.csv", 
                                            delim = ";", escape_double = FALSE, trim_ws = TRUE)

planktonBenthos_2010_2020_sjs <- read_delim("planktonBenthos_2010_2020_sjs.csv", 
                                            delim = ";", escape_double = FALSE, trim_ws = TRUE)

planktonBenthos_2010_2020_sjd <- read_delim("planktonBenthos_2010_2020_sjd.csv", 
                                            delim = ";", escape_double = FALSE, trim_ws = TRUE)

planktonBenthos_2020_2024_sjs <- read_delim("planktonBenthos_2020_2024_sjs.csv", 
                                            delim = ";", escape_double = FALSE, trim_ws = TRUE)

planktonBenthos_2020_2024_sjd <- read_delim("planktonBenthos_2020_2024_sjd.csv", 
                                            delim = ";", escape_double = FALSE, trim_ws = TRUE)


################  
#After importing from ArcGIS
#Plot logarithmic curves    

namesLogShallow <- gsub("_nodups_shallow", "_sjs", namesShallow)
namesLogDeep <- gsub("_nodups_deep", "_sjd", namesDeep)
namesLog <- c(namesLogShallow, namesLogDeep)
namesLog
labels <- gsub("planktonBenthos_", "", namesLog)
labels

rm(i,x,a) 
for(i in 1:length(namesLog)){
  
  x <- get(namesLog[i])
  x <- x$Join_Count
  
  log <- rle(sort(x))
  print(rle(sort(x)))
  logLengths <- log[["lengths"]]
  logValues <- log[["values"]]
  
  df <- as.data.frame(cbind(logLengths,logValues))
  subset <- df %>% filter(logValues == 1)
  if(i == 1){sumSone <- subset$logLengths}
  if(i > 1 & i < 15){accum <- subset$logLengths
  sumSone <- sumSone + accum }
  if(i == 15){sumDone <- subset$logLengths}
  if(i > 15 & i < 29){accum <- subset$logLengths
  sumDone <- sumDone + accum }
  
  if(i == 14){print(sumSone)}
  if(i == 28){print(sumDone)}
  
  df <- df %>% filter(logValues > 0)
  df
  for(a in 1:nrow(df)){
    if(df$logValues[a] > 0 & df$logValues[a] < 10){
      df$interval[a] = "A"
    }
    if(df$logValues[a] >= 10 & df$logValues[a] < 100){
      df$interval[a] = "B"
    }
    if(df$logValues[a] >= 100 & df$logValues[a] < 1000){
      df$interval[a] = "C"
    }
    if(df$logValues[a] >= 1000 & df$logValues[a] < 10000){
      df$interval[a] = "D"
    }
    if(df$logValues[a] >= 10000 & df$logValues[a] <= 100000){
      df$interval[a] = "E"
    }
    if(df$logValues[a] >= 100000 & df$logValues[a] <= 1000000){
      df$interval[a] = "F"
    }
    
  }
  
  df <- df %>% arrange(interval) %>% group_by(interval) %>% summarise(logCounts = sum(logLengths))
  df$indexTable <- labels[i]
  df
  
  if(i == 1){
    table <- df
  }
  
  if(i > 1){
    table <- rbind(table,df)
  }
  
  logstable <- as.data.frame(table)
}

View(logstable)
rows <- unique(logstable$interval)
logsShallow <- logstable[1:58,]
logsDeep <- logstable[59:99,]

unique(logsShallow$indexTable)
unique(logsDeep$indexTable)

blues <- colorRampPalette(c("lightblue","#000063"))
palleteBlue <- blues(length(unique(logsShallow$indexTable)))

reds <- colorRampPalette(c("lightcoral","darkred"))
palleteRed <- reds(length(unique(logsDeep$indexTable)))

plotE <- ggplot(logsShallow) + geom_point(aes(interval, logCounts, group = indexTable, color = indexTable)) + 
  geom_path(aes(interval, logCounts, group = indexTable, color = indexTable)) +
  scale_color_manual(values = palleteBlue) + theme(legend.position="none") +
  theme(axis.title.x=element_blank()) + theme(axis.title.y=element_blank()) + 
  theme(axis.text.x=element_text(size = 12)) + theme(axis.text.y=element_text(size = 12))
plotE

plotF <- ggplot(logsDeep) + geom_point(aes(interval, logCounts, group = indexTable, color = indexTable)) +
  geom_path(aes(interval, logCounts, group = indexTable, color = indexTable)) +
  scale_color_manual(values = palleteRed) + theme(legend.position="none") +
  theme(axis.title.x=element_blank()) + theme(axis.title.y=element_blank()) +
  theme(axis.text.x=element_text(size = 12)) + theme(axis.text.y=element_text(size = 12))
plotF

#Per decade
#Importing from ArcGIS (deep planktonic and benthic subdatasets)         

library(readr)
deep_1876_1900_sjdp <- read_delim("deep_1876_1900_plankton_sjdp.csv", 
                                  delim = ";", escape_double = FALSE, trim_ws = TRUE)

deep_1876_1900_sjdb <- read_delim("deep_1876_1900_benthos_sjdb.csv", 
                                  delim = ";", escape_double = FALSE, trim_ws = TRUE)

deep_1900_1910_sjdp <- read_delim("deep_1900_1910_plankton_sjdp.csv", 
                                  delim = ";", escape_double = FALSE, trim_ws = TRUE)

deep_1900_1910_sjdb <- read_delim("deep_1900_1910_benthos_sjdb.csv", 
                                  delim = ";", escape_double = FALSE, trim_ws = TRUE)

deep_1910_1920_sjdp <- read_delim("deep_1910_1920_plankton_sjdp.csv", 
                                  delim = ";", escape_double = FALSE, trim_ws = TRUE)

deep_1910_1920_sjdb <- read_delim("deep_1910_1920_benthos_sjdb.csv", 
                                  delim = ";", escape_double = FALSE, trim_ws = TRUE)

deep_1920_1930_sjdp <- read_delim("deep_1920_1930_plankton_sjdp.csv", 
                                  delim = ";", escape_double = FALSE, trim_ws = TRUE)

deep_1920_1930_sjdb <- read_delim("deep_1920_1930_benthos_sjdb.csv", 
                                  delim = ";", escape_double = FALSE, trim_ws = TRUE)

deep_1930_1940_sjdp <- read_delim("deep_1930_1940_plankton_sjdp.csv", 
                                  delim = ";", escape_double = FALSE, trim_ws = TRUE)

deep_1930_1940_sjdb <- read_delim("deep_1930_1940_benthos_sjdb.csv", 
                                  delim = ";", escape_double = FALSE, trim_ws = TRUE)

deep_1940_1950_sjdp <- read_delim("deep_1940_1950_plankton_sjdp.csv", 
                                  delim = ";", escape_double = FALSE, trim_ws = TRUE)

deep_1940_1950_sjdb <- read_delim("deep_1940_1950_benthos_sjdb.csv", 
                                  delim = ";", escape_double = FALSE, trim_ws = TRUE)

deep_1950_1960_sjdp <- read_delim("deep_1950_1960_plankton_sjdp.csv", 
                                  delim = ";", escape_double = FALSE, trim_ws = TRUE)

deep_1950_1960_sjdb <- read_delim("deep_1950_1960_benthos_sjdb.csv", 
                                  delim = ";", escape_double = FALSE, trim_ws = TRUE)

deep_1960_1970_sjdp <- read_delim("deep_1960_1970_plankton_sjdp.csv", 
                                  delim = ";", escape_double = FALSE, trim_ws = TRUE)

deep_1960_1970_sjdb <- read_delim("deep_1960_1970_benthos_sjdb.csv", 
                                  delim = ";", escape_double = FALSE, trim_ws = TRUE)

deep_1970_1980_sjdp <- read_delim("deep_1970_1980_plankton_sjdp.csv", 
                                  delim = ";", escape_double = FALSE, trim_ws = TRUE)

deep_1970_1980_sjdb <- read_delim("deep_1970_1980_benthos_sjdb.csv", 
                                  delim = ";", escape_double = FALSE, trim_ws = TRUE)

deep_1980_1990_sjdp <- read_delim("deep_1980_1990_plankton_sjdp.csv", 
                                  delim = ";", escape_double = FALSE, trim_ws = TRUE)

deep_1980_1990_sjdb <- read_delim("deep_1980_1990_benthos_sjdb.csv", 
                                  delim = ";", escape_double = FALSE, trim_ws = TRUE)

deep_1990_2000_sjdp <- read_delim("deep_1990_2000_plankton_sjdp.csv", 
                                  delim = ";", escape_double = FALSE, trim_ws = TRUE)

deep_1990_2000_sjdb <- read_delim("deep_1990_2000_benthos_sjdb.csv", 
                                  delim = ";", escape_double = FALSE, trim_ws = TRUE)

deep_2000_2010_sjdp <- read_delim("deep_2000_2010_plankton_sjdp.csv", 
                                  delim = ";", escape_double = FALSE, trim_ws = TRUE)

deep_2000_2010_sjdb <- read_delim("deep_2000_2010_benthos_sjdb.csv", 
                                  delim = ";", escape_double = FALSE, trim_ws = TRUE)

deep_2010_2020_sjdp <- read_delim("deep_2010_2020_plankton_sjdp.csv", 
                                  delim = ";", escape_double = FALSE, trim_ws = TRUE)

deep_2010_2020_sjdb <- read_delim("deep_2010_2020_benthos_sjdb.csv", 
                                  delim = ";", escape_double = FALSE, trim_ws = TRUE)

deep_2020_2024_sjdp <- read_delim("deep_2020_2024_plankton_sjdp.csv", 
                                  delim = ";", escape_double = FALSE, trim_ws = TRUE)

deep_2020_2024_sjdb <- read_delim("deep_2020_2024_benthos_sjdb.csv", 
                                  delim = ";", escape_double = FALSE, trim_ws = TRUE)

################  
#After importing from ArcGIS
#Plot logarithmic curves 

namesLogPlankton <- gsub("_nodups_shallow", "_sjdp", namesShallow)
namesLogBenthos <- gsub("_nodups_deep", "_sjdb", namesDeep)
namesLogPlankton <- gsub("planktonBenthos_", "deep_", namesLogPlankton)
namesLogBenthos <- gsub("planktonBenthos_", "deep_", namesLogBenthos)
namesLog <- c(namesLogPlankton, namesLogBenthos)
namesLog
labels <- gsub("deep_", "", namesLog)
labels <- gsub("plankton_", "", labels)
labels <- gsub("benthos_", "", labels)
labels

rm(i,x,a)
rm(sumSone,sumDone)
for(i in 1:length(namesLog)){
  
  x <- get(namesLog[i])
  x <- x$Join_Count
  
  log <- rle(sort(x))
  print(rle(sort(x)))
  logLengths <- log[["lengths"]]
  logValues <- log[["values"]]
  
  df <- as.data.frame(cbind(logLengths,logValues))
  subset <- df %>% filter(logValues == 1)
  
  if(nrow(subset > 0)){
    if(i == 1){sumSone <- subset$logLengths}
    if(i > 1 & i < 15){accum <- subset$logLengths
    sumSone <- sumSone + accum }
    if(i == 15){sumDone <- subset$logLengths}
    if(i > 15 & i < 29){accum <- subset$logLengths
    sumDone <- sumDone + accum }
    
    if(i == 14){print(sumSone)}
    if(i == 28){print(sumDone)}
  }
  
  df <- df %>% filter(logValues > 0)
  df
  if(nrow(df) > 0){
    for(a in 1:nrow(df)){
      if(df$logValues[a] > 0 & df$logValues[a] < 10){
        df$interval[a] = "A"
      }
      if(df$logValues[a] >= 10 & df$logValues[a] < 100){
        df$interval[a] = "B"
      }
      if(df$logValues[a] >= 100 & df$logValues[a] < 1000){
        df$interval[a] = "C"
      }
      if(df$logValues[a] >= 1000 & df$logValues[a] < 10000){
        df$interval[a] = "D"
      }
      if(df$logValues[a] >= 10000 & df$logValues[a] <= 100000){
        df$interval[a] = "E"
      }
      if(df$logValues[a] >= 100000 & df$logValues[a] <= 1000000){
        df$interval[a] = "F"
      }
    }
    
    df <- df %>% arrange(interval) %>% group_by(interval) %>% summarise(logCounts = sum(logLengths))
    df$indexTable <- labels[i]
    df
  }
  
  if(i == 1){
    table <- df
  }
  
  if(i > 1){
    table <- rbind(table,df)
  }
  
  logstable <- as.data.frame(table)
}

View(logstable)
rows <- unique(logstable$interval)
logsPlankton <- logstable[1:34,]
logsBenthos <- logstable[35:52,]

unique(logsPlankton$indexTable) 
unique(logsBenthos$indexTable)

tur <- colorRampPalette(c("turquoise","darkslategrey"))
palleteTur <- tur(length(unique(logsPlankton$indexTable)))

golds <- colorRampPalette(c("gold","darkgoldenrod4"))
palleteGold <- golds(length(unique(logsBenthos$indexTable)))

plotG <- ggplot(logsPlankton) + geom_point(aes(interval, logCounts, group = indexTable, color = indexTable)) + 
  geom_path(aes(interval, logCounts, group = indexTable, color = indexTable)) +
  scale_color_manual(values = palleteTur) + theme(legend.position="none") +
  theme(axis.title.x=element_blank()) + theme(axis.title.y=element_blank()) + 
  theme(axis.text.x=element_text(size = 12)) + theme(axis.text.y=element_text(size = 12))
plotG

plotH <- ggplot(logsBenthos) + geom_point(aes(interval, logCounts, group = indexTable, color = indexTable)) +
  geom_path(aes(interval, logCounts, group = indexTable, color = indexTable)) +
  scale_color_manual(values = palleteGold) + theme(legend.position="none") +
  theme(axis.title.x=element_blank()) + theme(axis.title.y=element_blank()) +
  theme(axis.text.x=element_text(size = 12)) + theme(axis.text.y=element_text(size = 12))
plotH

#Per decade
#Importing from ArcGIS (shallow planktonic and benthic subdatasets)       

library(readr) 
shallow_1876_1900_sjsp <- read_delim("shallow_1876_1900_plankton_sjsp.csv", 
                                     delim = ";", escape_double = FALSE, trim_ws = TRUE)

shallow_1876_1900_sjsb <- read_delim("shallow_1876_1900_benthos_sjsb.csv", 
                                     delim = ";", escape_double = FALSE, trim_ws = TRUE)

shallow_1900_1910_sjsp <- read_delim("shallow_1900_1910_plankton_sjsp.csv", 
                                     delim = ";", escape_double = FALSE, trim_ws = TRUE)

shallow_1900_1910_sjsb <- read_delim("shallow_1900_1910_benthos_sjsb.csv", 
                                     delim = ";", escape_double = FALSE, trim_ws = TRUE)

shallow_1910_1920_sjsp <- read_delim("shallow_1910_1920_plankton_sjsp.csv", 
                                     delim = ";", escape_double = FALSE, trim_ws = TRUE)

shallow_1910_1920_sjsb <- read_delim("shallow_1910_1920_benthos_sjsb.csv", 
                                     delim = ";", escape_double = FALSE, trim_ws = TRUE)

shallow_1920_1930_sjsp <- read_delim("shallow_1920_1930_plankton_sjsp.csv", 
                                     delim = ";", escape_double = FALSE, trim_ws = TRUE)

shallow_1920_1930_sjsb <- read_delim("shallow_1920_1930_benthos_sjsb.csv", 
                                     delim = ";", escape_double = FALSE, trim_ws = TRUE)

shallow_1930_1940_sjsp <- read_delim("shallow_1930_1940_plankton_sjsp.csv", 
                                     delim = ";", escape_double = FALSE, trim_ws = TRUE)

shallow_1930_1940_sjsb <- read_delim("shallow_1930_1940_benthos_sjsb.csv", 
                                     delim = ";", escape_double = FALSE, trim_ws = TRUE)

shallow_1940_1950_sjsp <- read_delim("shallow_1940_1950_plankton_sjsp.csv", 
                                     delim = ";", escape_double = FALSE, trim_ws = TRUE)

shallow_1940_1950_sjsb <- read_delim("shallow_1940_1950_benthos_sjsb.csv", 
                                     delim = ";", escape_double = FALSE, trim_ws = TRUE)

shallow_1950_1960_sjsp <- read_delim("shallow_1950_1960_plankton_sjsp.csv", 
                                     delim = ";", escape_double = FALSE, trim_ws = TRUE)

shallow_1950_1960_sjsb <- read_delim("shallow_1950_1960_benthos_sjsb.csv", 
                                     delim = ";", escape_double = FALSE, trim_ws = TRUE)

shallow_1960_1970_sjsp <- read_delim("shallow_1960_1970_plankton_sjsp.csv", 
                                     delim = ";", escape_double = FALSE, trim_ws = TRUE)

shallow_1960_1970_sjsb <- read_delim("shallow_1960_1970_benthos_sjsb.csv", 
                                     delim = ";", escape_double = FALSE, trim_ws = TRUE)

shallow_1970_1980_sjsp <- read_delim("shallow_1970_1980_plankton_sjsp.csv", 
                                     delim = ";", escape_double = FALSE, trim_ws = TRUE)

shallow_1970_1980_sjsb <- read_delim("shallow_1970_1980_benthos_sjsb.csv", 
                                     delim = ";", escape_double = FALSE, trim_ws = TRUE)

shallow_1980_1990_sjsp <- read_delim("shallow_1980_1990_plankton_sjsp.csv", 
                                     delim = ";", escape_double = FALSE, trim_ws = TRUE)

shallow_1980_1990_sjsb <- read_delim("shallow_1980_1990_benthos_sjsb.csv", 
                                     delim = ";", escape_double = FALSE, trim_ws = TRUE)

shallow_1990_2000_sjsp <- read_delim("shallow_1990_2000_plankton_sjsp.csv", 
                                     delim = ";", escape_double = FALSE, trim_ws = TRUE)

shallow_1990_2000_sjsb <- read_delim("shallow_1990_2000_benthos_sjsb.csv", 
                                     delim = ";", escape_double = FALSE, trim_ws = TRUE)

shallow_2000_2010_sjsp <- read_delim("shallow_2000_2010_plankton_sjsp.csv", 
                                     delim = ";", escape_double = FALSE, trim_ws = TRUE)

shallow_2000_2010_sjsb <- read_delim("shallow_2000_2010_benthos_sjsb.csv", 
                                     delim = ";", escape_double = FALSE, trim_ws = TRUE)

shallow_2010_2020_sjsp <- read_delim("shallow_2010_2020_plankton_sjsp.csv", 
                                     delim = ";", escape_double = FALSE, trim_ws = TRUE)

shallow_2010_2020_sjsb <- read_delim("shallow_2010_2020_benthos_sjsb.csv", 
                                     delim = ";", escape_double = FALSE, trim_ws = TRUE)

shallow_2020_2024_sjsp <- read_delim("shallow_2020_2024_plankton_sjsp.csv", 
                                     delim = ";", escape_double = FALSE, trim_ws = TRUE)

shallow_2020_2024_sjsb <- read_delim("shallow_2020_2024_benthos_sjsb.csv", 
                                     delim = ";", escape_double = FALSE, trim_ws = TRUE)

################  
#After importing from ArcGIS
#Plot logarithmic curves

namesLogPlankton <- gsub("deep", "shallow", namesLogPlankton)
namesLogPlankton <- gsub("sjdp", "sjsp", namesLogPlankton)
namesLogBenthos <- gsub("deep", "shallow", namesLogBenthos)
namesLogBenthos <- gsub("sjdb", "sjsb", namesLogBenthos)
namesLog <- c(namesLogPlankton, namesLogBenthos)
namesLog
labels <- gsub("shallow_", "", namesLog)
labels

rm(i,x,a)
for(i in 1:length(namesLog)){
  
  x <- get(namesLog[i])
  x <- x$Join_Count
  
  log <- rle(sort(x))
  print(rle(sort(x)))
  logLengths <- log[["lengths"]]
  logValues <- log[["values"]]
  
  df <- as.data.frame(cbind(logLengths,logValues))
  subset <- df %>% filter(logValues == 1)
  
  if(nrow(subset > 0)){
    if(i == 1){sumSone <- subset$logLengths}
    if(i > 1 & i < 15){accum <- subset$logLengths
    sumSone <- sumSone + accum }
    if(i == 15){sumDone <- subset$logLengths}
    if(i > 15 & i < 29){accum <- subset$logLengths
    sumDone <- sumDone + accum }
    
    if(i == 14){print(sumSone)}
    if(i == 28){print(sumDone)}
  }
  
  df <- df %>% filter(logValues > 0)
  df
  
  if(nrow(df) > 0){
    for(a in 1:nrow(df)){
      if(df$logValues[a] > 0 & df$logValues[a] < 10){
        df$interval[a] = "A"
      }
      if(df$logValues[a] >= 10 & df$logValues[a] < 100){
        df$interval[a] = "B"
      }
      if(df$logValues[a] >= 100 & df$logValues[a] < 1000){
        df$interval[a] = "C"
      }
      if(df$logValues[a] >= 1000 & df$logValues[a] < 10000){
        df$interval[a] = "D"
      }
      if(df$logValues[a] >= 10000 & df$logValues[a] <= 100000){
        df$interval[a] = "E"
      }
      if(df$logValues[a] >= 100000 & df$logValues[a] <= 1000000){
        df$interval[a] = "F"
      }
    }
    
    df <- df %>% arrange(interval) %>% group_by(interval) %>% summarise(logCounts = sum(logLengths))
    df$indexTable <- labels[i]
    df
  }
  
  if(i == 1){ 
    table <- df
  }
  
  if(i > 1){
    table <- rbind(table,df)
  }
  
  logstable <- as.data.frame(table)
}

View(logstable)
rows <- unique(logstable$interval)
logsPlankton <- logstable[1:48,]
logsBenthos <- logstable[49:84,]

unique(logsPlankton$indexTable)
unique(logsBenthos$indexTable)

tur <- colorRampPalette(c("turquoise","darkslategrey")) 
palleteTur <- tur(length(unique(logsPlankton$indexTable)))

golds <- colorRampPalette(c("gold","darkgoldenrod4"))
palleteGold <- golds(length(unique(logsBenthos$indexTable)))

plotI <- ggplot(logsPlankton) + geom_point(aes(interval, logCounts, group = indexTable, color = indexTable)) + 
  geom_path(aes(interval, logCounts, group = indexTable, color = indexTable)) +
  scale_color_manual(values = palleteTur) + theme(legend.position="none") +
  theme(axis.title.x=element_blank()) + theme(axis.title.y=element_blank()) +
  theme(axis.text.x=element_text(size = 12)) + theme(axis.text.y=element_text(size = 12))
plotI

plotJ <- ggplot(logsBenthos) + geom_point(aes(interval, logCounts, group = indexTable, color = indexTable)) +
  geom_path(aes(interval, logCounts, group = indexTable, color = indexTable)) +
  scale_color_manual(values = palleteGold) + theme(legend.position="none") +
  theme(axis.title.x=element_blank()) + theme(axis.title.y=element_blank()) +
  theme(axis.text.x=element_text(size = 12)) + theme(axis.text.y=element_text(size = 12))
plotJ

plotEtoH <- plot_grid(plotE, plotI, plotJ,
                      plotF, plotG, plotH) + labs(tag = "b)", size = 14) 
plotEtoH


############# 
# 1876-2024   
##tables for spatial analysis for shallow, deep, shallow and deep planktonic, shallow and deep benthic and all 

all_spatialsj <- read_delim("all_spatialsj.csv", 
                            delim = ";", escape_double = FALSE, trim_ws = TRUE)

shallowPL_spatialsj <- read_delim("shallowPL_spatialsj.csv", 
                                  delim = ";", escape_double = FALSE, trim_ws = TRUE)

shallowBE_spatialsj <- read_delim("shallowBE_spatialsj.csv", 
                                  delim = ";", escape_double = FALSE, trim_ws = TRUE)

shallow_spatialsj <- read_delim("shallow_spatialsj.csv", 
                                delim = ";", escape_double = FALSE, trim_ws = TRUE)

deepPL_spatialsj <- read_delim("deepPL_spatialsj.csv", 
                               delim = ";", escape_double = FALSE, trim_ws = TRUE)

deepBE_spatialsj <- read_delim("deepBE_spatialsj.csv", 
                               delim = ";", escape_double = FALSE, trim_ws = TRUE)

deep_spatialsj <- read_delim("deep_spatialsj.csv", 
                             delim = ";", escape_double = FALSE, trim_ws = TRUE)

################  
#After importing from ArcGIS
#Plot logarithmic curves

namesLog <- c("all_spatialsj","shallowPL_spatialsj","shallowBE_spatialsj","shallow_spatialsj",
              "deepPL_spatialsj","deepBE_spatialsj","deep_spatialsj")
namesLog
labels <- gsub("_spatialsj", "", namesLog)
labels

rm(i,x,a)
for(i in 1:length(namesLog)){
  
  x <- get(namesLog[i])
  x <- x$Join_Count
  
  log <- rle(sort(x))
  print(rle(sort(x)))
  logLengths <- log[["lengths"]]
  logValues <- log[["values"]]
  
  df <- as.data.frame(cbind(logLengths,logValues))
  subset <- df %>% filter(logValues == 1)
  print("#")
  print(namesLog[i])
  print(subset)
  print("#")
  
  if(nrow(subset > 0)){
    if(i == 1){sumSone <- subset$logLengths}
    if(i > 1 & i < 15){accum <- subset$logLengths
    sumSone <- sumSone + accum }
    if(i == 15){sumDone <- subset$logLengths}
    if(i > 15 & i < 29){accum <- subset$logLengths
    sumDone <- sumDone + accum }
    
    if(i == 14){print(sumSone)}
    if(i == 28){print(sumDone)}
  }
  
  df <- df %>% filter(logValues > 0)
  df
  
  if(nrow(df) > 0){
    for(a in 1:nrow(df)){
      if(df$logValues[a] > 0 & df$logValues[a] < 10){
        df$interval[a] = "A"
      }
      if(df$logValues[a] >= 10 & df$logValues[a] < 100){
        df$interval[a] = "B"
      }
      if(df$logValues[a] >= 100 & df$logValues[a] < 1000){
        df$interval[a] = "C"
      }
      if(df$logValues[a] >= 1000 & df$logValues[a] < 10000){
        df$interval[a] = "D"
      }
      if(df$logValues[a] >= 10000 & df$logValues[a] <= 100000){
        df$interval[a] = "E"
      }
      if(df$logValues[a] >= 100000 & df$logValues[a] <= 1000000){
        df$interval[a] = "F"
      }
    }
    
    df <- df %>% arrange(interval) %>% group_by(interval) %>% summarise(logCounts = sum(logLengths))
    df$indexTable <- labels[i]
    df
  }
   
  if(i == 1){
    table <- df
  }
  
  if(i > 1){
    table <- rbind(table,df)
  }
  
  logstable <- as.data.frame(table)
}

View(logstable)
names(logstable) <- c("interval","logCounts","subsets")
completesets <- logstable[c(1:6,16:21,29:32),]
psets <- logstable[c(7:11,22:25),]
bsets <- logstable[c(12:15,26:28),]
rows <- unique(logstable$interval)

#different pallete options
pall2 <- c("black","red","gold2","gold2","blue","turquoise","turquoise")
palleteBlue

##Plotting results

plotO <- ggplot(completesets) +
  scale_color_manual("Datasets", breaks = c("all","shallow","deep","deepPL","deepBE"), labels = c("All","Shallow","Deep","Planktonic","Benthic"), values = c("all"="black", "deep"="red3", "deepBE"="#E4BC01", "deepPL"="#3DC9BC", "shallow"="blue", "shallowBE"="#E4BC01", "shallowPL" = "#3DC9BC")) + 
  geom_point(data = completesets, aes(interval, logCounts, group = subsets, color = subsets), size = 1) + 
  geom_line(aes(interval, logCounts, group = subsets, color = subsets), size = 0.8) +
  geom_point(data = psets, aes(interval, logCounts, group = subsets, color = subsets), size = 1) + 
  geom_line(data = psets, aes(interval, logCounts, group = subsets, color = subsets, linetype = subsets), size = 1.0) +
  scale_linetype_manual("Subsets (P,B)", breaks = c("shallowBE","deepBE"), labels = c("Shallow","Deep"), values = c("shallowBE"="dotted","shallowPL"="dotted","deepBE"="longdash","deepPL"="longdash") ) +
  geom_point(data = bsets, aes(interval, logCounts, group = subsets, color = subsets), size = 1) + 
  geom_line(data = bsets, aes(interval, logCounts, group = subsets, color = subsets, linetype = subsets), size = 1.0) +
  theme(legend.position=c(0.92,0.54)) +
  theme(axis.title.x=element_blank()) +
  theme(axis.title.y=element_blank()) + theme(plot.margin = unit(c(25.0,5.5,5.5,2.5), "points")) +
  theme(axis.text.x=element_text(size = 12)) + theme(axis.text.y=element_text(size = 12)) 
plotO

plotO <- plot_grid(plotO) + labs(tag = "a)", size = 14) 
titleplot <- ggdraw() + draw_label("b)", x = 0, hjust = 0, size = 16)
plotR <- plot_grid(
  titleplot, plotEtoH, 
  ncol = 1,
  rel_heights = c(0.1, 1)
)

titleplot2 <- ggdraw() + draw_label("a)", x = 0, hjust = 0, size = 16) 

plotO2 <- plot_grid(
  titleplot2, plotO,
  ncol = 1,
  rel_heights = c(0.1, 1)
)

#adding x and y labels to the plot_grid
title.grob <- textGrob("1876-2024", 
                       gp=gpar(fontsize=18), hjust = 0.27) 

y.grob <- textGrob("Number of grid cells", 
                   gp=gpar(fontsize=14), rot=90, vjust = 1.5) 

x.grob <- textGrob("Category", 
                   gp=gpar(fontsize=14), hjust = 0.13)

plotQ <- plot_grid(rel_heights = c(0.5, 1), plotO, plotEtoH, ncol = 1) +
  theme(plot.margin = unit(c(0,10,0,20), "points"))

plotQ

grid.arrange(arrangeGrob(plotQ, left = y.grob, bottom = x.grob, top = title.grob))

##End script V.
