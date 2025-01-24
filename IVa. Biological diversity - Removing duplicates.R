#IVa. Biological diversity - Removing duplicates 
setwd("//workingdirectory") #setting up the working directory.   

#Exploring data structure
rm(i,x,y)
lenghtsts <- c()
for(i in 1:length(namesPlanktonBenthos)){
  x <- get(namesPlanktonBenthos[i])
  if (i == 1){
    y <- x
    lenghtsts[i] <- nrow(x)   }
  
  if (i > 1){
    y <- rbind(y, x)
    lenghtsts[i] <- nrow(x)   }
  
  assign("timeSeries_planktonBenthos", y) 
  sum(lenghtsts)  }

#Splitting data in decades
rm(i,x,y,sum)
ini <- 1890
fin <- 1900
namesTimeSeries <- c()

for(i in 1:14){
  
  x <- timeSeries_planktonBenthos
  
  if(i == 1){
    y <- x %>% filter(year >= 1876 & year < fin) # Removing pre-1876 occurrences
    sum <- nrow(y)  }
  
  if(i > 1 & i < 14){
    y <- x %>% filter(year >= ini & year < fin)
    sum <- sum + nrow(y)  }
  
  if(i == 14){
    y <- x %>% filter(year >= ini)
    sum <- sum + nrow(y)  }
  
  assign(gsub(" ","",paste("planktonBenthos_",ini,"_",fin)), y)
  namesTimeSeries[i] <- gsub(" ","",paste("planktonBenthos_",ini,"_",fin))
  
  if(i == 1){
    assign(gsub(" ","",paste("planktonBenthos_1876_",fin)), y)
    namesTimeSeries[i] <- gsub(" ","",paste("planktonBenthos_1876_",fin)) }
  
  if(i == 14){
    assign(gsub(" ","",paste("planktonBenthos_",ini,"_2024")), y)
    namesTimeSeries[i] <- gsub(" ","",paste("planktonBenthos_",ini,"_2024"))  }
  
  print(ini)
  print(fin)
  ini <- ini + 10
  fin <- fin + 10  }

namesTimeSeries
rm(i,x,y,sum)

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
      test[e] <- gsub(" ","", paste("l",i,l))
      e = e +1      }   }
  
  else {
    l <- letters[j]
    test[e] <- gsub(" ","", paste("l",i))
    e = e +1     } }

rm(b,x)
b <- 1
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
    
    x <- get(namesTimeSeries[b])
    #splitting in NA and no NA parts to be able to perform the masking
    x_noNA <- x %>% filter(!is.na(x$decimalLongitude) | !is.na(x$decimalLatitude))
    x_NA <- x %>% filter(is.na(x$decimalLongitude) | is.na(x$decimalLatitude))
    
    if (i < 21) {
      x <- x_noNA %>% filter(decimalLatitude>= (init + 0.05) & decimalLatitude< (init + (0.05 + 0.25)))
      assign(test[i], x)
      init <- init + 0.25      }
    
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
      x <- print(df %>% filter(duplicated(df$decimalLatitude) & duplicated(df$decimalLongitude) & duplicated(df$depth) & duplicated(df$day) & duplicated(df$month) & duplicated(df$year) & duplicated(df$scientificName) & !duplicated (df$database)))
      df = df[!(duplicated(df$decimalLatitude) & duplicated(df$decimalLongitude) & duplicated(df$depth) & duplicated(df$day) & duplicated(df$month) & duplicated(df$year) & duplicated(df$scientificName) & !duplicated (df$database)),]
      k <- nrow(x)
      mylist[[f]] <- x
      link <- do.call("rbind",mylist)
      f <- (nrow(link)) + 100
      assign(gsub(" ","",paste(test[i],"_sp_dups")), link)     }
    
    if(i == 1){ nodups <- as.data.frame(df)   }
    if(i > 1){  nodups <- rbind(nodups,as.data.frame(df))     }
    if(i == 44){  
      #Generate the dataset with no duplicates   
      nodups <- rbind(nodups,x_NA)
      assign(gsub(" ","",paste(namesTimeSeries[b],"_nodups")), nodups)     }   }  }

rm(all)
rm(a,e,f,k,h,l,m,p,z)
rm(i,b) 

#These are the keeping objects
namesNodups <- gsub("^([a-zA-Z]{15}\\D{1}\\d{4}\\D{1}\\d{4})$", "\\1\\_nodups", namesTimeSeries)

#Exploring data
count <- c()
rm(i,x)
for(i in 1:length(namesNodups)){
  
  x <- get(namesNodups[i])
  
  if(i == 1){
    timeSeriesPB_nodups <- x
    count <- nrow(x)   }
  
  if(i > 1){
    timeSeriesPB_nodups <- rbind(timeSeriesPB_nodups,x)
    count <- count + nrow(x)   } }

#Case II: Time series with all data (depth and no-depth) + removal of duplicates

