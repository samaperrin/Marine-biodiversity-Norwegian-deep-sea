#IVa. Biological diversity - Removing duplicates 
#setting up the working directory.   
library(dplyr)
library(sf)

planktonBenthos <- readRDS("data/dataPlanktonBenthos.RDS")
tiffDepths <- readRDS("data/tiffDepths2.RDS")

#Exploring data structure
lenghtsts <- c()
timeSeries_planktonBenthos <- list()
for(i in 1:length(planktonBenthos)){
  x <- planktonBenthos[[i]]
  if (i == 1){
    y <- x
    lenghtsts[i] <- nrow(x)   }
  
  if (i > 1){
    y <- rbind(y, x)
    lenghtsts[i] <- nrow(x)   }
  
  timeSeries_planktonBenthos <- y 
  sum(lenghtsts)  
}

#Splitting data in decades
ini <- 1890
fin <- 1900
namesTimeSeries <- c()
timeSeries <- list()

for(i in 1:14){
  
  x <- timeSeries_planktonBenthos
  
  if(i == 1){
    y <- x[x$year >= 1876 & x$year < fin,] # Removing pre-1876 occurrences
    sum <- nrow(y)  }
  
  if(i > 1 & i < 14){
    y <- x[x$year >= ini & x$year < fin,]
    sum <- sum + nrow(y)  }
  
  if(i == 14){
    y <- x[x$year >= ini,]
    sum <- sum + nrow(y)  }
  
  if(i == 1){
    assign(gsub(" ","",paste("planktonBenthos_1876_",fin)), y)
    timeSeries[[i]] <- y
    namesTimeSeries[i] <- gsub(" ","",paste("planktonBenthos_1876_",fin)) 
  } else if (i == 14) {
    assign(gsub(" ","",paste("planktonBenthos_",ini,"_2024")), y)
    timeSeries[[i]] <- y
    namesTimeSeries[i] <- gsub(" ","",paste("planktonBenthos_",ini,"_2024"))  
  } else {
    assign(paste0("planktonBenthos_",ini,"_",fin), y)
    timeSeries[[i]] <- y
    namesTimeSeries[i] <- gsub(" ","",paste("planktonBenthos_",ini,"_",fin))
  }
  
  print(ini)
  print(fin)
  ini <- ini + 10
  fin <- fin + 10  
}

names(timeSeries) <- namesTimeSeries
namesTimeSeries

#Case I: Removing duplicates + splitting in latitudes (data with depth)

e <- 1
l <- 0
test <- c()

#splitting by latitudinal bands every degree and filtering out duplicates
rm(i)
for(i in 56:84){
  
  if (i < 61){
    for (j in 1:4) {
      l <- letters[j]
      test[e] <- paste0("l",i,l)
      e = e +1      }   }
  
  else {
    l <- letters[j]
    test[e] <- paste0("l",i)
    e = e +1     
  } 
}


