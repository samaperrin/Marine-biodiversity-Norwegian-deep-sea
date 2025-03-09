#IIIb. Depth analysis - Raster analysis 
# setwd("//workingdirectory") #setting up the working directory.  

#Loading the API for EMODnet data, to retrieve .tiff bathymetric files.
if (!("remotes" %in% installed.packages())) {install.packages("remotes")} 
if (!("emodnet.wfs" %in% installed.packages())) {remotes::install_github("EMODnet/EMODnetWFS")} 

library(sf)
library(dplyr)
library(stars)

# Load in processed data
contourProvinces <- readRDS("data/depthAnalysedData.RDS")
namesContourProvinces <- names(contourProvinces)
namesToUse <- gsub("_conMatch", "", namesContourProvinces)
cat("Loaded data\n")

if (!dir.exists("data/bathy")) {
  library("emodnet.wfs")
  library(raster)
  wfs_bathy <- emodnet_init_wfs_client(service = "bathymetry")
  info <- emodnet_get_wfs_info(wfs_bathy)
  
  bathy <- emodnet_get_layers(
    service = "bathymetry",
    layers = c("download_tiles") )
  
  bathy <- bathy[["download_tiles"]]
  urls <- bathy$download_url[2:32]
  
  dir.create("data/bathy")
  for(i in 1:length(urls)){
    
    download.file(url=urls[i],
                  destfile=paste0("data/bathy/tile_",i,"2022.tif.zip"))
    route <- unzip(zipfile = paste0("data/bathy/tile_",i,"2022.tif.zip"), exdir = "data/bathy")
    
  }}

# Get rasters
rasterList <- list.files("data/bathy",pattern = "mean.tif", full.names = TRUE)


#Comparing depths through .tiff files
tifRawb <- list()
for(i in 1:length(contourProvinces)){    
  
  y0 <- contourProvinces[[i]] %>% filter(!is.na(XCoord) | !is.na(YCoord))
  y <- st_as_sf(x = y0,                         
                coords = c("XCoord", "YCoord"),
                crs = 4326)
  
  for(a in 1:length(rasterList)){
    route <- rasterList[a]
    cat("\nLoading raster", a, "on dataset", i)
    # myraster <- read_stars(route)
    # data <- data.frame(y$id, 
    #                    st_extract(myraster, y, na.rm=TRUE))
    
    myraster2 <- terra::rast(route)
    extraction <- cbind(y$geometry,terra::extract(myraster2, terra::vect(y)))
    data2 <- data.frame(y$id, extraction[,c(3,1)])
    
    names(data2)[1] <- "id"
    names(data2)[2] <- "rasterDepth"
    names(data2)[3] <- "geometry"
    
    if(a == 1){ rasterfPoints <- data2  }
    if(a > 1){  rasterfPoints <- rbind(rasterfPoints,data2)  
    cat("\nRun raster", a, "on dataset", i)
    } 
  }
  
  rasterfPoints <- rasterfPoints %>% filter(!is.na(rasterDepth))
  assign(paste0(namesContourProvinces[i],"_tifRawb"), rasterfPoints)
  tifRawb[[i]] <- rasterfPoints
}          
cat("Saving data")
names(tifRawb) <- paste0(namesContourProvinces,"_tifRawb")
saveRDS(tifRawb, "tiffRawb.RDS")
Sys.time()
stop("Don't run more")


# If starting from here

tifRawb <- readRDS("tiffRawb.RDS")
contourProvinces <- readRDS("data/depthAnalysedData.RDS")
namesContourProvinces <- names(contourProvinces)
namesToUse <- gsub("_conMatch", "", namesContourProvinces)

tiffDepths <- list()
for (i in 1:length(contourProvinces)){
  all <- tifRawb[[i]]
  all2 <- all[c("id","rasterDepth")] %>% arrange(id) %>% group_by(id) %>% summarise(rasterDepth = mean(rasterDepth))
  x <- left_join(contourProvinces[[i]], all2, by = "id")
  assign(paste0(namesToUse[i],"_tiffDepths"), x)
  tiffDepths[[i]] <- x
}
names(tiffDepths) <- paste0(namesToUse,"_tiffDepths")

#These are the keeping objects
namesTiff <- gsub("worms", "worms_tiffDepths", namesToUse)
namesTiff

countsNotiff <- c()
noTiff <- list()
for(i in 1:length(contourProvinces)){
  x <- contourProvinces[[i]] 
  y <- tiffDepths[[i]] %>% filter(!is.na(rasterDepth))
  z <- anti_join(x,y, by="id")
  countsNotiff[i] <- nrow(z)
  assign(paste0(namesToUse[i],"_notiff"), z) 
  noTiff[[i]] <- z
}

namesNotiff <- gsub("_conMatch", "_notiff", namesContourProvinces)
names(noTiff) <- namesNotiff

#now analysing data with GEBCO raster bathymetrical files
matchGebco <- c()
tifGebco <- list()
gebcoRaster <- read_stars("data/gebco_2023.tif", proxy = FALSE)
for(i in 1:length(namesNotiff)){
  
  y0 <- noTiff[[i]] %>% filter(!is.na(XCoord) | !is.na(YCoord))
  
  y <- st_as_sf(x = y0,                         
                coords = c("XCoord", "YCoord"),
                crs = 4326)
  
  dataR <- data.frame(y$id, st_extract(gebcoRaster, y, na.rm=TRUE))
  
  names(dataR)[1] <- "id"
  names(dataR)[2] <- "rasterDepth"
  names(dataR)[3] <- "geometry"
  
  rasterfPoints <- dataR %>% filter(!is.na(rasterDepth))
  matchGebco[i] <- nrow(rasterfPoints)
  assign(paste0(namesToUse[i],"_tifGebco"), rasterfPoints)
  tifGebco[[i]] <- rasterfPoints
}

