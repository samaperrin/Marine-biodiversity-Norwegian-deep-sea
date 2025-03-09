#IIIa. Depth analysis - Depth-contouring analysis 
#setwd("//workingdirectory") #setting up the working directory.   
library(dplyr)
library(sf)
library(stringr)

# Import filtered data
filteredData <- readRDS("data/filteredData.RDS")
namesToUse <- paste0(names(filteredData), "_mkd_worms")

#Assigning and naming dataset columns
formattedData <- list()
for(i in 1:length(filteredData)){
  x <- filteredData[i][[1]]
  dsName <- names(filteredData)[i]
  
  if (grepl("gbif", dsName)){
    #print(names(x))
    x <- x %>%
      rename("dataset" = "datasetKey",
             "id" = "gbifID",
             "flags" = "issue")
    x$minimumDepthInMeters <- NA
    x$maximumDepthInMeters <- NA 
    x$database <- "gbif"
    x$id = as.character(x$id)
    x$dateIdentified = as.character(x$dateIdentified)  }  
  if (grepl("obis", dsName)){
    x <- x %>%
      rename("dataset" = "datasetName")
    print(names(x))
    x$depthAccuracy <- NA 
    x$database <- "obis"  } 
  #if (i == 29){
  #x$database <- "emodnet"  }
  if (grepl("nexpd", dsName)){
    x$database <- "NNAexp86-88"  }
  
  x$year = as.numeric(x$year) 
  x$month = as.numeric(x$month)
  x$day = as.numeric(x$day)
  x$coordinateUncertaintyInMeters = as.numeric(x$coordinateUncertaintyInMeters)
  x$individualCount = as.numeric(x$individualCount)
  x$depth <- abs(x$depth)
  x$scientificName = str_extract(string = x$scientificName, pattern = "[a-zA-Z]{1,25}\\s{1}[a-z]{2,25}")
  formattedData[[i]] <- x
  assign(namesToUse[i], x)
} 
names(formattedData) <- names(filteredData)

#Assigning new fields from depth-contouring analysis   

#Splitting in 500m depth intervals 
#Assigning depth bands and filling missing depths with NA 

formattedData2 <- list()
for (i in 1:length(formattedData)){
  
  #I. Split records that do not have recorded depth from those that have recorded depth 
  y0 <- formattedData[i][[1]]
  
  nodepth_mkd <- y0[is.na(y0$depth),]
  nodepth_mkd$XCoord <- nodepth_mkd$decimalLongitude
  nodepth_mkd$YCoord <- nodepth_mkd$decimalLatitude
  
  depth_mkd <- y0[!is.na(y0$depth),]
  depth_mkd$XCoord <- depth_mkd$decimalLongitude
  depth_mkd$YCoord <- depth_mkd$decimalLatitude
  
  if(nrow(nodepth_mkd) > 0){
    #II. Retrieving depth intervals for records that do not have depth by checking which contour the coordinates match with
    mn <- 0
    mx <- 500
    
    while (mn < 6000){
      
      x <- st_read(as.character(paste0("data/contours/contour",mn,"_",mx,".shp")))
      
      if(i == 1){ #For 1876_99 only. Records with no recorded coordinates need to be excluded in this step.
        nodepth_mkd_noNA <- nodepth_mkd %>% filter(!is.na(nodepth_mkd$XCoord) & !is.na(nodepth_mkd$YCoord))
        nodepth_mkd_NA <- nodepth_mkd %>% filter(is.na(nodepth_mkd$XCoord) | is.na(nodepth_mkd$YCoord))
        y <- st_as_sf(x = nodepth_mkd_noNA,      #For all except 1876_99: nodepth_mkd                   
                      coords = c("XCoord", "YCoord"),
                      crs = 4326)  }
      
      if(i != 1){
        y <- st_as_sf(x = nodepth_mkd,      #For all except 1876_99: nodepth_mkd                   
                      coords = c("XCoord", "YCoord"),
                      crs = 4326)  }
      sf_use_s2(FALSE)
      y_int <- st_intersects(y,x)
      sf_use_s2(TRUE)
      
      # Isolate rows which intersect with relevant contour
      y_log <- lengths(y_int) > 0 
      mkd <- y[y_log, ]
      mkd$XCoord <- st_coordinates(mkd$geometry)[,1]
      mkd$YCoord <- st_coordinates(mkd$geometry)[,2]
      mkd <- as.data.frame(mkd)
      
      if(nrow(mkd) > 0){
        mkd$minContour <- mn
        mkd$maxContour <- mx  }
      
      assign(gsub(" ","",paste(namesToUse[i],"_",mn,"_",mx)), mkd)
      
      if (mn == 0){
        mkd_allcont <- mkd  }
      
      if (mn > 0 & nrow(mkd) > 0){
        mkd_allcont <- rbind(mkd_allcont,mkd)  }
      
      mn <- mn + 500
      mx <- mx + 500 
    }
    
    #get the set that corresponds to the polygon. Graphically represent the result to confirm it and join to the corresponding depth (0to500)
    #For 1876_99 only
    if(i == 1){
      polygon <- anti_join(nodepth_mkd_noNA,mkd_allcont, by = "id") }
    
    if(i != 1){
      polygon <- anti_join(nodepth_mkd,mkd_allcont, by = "id")    }
    
    if(nrow(polygon) > 0){
      polygon$minContour <- 0
      polygon$maxContour <- 500    }
    
    polygon$XCoord <- polygon$decimalLongitude
    polygon$YCoord <- polygon$decimalLatitude
    mkd_0_500 <- rbind(get(paste0(namesToUse[i],"_0_500")), polygon)
    assign(paste0(namesToUse[i],"_0_500"), mkd_0_500)
    
    #Assigning depths accordingly to the contours 
    rm(x,y)
    mn <- 0
    mx <- 500
    while (mn < 6000){  
      adddepth <- get(gsub(" ","",paste(namesToUse[i],"_",mn,"_",mx)))
      
      if (nrow(adddepth) > 0){
        adddepth$depth <- NA
        adddepth$depthAccuracy <- 0.999999   #To identify records with missing depths through depthAccuracy
        assign(gsub(" ","",paste(namesToUse[i],"_",mn,"_",mx,"_adddepth")),adddepth)    }
      
      #Creating a new nodepth records with new established depths
      if (mn == 0){
        nodepth_mkd_new <- adddepth    }
      
      if (mn > 0 & nrow(adddepth) > 0){
        nodepth_mkd_new <- rbind(nodepth_mkd_new,adddepth)    }
      
      mn <- mn + 500
      mx <- mx + 500
    }
    
    depth_mkd$minContour <- NA
    depth_mkd$maxContour <- NA
    dbs_mkd_taxa_new <- rbind(depth_mkd,nodepth_mkd_new)  
    
    assign(gsub(" ","",paste(namesToUse[i],"_extDepthsbind")),dbs_mkd_taxa_new)
    
  }
  formattedData2[[i]] <- dbs_mkd_taxa_new
} 