testNoDups <- list()
for (b in 1:length(namesTimeSeries)){
  f <- 1
  k <- 1
  m <- 1
  p <- 1
  init <- 55.95
  
  i <- 1
  mn <- 0
  mx <- 500
  
  for (i in 1:length(test)){
    
    mn <- 0
    mx <- 500
    
    x <- timeSeries[[b]]
    #splitting in NA and no NA parts to be able to perform the masking
    x_noNA <- x %>% filter(!is.na(x$decimalLongitude) | !is.na(x$decimalLatitude))
    x_NA <- x %>% filter(is.na(x$decimalLongitude) | is.na(x$decimalLatitude))
    
    if (i < 21) {
      x <- x_noNA %>% filter(decimalLatitude>= (init + 0.05) & decimalLatitude< (init + (0.05 + 0.25)))
      assign(test[i], x)
      init <- init + 0.25      
    }
    
    if (i > 20 & i < 44) {
      x <- x_noNA %>% filter(decimalLatitude>= (init + 0.05) & decimalLatitude< (init + (0.05 + 1.00)))
      assign(test[i], x)
      init <- init + 1.00      }  
    
    if (i == 44) {
      x <- x_noNA %>% filter(decimalLatitude>= (init + 0.05) & decimalLatitude<= (init + (0.05 + 1.00)))
      assign(test[i], x)
      init <- init + 1.00      }
    
    g = x %>% filter(taxonRank == "FORM" | taxonRank == "Species" | taxonRank == "SPECIES" | taxonRank == "SUBSPECIES" | taxonRank == "UNRANKED" | taxonRank == "VARIETY" | is.na(taxonRank))
    assign(gsub(" ","", paste(test[i],"_sp")),g)
    
    df <- g
    df2 <- g
    k <- k + 1
    mylist <- list()
    link <- data.frame()
    
    while(k > 0){
      x <- print(df[duplicated(df[,c("scientificName", "decimalLatitude", "decimalLongitude", "depth", "day", "month", "year")]) & 
                      !duplicated(df[,c("scientificName", "decimalLatitude", "decimalLongitude", "depth", "day", "month", "year", "database")]),])
      # df = df[!(duplicated(df$decimalLatitude) & duplicated(df$decimalLongitude) & duplicated(df$depth) & duplicated(df$day) & duplicated(df$month) & duplicated(df$year) & duplicated(df$scientificName) & !duplicated (df$database)),]
      df <- df[!(duplicated(df[,c("scientificName", "decimalLatitude", "decimalLongitude", "depth", "day", "month", "year")]) & 
                   !duplicated(df[,c("scientificName", "decimalLatitude", "decimalLongitude", "depth", "day", "month", "year", "database")])),]
      k <- nrow(x)
      mylist[[f]] <- x
      link <- do.call("rbind",mylist)
      f <- (nrow(link)) + 100
      assign(paste0(test[i],"_sp_dups"), link)     
    }
    
    if(i == 1){ nodups <- as.data.frame(df)   }
    if(i > 1){  nodups <- rbind(nodups,as.data.frame(df))     }
    if(i == 44){  
      #Generate the dataset with no duplicates   
      nodups <- rbind(nodups,x_NA)
      assign(paste0(namesTimeSeries[b],"_nodups"), nodups)
      testNoDups[[b]] <- nodups
    }   
  }  
}
#These are the keeping objects
namesNodups <- gsub("^([a-zA-Z]{15}\\D{1}\\d{4}\\D{1}\\d{4})$", "\\1\\_nodups", namesTimeSeries)
names(testNoDups) <- namesNodups

#Exploring data
count <- c()
rm(i,x)
for(i in 1:length(namesNodups)){
  
  x <- testNoDups[[i]]
  
  if(i == 1){
    timeSeriesPB_nodups <- x
    count <- nrow(x)   }
  
  if(i > 1){
    timeSeriesPB_nodups <- rbind(timeSeriesPB_nodups,x)
    count <- count + nrow(x)   } }

#Case II: Time series with all data (depth and no-depth) + removal of duplicates

rm(i,x,y)
lenghtsts <- c()
for(i in 1:length(tiffDepths)){
  x <- tiffDepths[[i]]
  if (i == 1){
    y <- x
    lenghtsts[i] <- nrow(x)    }
  
  if (i > 1){
    y <- rbind(y, x)
    lenghtsts[i] <- nrow(x)    }
  
  timeSeriesAll <- y 
  sum(lenghtsts)  }

#Running the algorithm to remove duplicates
ini <- 1890
fin <- 1900
namesTimeSeriesAll <- c()
timeSeriesAllList <- list()

for(i in 1:14){
  
  x <- timeSeriesAll
  
  if(i == 1){
    y <- x %>% filter(year >= 1876 & year < fin) # Removing pre-1876 occurrences
    sum <- nrow(y)
  }
  
  if(i > 1 & i < 14){
    y <- x %>% filter(year >= ini & year < fin)
    sum <- sum + nrow(y)
  }
  
  if(i == 14){
    y <- x %>% filter(year >= ini)
    sum <- sum + nrow(y)
  }
  
  
  
  if(i == 1){
    assign(paste0("alltseries_1876_",fin), y)
    namesTimeSeriesAll[i] <- paste0("alltseries_1876_",fin)
    timeSeriesAllList[[i]] <- y
  } else if(i == 14){
    assign(paste0("alltseries_",ini,"_2024"), y)
    namesTimeSeriesAll[i] <- paste0("alltseries_",ini,"_2024")
    timeSeriesAllList[[i]] <- y
  } else {
    assign(paste0("alltseries_",ini,"_",fin), y)
    namesTimeSeriesAll[i] <- paste0("alltseries_",ini,"_",fin)
    timeSeriesAllList[[i]] <- y
  }
  
  print(ini)
  print(fin)
  ini <- ini + 10
  fin <- fin + 10
  
}