#unifying information
countsAlltiffxy <- c()
countsAlltiff <- c()
tifGebcoNeg <- list()
tiffDepths2 <- list()
for(i in 1:length(contourProvinces)){
  w <- contourProvinces[[i]]
  x <- tiffDepths[[i]] %>% filter(!is.na(rasterDepth)) %>% dplyr::select(id, rasterDepth)
  names(x) <- c("id", "rasterDepth")
  x <- x %>% arrange(id) %>% group_by(id) %>% summarise(rasterDepth = mean(rasterDepth))
  
  
  y <- tifGebco[[i]] %>% dplyr::select(id, rasterDepth)
  y$rasterDepth <- as.numeric(gsub(" [m]", "", y$rasterDepth))
  y <- y %>% arrange(id) %>% group_by(id) %>% summarise(rasterDepth = mean(rasterDepth))
  y <- y %>% filter(rasterDepth <= 0)
  assign(gsub(" ","",paste(namesToUse[i],"_tifGebcoNeg")),y)
  tifGebcoNeg[[i]] <- y
  
  xy <- rbind(x,y)
  xy <- xy %>% arrange(id) %>% group_by(id) %>% summarise(rasterDepth = mean(rasterDepth))
  
  z <- left_join(w, xy, by="id")
  countsAlltiffxy[i] <- nrow(xy)
  countsAlltiff[i] <- nrow(z)
  assign(paste0(namesToUse[i],"_tiffDepths"), z)
  tiffDepths2[[i]] <- z
}
names(tiffDepths2) <- paste0(namesToUse,"_tiffDepths")

#with the stored bathymetrical data from previous steps, now comparing with occurrence data
rm(a,x,i)
planktonBenthos <- list()
for(i in 1:length(namesTiff)){ 
  
  x <- tiffDepths2[[i]]
  x$depthAccuracy <- as.numeric(x$depthAccuracy)
  print(names(x))
  x <- x %>% filter(!is.na(rasterDepth))
  x <- x %>% filter(!is.na(depth)) ### records with depth
  print(nrow(x %>% filter(is.na(depth))))
  x$rasterDepth <- abs(x$rasterDepth)
  x$depth <- abs(x$depth)
  
  if(nrow(x) > 0){
    for(a in 1:nrow(x)){
      
      if(grepl("gbif" ,namesTiff[i])){
        
        if(!is.na(x$rasterDepth[a]) & !is.na(x$depthAccuracy[a])) {
          
          if (x$rasterDepth[a] < (x$depth[a] - x$depthAccuracy[a])) {
            x$tiffmatch[a] <- "tiffBelowdepth"  
          }
          
          if(x$rasterDepth[a] > (x$depth[a] + x$depthAccuracy[a])){
            x$tiffmatch[a] <- "tiffPlankton"    
          }
          
          if((x$rasterDepth[a] <= (x$depth[a] + x$depthAccuracy[a])) & (x$rasterDepth[a] >= (x$depth[a] - x$depthAccuracy[a]))){
            x$tiffmatch[a] <- "tiffBenthos"     
          } 
        }
        
        if(!is.na(x$rasterDepth[a]) & is.na(x$depthAccuracy[a])){
          
          if (x$rasterDepth[a] < x$depth[a]) {
            x$tiffmatch[a] <- "tiffBelowdepth"  }
          
          if(x$rasterDepth[a] > x$depth[a]){
            x$tiffmatch[a] <- "tiffPlankton"    }
          
          if(x$rasterDepth[a] == x$depth[a]){
            x$tiffmatch[a] <- "tiffBenthos"     } } 
        
      } else {
        
        if(!is.na(x$rasterDepth[a]) & !is.na(x$minimumDepthInMeters[a]) & !is.na(x$maximumDepthInMeters[a])){
          
          if(x$rasterDepth[a] < x$minimumDepthInMeters[a]){
            x$tiffmatch[a] <- "tiffBelowdepth"  }
          
          if(x$rasterDepth[a] > x$maximumDepthInMeters[a]){
            x$tiffmatch[a] <- "tiffPlankton"    }
          
          if((x$rasterDepth[a] <= x$maximumDepthInMeters[a]) & (x$rasterDepth[a] >= x$minimumDepthInMeters[a])){
            x$tiffmatch[a] <- "tiffBenthos"     } 
        }
        
        if( !is.na(x$rasterDepth[a]) &  (is.na(x$minimumDepthInMeters[a]) | is.na(x$maximumDepthInMeters[a]) ) )   {
          
          if (x$rasterDepth[a] < x$depth[a]){
            x$tiffmatch[a] <- "tiffBelowdepth"  }
          
          if(x$rasterDepth[a] > x$depth[a]){
            x$tiffmatch[a] <- "tiffPlankton"  }
          
          if(x$rasterDepth[a] == x$depth[a]){
            x$tiffmatch[a] <- "tiffBenthos"   } 
        } 
      }   
    }
  }
  assign(gsub(" ","",paste(namesToUse[i],"_planktonBenthos")), x)  
  planktonBenthos[[i]] <- x
}

namesPlanktonBenthos <- gsub("_conMatch","_planktonBenthos", namesContourProvinces)
names(planktonBenthos) <- namesPlanktonBenthos 
saveRDS(planktonBenthos, "data/dataPlanktonBenthos.RDS")
saveRDS(tiffDepths2, "data/tiffDepths2.RDS")

##End script IIIb.