names(formattedData2) <- names(formattedData)

#Create the objects for occurrences without depth

for(i in 1:length(formattedData2)){
  mn <- 0
  mx <- 500
  
  while (mn < 6000){ 
    adddepth <- get(paste0(namesToUse[i],"_",mn,"_",mx))
    
    if (nrow(adddepth) == 0){ assign(paste0(names(formattedData2)[i],"_",mn,"_",mx,"_adddepth"),adddepth)   }
    
    mn <- mn + 500
    mx <- mx + 500     } }

#These are the keeping objects and the labels for the years
namesContours <- gsub("worms", "worms_extDepthsbind", namesToUse)
namesContours

#II. Getting two depth intervals (0-500m and 500 and below)
namesShallow <- c()
namesDeep <- c()

rm(i)
for (i in 1:length(namesToUse)){
  
  df <- get(namesContours[i])
  namesShallow[i] <- paste0(namesToUse[i],"_shallow")
  namesDeep[i] <- paste0(namesToUse[i],"_deep")
  shallow <- df %>% filter(depth<500 | minContour == 0)
  assign(paste0(namesToUse[i],"_shallow"),shallow)
  deep <- df %>% filter(depth>=500 | minContour > 0)
  assign(paste0(namesToUse[i],"_deep"),deep)
  namesShallowDeep <- c(namesShallow, namesDeep)
} 
rm(i,shallow,deep)


#III. Assigning new fields       
#Note: There are records that register depths in a different contour than they are supposed to be. 
# See ShallowFromDeepSet definition in the manuscript.
rm(i,x,a,y0)     