rm(i,x,y)
lenghtsts <- c()
for(i in 1:length(namesTiff)){
  x <- get(namesTiff[i])
  if (i == 1){
    y <- x
    lenghtsts[i] <- nrow(x)    }
  
  if (i > 1){
    y <- rbind(y, x)
    lenghtsts[i] <- nrow(x)    }
  
  assign("timeSeriesAll", y) 
  sum(lenghtsts)  }

#Running the algorithm to remove duplicates
rm(i,x,y,sum)
ini <- 1890
fin <- 1900
namesTimeSeriesAll <- c()

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
  
  assign(gsub(" ","",paste("alltseries_",ini,"_",fin)), y)
  namesTimeSeriesAll[i] <- gsub(" ","",paste("alltseries_",ini,"_",fin))
  
  if(i == 1){
    assign(gsub(" ","",paste("alltseries_1876_",fin)), y)
    namesTimeSeriesAll[i] <- gsub(" ","",paste("alltseries_1876_",fin))
  }
  
  if(i == 14){
    assign(gsub(" ","",paste("alltseries_",ini,"_2024")), y)
    namesTimeSeriesAll[i] <- gsub(" ","",paste("alltseries_",ini,"_2024"))
  }
  
  print(ini)
  print(fin)
  ini <- ini + 10
  fin <- fin + 10
  
}

namesTimeSeriesAll
rm(i,x,y,sum)


#Case III: Removing duplicates for one single input
#Removing duplicates + splitting in latitudes 

e <- 1
l <- 0
test <- c()

#splitting by latitudinal bands every degree and filtering out duplicates
rm(i)
for(i in 56:84){
  
  if (i < 61){
    for (j in 1:4) {
      l <- letters[j]
      test[e] <- gsub(" ","", paste("l",i,l))
      e = e +1
    }
  }
  
  else {
    l <- letters[j]
    test[e] <- gsub(" ","", paste("l",i))
    e = e +1
  }
}

rm(b,x)
b <- 1
for (b in 1:length(namesTimeSeriesAll)){
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
    
    x <- get(namesTimeSeriesAll[b])
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
      x <- print(df %>% filter(duplicated(df$decimalLatitude) & duplicated(df$decimalLongitude) & duplicated(df$depth) & duplicated(df$day) & duplicated(df$month) & duplicated(df$year) & duplicated(df$scientificName) & !duplicated (df$database)))
      df = df[!(duplicated(df$decimalLatitude) & duplicated(df$decimalLongitude) & duplicated(df$depth) & duplicated(df$day) & duplicated(df$month) & duplicated(df$year) & duplicated(df$scientificName) & !duplicated (df$database)),]
      k <- nrow(x)
      mylist[[f]] <- x
      link <- do.call("rbind",mylist)
      f <- (nrow(link)) + 100
      assign(gsub(" ","",paste(test[i],"_sp_dups")), link)
    }
    
    if(i == 1){ nodups <- as.data.frame(df)   }
    
    if(i > 1){   nodups <- rbind(nodups,as.data.frame(df))     }
    
    if(i == 44){
      #Generate the dataset with no duplicates   
      nodups <- rbind(nodups,x_NA)
      assign(gsub(" ","",paste(namesTimeSeriesAll[b],"_nodups")), nodups)     }   }   }

rm(all)
rm(a,e,f,k,h,l,m,p,z)
rm(i,b) 

#These are the keeping objects

namesNodupsAll <- gsub("^([a-zA-Z]{10}\\D{1}\\d{4}\\D{1}\\d{4})$", "\\1\\_nodups", namesTimeSeriesAll)
namesNodupsAll

#unifying the last result in a single dataset
count <- c()
rm(i,x)
for(i in 1:length(namesNodupsAll)){
  
  x <- get(namesNodupsAll[i])
  
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
  
  assign(gsub(" ","",paste("alltseries_",ini,"_",fin)), y)
  namesTimeSeries[i] <- gsub(" ","",paste("alltseries_",ini,"_",fin))
  
  if(i == 1){
    assign(gsub(" ","",paste("alltseries_1876_",fin)), y)
    namesTimeSeries[i] <- gsub(" ","",paste("alltseries_1876_",fin))   }
  
  if(i == 14){
    assign(gsub(" ","",paste("alltseries_",ini,"_2024")), y)
    namesTimeSeries[i] <- gsub(" ","",paste("alltseries_",ini,"_2024"))    }
  
  print(ini)
  print(fin)
  ini <- ini + 10
  fin <- fin + 10  }

namesTimeSeries
rm(i,x,y,sum)

#Rectification in ArcGIS  
rm(i,x)
for(i in 1:length(namesTimeSeries)){
  x <- get(namesTimeSeries[i])
  st_write(x,gsub(" ","", paste(namesTimeSeries[i],".shp")))  }

#Removing geographical and depth outliers
names(timeSeriesJoint)
timeSeriesJointB <- timeSeriesJoint %>% filter((XCoord == -27 & YCoord < 64.858) | (XCoord == 38 & YCoord < 68.386) | YCoord == 56)
timeSeriesJoint <- anti_join(timeSeriesJoint, timeSeriesJointB)
timeSeriesJoint <- timeSeriesJoint %>% filter(depth <= 5569 | is.na(depth))

##End script IVa.