names(timeSeriesAllList) <- namesTimeSeriesAll
rm(i,x,y,sum)


#Case III: Removing duplicates for one single input
#Removing duplicates + splitting in latitudes 

e <- 1
l <- 0
timeSeriesAllNoDups <- list()

for (b in 1:length(timeSeriesAllList)){
  f <- 1
  k <- 1
  m <- 1
  p <- 1
  init <- 55.95
  
  i <- 1
  mn <- 0
  mx <- 500
  
  for (i in 1:length(test)){
    
    mn <- 0
    mx <- 500
    
    x <- timeSeriesAllList[[b]]
    #splitting in NA and no NA parts
    x_noNA <- x %>% filter(!is.na(x$decimalLongitude) | !is.na(x$decimalLatitude))
    x_NA <- x %>% filter(is.na(x$decimalLongitude) | is.na(x$decimalLatitude))
    
    if (i < 21) {
      x <- x_noNA %>% filter(decimalLatitude>= (init + 0.05) & decimalLatitude< (init + (0.05 + 0.25)))
      assign(test[i], x)
      init <- init + 0.25
    }
    
    if (i > 20 & i < 44) {
      x <- x_noNA %>% filter(decimalLatitude>= (init + 0.05) & decimalLatitude< (init + (0.05 + 1.00)))
      assign(test[i], x)
      init <- init + 1.00
    }  
    
    if (i == 44) {
      x <- x_noNA %>% filter(decimalLatitude>= (init + 0.05) & decimalLatitude<= (init + (0.05 + 1.00)))
      assign(test[i], x)
      init <- init + 1.00
    }
    
    g = x %>% filter(taxonRank == "FORM" | taxonRank == "Species" | taxonRank == "SPECIES" | taxonRank == "SUBSPECIES" | taxonRank == "UNRANKED" | taxonRank == "VARIETY" | is.na(taxonRank))
    assign(gsub(" ","", paste(test[i],"_sp")),g)
    
    df <- g
    df2 <- g
    k <- k + 1
    mylist <- list()
    link <- data.frame()
    
    while(k > 0){
      x <- print(df[duplicated(df[,c("scientificName", "decimalLatitude", "decimalLongitude", "depth", "day", "month", "year")]) & 
                      !duplicated(df[,c("scientificName", "decimalLatitude", "decimalLongitude", "depth", "day", "month", "year", "database")]),])
      # df = df[!(duplicated(df$decimalLatitude) & duplicated(df$decimalLongitude) & duplicated(df$depth) & duplicated(df$day) & duplicated(df$month) & duplicated(df$year) & duplicated(df$scientificName) & !duplicated (df$database)),]
      df <- df[!(duplicated(df[,c("scientificName", "decimalLatitude", "decimalLongitude", "depth", "day", "month", "year")]) & 
                   !duplicated(df[,c("scientificName", "decimalLatitude", "decimalLongitude", "depth", "day", "month", "year", "database")])),]
      k <- nrow(x)
      mylist[[f]] <- x
      link <- do.call("rbind",mylist)
      f <- (nrow(link)) + 100
      assign(paste0(test[i],"_sp_dups"), link)   
    }
    
    if(i == 1){ nodups <- as.data.frame(df)   }
    
    if(i > 1){   nodups <- rbind(nodups,as.data.frame(df))     }
    
    if(i == 44){
      #Generate the dataset with no duplicates   
      nodups <- rbind(nodups,x_NA)
      assign(paste0(namesTimeSeriesAll[b],"_nodups"), nodups)  
    }   
    
  } 
  
  timeSeriesAllNoDups[[b]] <- nodups
}

rm(all)
rm(a,e,f,k,h,l,m,p,z)
rm(i,b) 

#These are the keeping objects

namesNodupsAll <- gsub("^([a-zA-Z]{10}\\D{1}\\d{4}\\D{1}\\d{4})$", "\\1\\_nodups", namesTimeSeriesAll)
names(timeSeriesAllNoDups) <- namesNodupsAll