for (i in 1:length(namesShallowDeep)){ 
  mn <- 0
  mx <- 500
  while (mn < 6000){
    
    x <- st_read(as.character(gsub(" ","",paste("data/contours/contour",mn,"_",mx,".shp"))))
    
    if(i == 30 | i == 60){
      dbs_mkd_taxa_new1xxx_1899_coordinated <- get(namesShallowDeep[i]) %>% filter(!is.na(decimalLongitude) | !is.na(decimalLatitude))
      dbs_mkd_taxa_new1xxx_1899_coordinated$XCoord <- dbs_mkd_taxa_new1xxx_1899_coordinated$decimalLongitude
      dbs_mkd_taxa_new1xxx_1899_coordinated$YCoord <- dbs_mkd_taxa_new1xxx_1899_coordinated$decimalLatitude
      y <- st_as_sf(x = dbs_mkd_taxa_new1xxx_1899_coordinated,                         
                    coords = c("XCoord", "YCoord"),
                    crs = 4326) }
    
    if(i != 30 & i != 60){
      y0 <- get(namesShallowDeep[i]) %>% filter(!is.na(decimalLongitude) | !is.na(decimalLatitude))
      y0$XCoord <- y0$decimalLongitude
      y0$YCoord <- y0$decimalLatitude
      y <- st_as_sf(x = y0,                         
                    coords = c("XCoord", "YCoord"),
                    crs = 4326) }
    sf_use_s2(FALSE)
    y_int <- st_intersects(y,x)
    sf_use_s2(TRUE)
    y_log <- lengths(y_int) > 0 
    mkd <- y[y_log, ]  
    mkd$XCoord <- st_coordinates(mkd$geometry)[,1]
    mkd$YCoord <- st_coordinates(mkd$geometry)[,2]
    mkd <- as.data.frame(mkd)
    
    #Occurrences with depth were not contoured before, then here we assign the contour, 
    # to perform the calculations below.
    if(nrow(mkd) > 0){
      for(a in 1:nrow(mkd)){
        if(is.na(mkd$minContour[a])){
          mkd$minContour <- mn
          mkd$maxContour <- mx   }}}
    
    assign(paste0(namesShallowDeep[i],"_mkd_",mn,"_",mx), mkd)
    
    if (mn == 0){ mkd_allcont <- mkd  }
    if (mn > 0){ mkd_allcont <- rbind(mkd_allcont,mkd)  }
    
    mn <- mn + 500
    mx <- mx + 500
  }
  
  # get the set that corresponds to the polygon and graphically represent the result to confirm it and 
  # join to the corresponding depth (0to500)
  if(i == 30 | i == 60){ polygon <- anti_join(as.data.frame(dbs_mkd_taxa_new1xxx_1899_coordinated),as.data.frame(mkd_allcont), by = "id")  }
  if(i != 30 & i != 60){ polygon <- anti_join(as.data.frame(get(namesShallowDeep[i])),as.data.frame(mkd_allcont), by = "id")   }
  
  #The records with depth were not contoured before, then here we assign the contour, to perform the calculations below.
  if(nrow(polygon) > 0){
    for(a in 1:nrow(polygon)){
      if(is.na(polygon$minContour[a])){
        polygon$minContour <- 0
        polygon$maxContour <- 500    }}}  
  
  polcontour <- rbind(get(paste0(namesShallowDeep[i],"_mkd_0_500")), polygon)
  assign(gsub(" ","",paste(namesShallowDeep[i],"_mkd_0_500")), polcontour)
  rm(x,y,a) }

#Ocean provinces are assigned and correspondence with contours is written in the column matchContour.
for (i in 1:length(namesShallowDeep)){ 
  mn <- 0
  mx <- 500
  while (mn < 6000){
    setone <- get(paste0(namesShallowDeep[i],"_mkd_",mn,"_",mx))
    
    #Assigning new fields
    if(nrow(setone) > 0){
      
      if (grepl("shallow", namesShallowDeep[i])){ 
        setone$oProvince <- "epipelagic and mesopelagic" #oceanic provinces
        
        if (mn == 0){setone$matchContour <- "matchShallow" }
        #this set corresponds to the shallow dataset geographically
        if (mn > 0){setone$matchContour <- "matchShallow"   }
        
      } else { 
        #oceanic provinces
        if(mn == 0){setone$oProvince <- "epipelagic and mesopelagic"}
        if(mn == 500){setone$oProvince <- "mesopelagic"}
        if(mn >= 1000 & mn < 4000){setone$oProvince <- "bathypelagic"}
        if(mn >= 4000){setone$oProvince <- "abyssopelagic"}
        
        if (mn == 0){setone$matchContour <- "shallowFromDeepSet" }
        #this set corresponds to the deep dataset geographically
        if (mn > 0){setone$matchContour <- "matchDeep" }}
      
      if(mn == 0){settwo <- setone}
      if(mn > 0){settwo <- rbind(settwo, setone) }}
    
    mn <- mn + 500
    mx <- mx + 500   }
  
  assign(gsub(" ","",paste(namesShallowDeep[i], "_conMatch")),settwo)  
  rm(setone, settwo) }

#These are keeping objects
namesContoursprovincesShallow <- gsub("shallow", "shallow_conMatch", namesShallow)
namesContoursprovincesDeep <- gsub("deep", "deep_conMatch", namesDeep)
namesContoursprovinces <- gsub("worms", "worms_conMatch", namesToUse)
namesContoursprovinces

#Merge 
for(i in 1:length(namesToUse)){
  a <- get(namesContoursprovincesShallow[i])
  b <- get(namesContoursprovincesDeep[i])
  x <- rbind(a,b) 
  assign(paste0(namesToUse[i], "_conMatch"),x) }

#removing duplicated occurrences (e.g. might have fallen in the line between two contours) until this point  
rm(x,i)
depthAnalysedList <- list()
for (i in 1:length(namesContoursprovinces)){
  x <- get(namesContoursprovinces[i])
  x2 <- x[!duplicated(x$id),]
  print(head(x[duplicated(x$id),]))
  assign(paste0(namesToUse[i], "_conMatch"),x2)
  depthAnalysedList[[i]] <- x2}
names(depthAnalysedList) <- paste0(namesToUse, "_conMatch")
saveRDS(depthAnalysedList, "data/depthAnalysedData.RDS")
###End script IIIa.
