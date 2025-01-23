#IIIb. Depth analysis - Raster analysis 
setwd("//workingdirectory") #setting up the working directory.  

#Loading the API for EMODnet data, to retrieve .tiff bathymetric files.
install.packages("remotes")
remotes::install_github("EMODnet/EMODnetWFS")
library("EMODnetWFS")
wfs_bathy <- emodnet_init_wfs_client(service = "bathymetry")
info <- emodnet_get_wfs_info(wfs_bathy)

bathy <- emodnet_get_layers(
  service = "bathymetry",
  layers = c("download_tiles") )

bathy <- bathy[["download_tiles"]]
View(bathy)

urls <- bathy$download_url[2:32] #Goes to D rows #2-32 in EMODnet tiles.
for(i in 1:length(urls)){
  
  download.file(url=urls[i],
                destfile=gsub(" ","",paste("tile_",i,"2022.tif.zip")))
  route <- unzip(zipfile = gsub(" ","",paste("tile_",i,"2022.tif.zip")), exdir = "\\\\home.ansatt.ntnu.no/lcgarcia/Documents/R")
  tif <- raster(route)
  assign(gsub(" ","",paste("tif",i)), tif) }

#Comparing depths through .tiff files
summary(tif)
rm(i,a,y,y0)   
for(i in 1:length(namesContoursprovinces)){    
  
  y0 <- get(namesContoursprovinces[i]) %>% filter(!is.na(XCoord) | !is.na(YCoord))
  y <- st_as_sf(x = y0,                         
                coords = c("XCoord", "YCoord"),
                crs = 4326)
  
  for(a in 1:31){
    route <- unzip(zipfile = gsub(" ","",paste("tile_",a,"2022.tif.zip")), exdir = "\\\\home.ansatt.ntnu.no/lcgarcia/Documents/R")
    myraster <- read_stars(route)
    data <- data.frame(y$id, 
                       st_extract(myraster, y, na.rm=TRUE))
    names(data)[1] <- "id"
    names(data)[2] <- "rasterDepth"
    names(data)[3] <- "geometry"
    
    if(a == 1){ rasterfPoints <- data  }
    if(a > 1){  rasterfPoints <- rbind(rasterfPoints,data)  } }
  
  rasterfPoints <- rasterfPoints %>% filter(!is.na(rasterDepth))
  assign(gsub(" ","",paste(names[i],"_tifRawb")), rasterfPoints)
}          

rm(x,i,all,all2)            
for (i in 1:length(namesContoursprovinces)){
  all <- get(gsub(" ","",paste(names[i],"_tifRawb")))
  all2 <- all[c("id","rasterDepth")] %>% arrange(id) %>% group_by(id) %>% summarise(rasterDepth = mean(rasterDepth))
  x <- left_join((get(namesContoursprovinces[i])), all2, by = "id")
  assign(gsub(" ","",paste(names[i],"_tiffDepths")), x)
}

#These are the keeping objects
namesTiff <- gsub("worms", "worms_tiffDepths", names)
namesTiff

countsNotiff <- c()
rm(i,x,y,z)
for(i in 1:length(namesContoursprovinces)){
  x <- get(namesContoursprovinces[i]) 
  y <- get(gsub(" ","",paste(names[i],"_tiffDepths"))) %>% filter(!is.na(rasterDepth))
  z <- anti_join(x,y, by="id")
  countsNotiff[i] <- nrow(z)
  assign(gsub(" ","",paste(names[i],"_notiff")), z) }

namesNotiff <- gsub("_conMatch", "_notiff", namesContoursprovinces)
namesNotiff

#now analysing data with GEBCO raster bathymetrical files
matchGebco <- c()
rm(i,y,y0)
for(i in 1:length(namesNotiff)){
  
  y0 <- get(namesNotiff[i]) %>% filter(!is.na(XCoord) | !is.na(YCoord))
  
  y <- st_as_sf(x = y0,                         
                coords = c("XCoord", "YCoord"),
                crs = 4326)
  
  route <- "~/R/gebco_2023.tif"
  myraster <- read_stars(route)
  dataR <- data.frame(y$id, 
                      st_extract(myraster, y, na.rm=TRUE))
  
  names(dataR)[1] <- "id"
  names(dataR)[2] <- "rasterDepth"
  names(dataR)[3] <- "geometry"
  
  rasterfPoints <- dataR %>% filter(!is.na(rasterDepth))
  matchGebco[i] <- nrow(rasterfPoints)
  assign(gsub(" ","",paste(names[i],"_tifGebco")), rasterfPoints)
}