#unifying the last result in a single dataset
count <- c()
rm(i,x)
for(i in 1:length(timeSeriesAllNoDups)){
  
  x <- timeSeriesAllNoDups[[i]]
  
  if(i == 1){
    timeSeriesAll_nodups <- x
    count <- nrow(x)
  }
  
  if(i > 1){
    timeSeriesAll_nodups <- rbind(timeSeriesAll_nodups,x)
    count <- count + nrow(x)
  }
}

timeSeriesAll_nodups$depthAccuracy <- as.numeric(timeSeriesAll_nodups$depthAccuracy)

#comparing that results are the same either splitting the dataset in parts or not
timeSeriesPB_nodups <- timeSeriesPB_nodups[!duplicated(timeSeriesPB_nodups$id),]
timeSeriesAll_nodups <- timeSeriesAll_nodups[!duplicated(timeSeriesAll_nodups$id),]
nrow(timeSeriesAll_nodups)
nrow(timeSeriesPB_nodups)
timeSeries <- timeSeriesAll_nodups
timeSeriesPB <- timeSeriesPB_nodups
rm(a,i,x)

#unifying data
timeSeriesJoint <- left_join(timeSeries,timeSeriesPB, by = "id") 
names(timeSeriesJoint)
timeSeriesJoint <- timeSeriesJoint[,c(1:30,60)]
names(timeSeriesJoint) <- gsub(".x","",names(timeSeriesJoint))  
names(timeSeriesJoint)

setA <- timeSeriesJoint %>% filter(matchContour == "shallowFromDeepSet" & !is.na(tiffmatch)) 
setA$tiffmatch <- "shallowFromDeepSet"
setB <- timeSeriesJoint %>% filter(matchContour != "shallowFromDeepSet" & !is.na(tiffmatch)) 
setC <- timeSeriesJoint %>% filter(is.na(tiffmatch))
setC$tiffmatch <- "notiff"
timeSeriesJoint <- rbind(setA,setB,setC)
rm(setA,setB,setC)

unique(timeSeriesJoint$tiffmatch)


#Rectifying outliers in ArcGIS
#Prepare the dataset
rm(i,x,y,sum)
ini <- 1890
fin <- 1900
namesTimeSeries <- c()
timeSeriesData <- list()

for(i in 1:14){
  
  x <- timeSeriesJoint
  
  if(i == 1){
    y <- x %>% filter(year >= 1876 & year < fin) # Removing pre-1876 occurrences
    sum <- nrow(y)    }
  
  if(i > 1 & i < 14){
    y <- x %>% filter(year >= ini & year < fin)
    sum <- sum + nrow(y)    }
  
  if(i == 14){
    y <- x %>% filter(year >= ini)
    sum <- sum + nrow(y)     }
  
  
  
  if(i == 1){
    assign(paste0("alltseries_1876_",fin), y)
    namesTimeSeries[i] <- paste0("alltseries_1876_",fin)
    timeSeriesData[[i]] <- y
  } else if(i == 14) {
    assign(paste0("alltseries_",ini,"_2024"), y)
    namesTimeSeries[i] <- paste0("alltseries_",ini,"_2024")   
    timeSeriesData[[i]] <- y  
  } else {
    assign(paste0("alltseries_",ini,"_",fin), y)
    namesTimeSeries[i] <- paste0("alltseries_",ini,"_",fin)
    timeSeriesData[[i]] <- y
  }
  
  print(ini)
  print(fin)
  ini <- ini + 10
  fin <- fin + 10  
}

namesTimeSeries
names(timeSeriesData) <- namesTimeSeries
rm(i,x,y,sum)

#Rectification in ArcGIS  
rm(i,x)
for(i in 1:length(timeSeriesData)){
  x <- timeSeriesData[[i]]
  st_write(x,paste0("data/timeSeries/", namesTimeSeries[i],".shp"), append = FALSE)  
}

#Removing geographical and depth outliers
names(timeSeriesJoint)
timeSeriesJointB <- timeSeriesJoint %>% filter((XCoord == -27 & YCoord < 64.858) | (XCoord == 38 & YCoord < 68.386) | YCoord == 56)
timeSeriesJoint <- anti_join(timeSeriesJoint, timeSeriesJointB)
timeSeriesJoint <- timeSeriesJoint %>% filter(depth <= 5569 | is.na(depth))
saveRDS(timeSeriesJoint, "data/timeSeriesJoint.RDS")

##End script IVa.