#unifying information
countsAlltiffxy <- c()
countsAlltiff <- c()
rm(i,w,x,y,z)
for(i in 1:length(namesContoursprovinces)){
  w <- get(namesContoursprovinces[i]) 
  x <- get(gsub(" ","",paste(names[i],"_tiffDepths"))) %>% filter(!is.na(rasterDepth)) %>% dplyr::select(id, rasterDepth)
  names(x) <- c("id", "rasterDepth")
  x <- x %>% arrange(id) %>% group_by(id) %>% summarise(rasterDepth = mean(rasterDepth))
  
  
  y <- get(gsub(" ","",paste(names[i],"_tifGebco"))) %>% dplyr::select(id, rasterDepth)
  y$rasterDepth <- as.numeric(gsub(" [m]", "", y$rasterDepth))
  y <- y %>% arrange(id) %>% group_by(id) %>% summarise(rasterDepth = mean(rasterDepth))
  y <- y %>% filter(rasterDepth <= 0)
  assign(gsub(" ","",paste(names[i],"_tifGebcoNeg")),y)
  
  xy <- rbind(x,y)
  xy <- xy %>% arrange(id) %>% group_by(id) %>% summarise(rasterDepth = mean(rasterDepth))
  
  z <- left_join(w, xy, by="id")
  countsAlltiffxy[i] <- nrow(xy)
  countsAlltiff[i] <- nrow(z)
  assign(gsub(" ","",paste(names[i],"_tiffDepths")), z)
}

#with the stored bathymetrical data from previous steps, now comparing with occurrence data
rm(a,x,i)
for(i in 1:length(namesTiff)){ 
  
  x <- get(namesTiff[i])
  x$depthAccuracy <- as.numeric(x$depthAccuracy)
  print(names(x))
  x <- x %>% filter(!is.na(rasterDepth))
  x <- x %>% filter(!is.na(depth)) ### records with depth
  print(nrow(x %>% filter(is.na(depth))))
  x$rasterDepth <- abs(x$rasterDepth)
  x$depth <- abs(x$depth)
  
  if(nrow(x) > 0){
    for(a in 1:nrow(x)){
      
      if(i > 0 & i < 15){
        
        if(!is.na(x$rasterDepth[a]) & !is.na(x$depthAccuracy[a])){
          
          if (x$rasterDepth[a] < (x$depth[a] - x$depthAccuracy[a])){
            x$tiffmatch[a] <- "tiffBelowdepth"  }
          
          if(x$rasterDepth[a] > (x$depth[a] + x$depthAccuracy[a])){
            x$tiffmatch[a] <- "tiffPlankton"    }
          
          if((x$rasterDepth[a] <= (x$depth[a] + x$depthAccuracy[a])) & (x$rasterDepth[a] >= (x$depth[a] - x$depthAccuracy[a]))){
            x$tiffmatch[a] <- "tiffBenthos"     } }
        
        if(!is.na(x$rasterDepth[a]) & is.na(x$depthAccuracy[a])){
          
          if (x$rasterDepth[a] < x$depth[a]){
            x$tiffmatch[a] <- "tiffBelowdepth"  }
          
          if(x$rasterDepth[a] > x$depth[a]){
            x$tiffmatch[a] <- "tiffPlankton"    }
          
          if(x$rasterDepth[a] == x$depth[a]){
            x$tiffmatch[a] <- "tiffBenthos"     } } }
      
      if(i > 14){
        
        if(!is.na(x$rasterDepth[a]) & !is.na(x$minimumDepthInMeters[a]) & !is.na(x$maximumDepthInMeters[a])){
          
          if(x$rasterDepth[a] < x$minimumDepthInMeters[a]){
            x$tiffmatch[a] <- "tiffBelowdepth"  }
          
          if(x$rasterDepth[a] > x$maximumDepthInMeters[a]){
            x$tiffmatch[a] <- "tiffPlankton"    }
          
          if((x$rasterDepth[a] <= x$maximumDepthInMeters[a]) & (x$rasterDepth[a] >= x$minimumDepthInMeters[a])){
            x$tiffmatch[a] <- "tiffBenthos"     } }
        
        if( !is.na(x$rasterDepth[a]) &  (is.na(x$minimumDepthInMeters[a]) | is.na(x$maximumDepthInMeters[a]) ) )   {
          
          if (x$rasterDepth[a] < x$depth[a]){
            x$tiffmatch[a] <- "tiffBelowdepth"  }
          
          if(x$rasterDepth[a] > x$depth[a]){
            x$tiffmatch[a] <- "tiffPlankton"  }
          
          if(x$rasterDepth[a] == x$depth[a]){
            x$tiffmatch[a] <- "tiffBenthos"   } } }   }}
    assign(gsub(" ","",paste(names[i],"_planktonBenthos")), x)   }         
  
namesPlanktonBenthos <- gsub("_conMatch","_planktonBenthos", namesContoursprovinces)
namesPlanktonBenthos 

##End script IIIb.
 