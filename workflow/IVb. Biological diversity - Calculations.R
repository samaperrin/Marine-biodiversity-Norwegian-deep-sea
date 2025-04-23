#IVa. Biological diversity - Calculations 

#Splitting data into decades

library(dplyr)

timeSeriesJoint <- readRDS("data/timeSeriesJoint.RDS")
ini <- 1890
fin <- 1900

timeSeries <- list()
namesTimeSeries <- c()

for (i in 1:14) {
  
  x <- timeSeriesJoint
  
  if (i == 1){
    y <- x[x$year >= 1876 & x$year < fin,] # Removing pre-1876 occurrences
    sum <- nrow(y)
  } else if (i > 1 & i < 14){
    y <- x[x$year >= ini & x$year < fin,]
    sum <- sum + nrow(y)
  } else if (i == 14) {
    y <- x[x$year >= ini,]
    sum <- sum + nrow(y)
  }
  
  if(i == 1){
    assign(paste0("alltseries_1876_",fin), y)
    timeSeries[[i]] <- y
    namesTimeSeries[i] <- paste0("alltseries_1876_",fin)
  } else if(i == 14){
    assign(paste0("alltseries_",ini,"_2024"), y)
    timeSeries[[i]] <- y
    namesTimeSeries[i] <- paste0("alltseries_",ini,"_2024")
  } else {
    assign(paste0("alltseries_",ini,"_",fin), y)
    timeSeries[[i]] <- y
    namesTimeSeries[i] <- paste0("alltseries_",ini,"_",fin)
  }
  
  print(ini)
  print(fin)
  ini <- ini + 10
  fin <- fin + 10
  
}

names(timeSeries) <- namesTimeSeries
rm(i,x,y,sum)


#Splitting data into shallow and deep datasets and calculating species richness, abundances and occurrences
guide <- c("shallow","deep")
rm(i,x,b,y,a)
srichness_ts <- c()
abundances_ts <- c()
occurrences_ts <- c()
namesStats <- c()

namesShallow <- c()
namesDeep <- c()
shallowData <- list()
deepData <- list()

namesNoDups <- paste0(namesTimeSeries, "_noDups")
statsNoDups <- list()

for(i in 1:length(timeSeries)){
  
  x <- timeSeries[[i]]
  
  shallow <- x %>% filter(depth < 500 | matchContour == "matchShallow") 
  print(unique(x$matchContour))
  assign(paste0(namesNoDups[i],"_shallow"),shallow)
  namesShallow[i] <- paste0(namesNoDups[i],"_shallow")
  shallowData[[i]] <- shallow
  
  deep <- x %>% filter(depth >= 500 | matchContour == "matchDeep") 
  print(unique(x$matchContour))
  assign(paste0(namesNoDups[i],"_deep"),deep)
  namesDeep[i] <- paste0(namesNoDups[i],"_deep")
  deepData[[i]] <- deep
  
  for(b in 1:length(guide)){
    
    y <- get(guide[b])
    init <- 56
    
    for (a in 1:length(56:84)){
      
      if (a < 29) {
        z <- y %>% filter(decimalLatitude>= init & decimalLatitude< (init+1))
        init <- init + 1
      }
      
      if (a == 29) {
        z <- y %>% filter(decimalLatitude>= init & decimalLatitude<= (init+1))
        init <- init + 1
      }
      
      #General stats 
      sp_list_abundances <- z %>% arrange(scientificName) %>% group_by(scientificName, kingdom, class, family) %>% summarise(abundance = sum(individualCount)) %>% filter(grepl("[a-zA-Z]{1,25}\\s{1}[a-z]{2,25}", scientificName))
      sp_list <- sp_list_abundances[c("scientificName","abundance")] %>% arrange(scientificName) %>% group_by(scientificName) %>% summarise(abundance = sum(abundance))
      
      #quantification of species richness
      srichness_ts[a] <- nrow(sp_list)
      
      #quantification of abundances
      abundances_ts[a] <- sum(sp_list$abundance, na.rm = TRUE)
      
      #quantification of occurrences
      occurrences_ts[a] <- nrow(z)     
    }
    
    if(b == 1){
      srichness_sd <- srichness_ts
      abundances_sd <- abundances_ts
      occurrences_sd <- occurrences_ts      
    } else if (b > 1){
      srichness_sd <- cbind(srichness_sd,srichness_ts)
      abundances_sd <- cbind(abundances_sd,abundances_ts)
      occurrences_sd <- cbind(occurrences_sd,occurrences_ts)      
    }  
  }
  
  stats_ts <- as.data.frame(cbind(srichness_sd, abundances_sd, occurrences_sd))  
  names(stats_ts) <- c("shallowS", "deepS", "shallowAb", "deepAb", "shallowOc", "deepOc")
  stats_ts$shallowRatios <- stats_ts$shallowOc/nrow(timeSeriesJoint)
  stats_ts$deepRatios <- stats_ts$deepOc/nrow(timeSeriesJoint)
  stats_ts$shallowCumuS <- cumsum(stats_ts$shallowS)
  stats_ts$deepCumuS <- cumsum(stats_ts$deepS)
  stats_ts$shallowCumuAb <- cumsum(stats_ts$shallowAb)
  stats_ts$deepCumuAb <- cumsum(stats_ts$deepAb)
  stats_ts$shallowCumuOc <- cumsum(stats_ts$shallowOc)
  stats_ts$deepCumuOc <- cumsum(stats_ts$deepOc)
  rownames(stats_ts) <- c(56:84)
  
  assign(gsub(" ","",paste(namesNoDups[i],"_stats")), stats_ts)
  namesStats[i] <- gsub(" ","",paste(namesNoDups[i],"_stats"))
  statsNoDups[[i]] <- stats_ts
}

names(deepData) <- namesDeep
names(shallowData) <- namesShallow
names(statsNoDups) <- namesStats

#Calculating the overall ratio (See figure 6a in the manuscript) for each decade
ratiosShallow <- c()
ratiosDeep <- c()
rm(i,x)
for(i in 1:length(statsNoDups)){
  x <- statsNoDups[[i]]
  
  if(i == 1){
    shallowS <- x$shallowS
    deepS <- x$deepS
    shallowAb <- x$shallowAb
    deepAb <- x$deepAb
    shallowOc <- x$shallowOc
    deepOc <- x$deepOc
  }
  
  if(i > 1){
    shallowS <- shallowS + x$shallowS
    deepS <- deepS + x$deepS
    shallowAb <- shallowAb + x$shallowAb
    deepAb <- deepAb + x$deepAb
    shallowOc <- shallowOc + x$shallowOc
    deepOc <- deepOc + x$deepOc
  }
  
  ratiosShallow[i] <- as.numeric(sum(x$shallowOc)/nrow(timeSeriesJoint))
  ratiosDeep[i] <- as.numeric(sum(x$deepOc)/nrow(timeSeriesJoint))
  stats_tsall <- as.data.frame(cbind(shallowS, deepS, shallowAb, deepAb, shallowOc, deepOc))
}

#Extracting the planktonic and benthic datasets
plankton <- timeSeriesJoint %>% filter(tiffmatch == "tiffPlankton" & matchContour != "shallowFromDeepSet") 
benthos <- timeSeriesJoint %>% filter(tiffmatch == "tiffBenthos" & matchContour != "shallowFromDeepSet") 

planktonShallow <- plankton %>% filter(depth < 500 | matchContour == "matchShallow")
planktonDeep <- plankton %>% filter(depth >= 500 | matchContour == "matchDeep")

benthosShallow <- benthos %>% filter(depth < 500 | matchContour == "matchShallow")
benthosDeep <- benthos %>% filter(depth >= 500 | matchContour == "matchDeep")

shallow <- rbind(planktonShallow,benthosShallow)
unique(shallow$matchContour)
unique(shallow$tiffmatch)
deep <- rbind(planktonDeep,benthosDeep) 
unique(deep$matchContour)
unique(deep$tiffmatch)
pb <- rbind(shallow,deep)

#verifying subtotals
nrow(plankton) + nrow(benthos) 
nrow(shallow) + nrow(deep) 
nrow(plankton)
nrow(benthos)
nrow(shallow) 
nrow(deep) 

#shallow and deep oceanic provinces
setA <- shallow %>% filter(depth < 200)
setB <- shallow %>% filter(depth >= 200 & depth < 500)
setA$pbProvince <- "epipelagic"
setB$pbProvince <- "mesopelagic"
shallow <- rbind(setA,setB) 

setA <- deep %>% filter(depth >= 500 & depth < 1000)
setB <- deep %>% filter(depth >= 1000 & depth < 4000)
setC <- deep %>% filter(depth >= 4000 & depth <= 6000)
setA$pbProvince <- "mesopelagic"
setB$pbProvince <- "bathypelagic"
setC$pbProvince <- "abyssopelagic"
deep <- rbind(setA,setB,setC) 

rm(setA,setB,setC)
unique(shallow$tiffmatch)  
unique(deep$tiffmatch)  

###Counting occurrences in provinces
namespbProvince <- c("epipelagic","mesopelagic","bathypelagic","abyssopelagic")

unique(shallow$pbProvince)
unique(deep$pbProvince)

rm(i)
pbProvinceCurveS <- c()
pbProvinceCurveD <- c()

for(i in namespbProvince){
  pbProvinceCurveS[i] <- nrow(shallow %>% filter(pbProvince == i) %>% filter(depth < 500))
  pbProvinceCurveD[i] <- nrow(deep %>% filter(pbProvince == i & depth >= 500))  }

tableprov <- cbind(pbProvinceCurveS, pbProvinceCurveD)
View(tableprov)  

#splitting in shallow and deep datasets to get the planktonic and benthic subdatasets in each
guide <- c("shallow", "deep")
rm(i,x,y,sum,a)
namesTimeSeries <- c()

for(a in 1:2){
  x <- get(guide[a])
  
  ini <- 1890
  fin <- 1900
  for(i in 1:14){
    
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
    
    if(i != 1 | i != 14){
      assign(gsub(" ","",paste(guide[a],"_",ini,"_",fin)), y)
      namesTimeSeries[i] <- gsub(" ","",paste(guide[a],"_",ini,"_",fin))
    }
    
    if(i == 1){
      assign(gsub(" ","",paste(guide[a],"_","1876_",fin)), y)
      namesTimeSeries[i] <- gsub(" ","",paste(guide[a],"_","1876_",fin))
    }
    
    if(i == 14){
      assign(gsub(" ","",paste(guide[a],"_",ini,"_2024")), y)
      namesTimeSeries[i] <- gsub(" ","",paste(guide[a],"_",ini,"_2024"))
    }
    
    print(ini)
    print(fin)
    ini <- ini + 10
    fin <- fin + 10
  }
  
  assign(gsub(" ","",paste("namests_",guide[a])), namesTimeSeries)
}

rm(i,x,y,sum)

##for shallow
pShallow <- c()
bShallow <- c()
namesShallowPL <- c()
namesShallowBE <- c()
rm(i,x)
for(i in 1:length(namests_shallow)){
  x <- get(namests_shallow[i])
  print(unique(x$tiffmatch))
  print(unique(x$matchContour))
  
  pla <- x %>% filter(tiffmatch == "tiffPlankton")
  assign(gsub(" ","",paste(namests_shallow[i],"_plankton")), pla)
  namesShallowPL[i] <- gsub(" ","",paste(namests_shallow[i],"_plankton"))
  pShallow[i] <- nrow(pla)
  
  ben <- x %>% filter(tiffmatch == "tiffBenthos")
  assign(gsub(" ","",paste(namests_shallow[i],"_benthos")), ben)
  namesShallowBE[i] <- gsub(" ","",paste(namests_shallow[i],"_benthos"))
  bShallow[i] <- nrow(ben)
}

##for deep 
pDeep <- c()
bDeep <- c()
namesDeepPL <- c()
namesDeepBE <- c()
rm(i,x)
for(i in 1:length(namests_deep)){
  x <- get(namests_deep[i])
  print(unique(x$tiffmatch))
  print(unique(x$matchContour))
  
  pla <- x %>% filter(tiffmatch == "tiffPlankton")
  assign(gsub(" ","",paste(namests_deep[i],"_plankton")), pla)
  namesDeepPL[i] <- gsub(" ","",paste(namests_deep[i],"_plankton"))
  pDeep[i] <- nrow(pla)
  
  ben <- x %>% filter(tiffmatch == "tiffBenthos")
  assign(gsub(" ","",paste(namests_deep[i],"_benthos")), ben)
  namesDeepBE[i] <- gsub(" ","",paste(namests_deep[i],"_benthos"))
  bDeep[i] <- nrow(ben)
}

#Species richness, abundances and occurrences for the depth zones (See figure 6c in the manuscript)
rm(x,i,a,y,b,mn,mx)      
guide <- c("shallow", "deep")

namesDepthbands <- c()
srichness_dband <- c()
abundances_dband <- c()
occurrences_dband <- c()

for(b in 1:14){
  x <- get(namests_deep[b])
  mn <- 500
  mx <- 1000
  for (a in 1:11){
    y <- x %>% filter(depth >= mn & depth < mx) 
    
    #General stats
    sp_list_abundances <- y %>% arrange(scientificName) %>% group_by(scientificName, kingdom, class, family) %>% summarise(abundance = sum(individualCount)) %>% filter(grepl("[a-zA-Z]{1,25}\\s{1}[a-z]{2,25}", scientificName))
    sp_list <- sp_list_abundances[c("scientificName","abundance")] %>% arrange(scientificName) %>% group_by(scientificName) %>% summarise(abundance = sum(abundance))
    
    #quantification of species richness
    srichness_dband[a] <- nrow(sp_list)
    
    #quantification of abundances
    abundances_dband[a] <- sum(sp_list$abundance, na.rm = TRUE)
    
    #quantification of occurrences
    occurrences_dband[a] <- nrow(y)
    
    mn <- mn+500
    mx <- mx+500  
  }
  
  if(b == 1){
    srichness_db <- srichness_dband
    abundances_db <- abundances_dband
    occurrences_db <- occurrences_dband  
  }
  
  if(b > 1){
    srichness_db <- as.data.frame(cbind(srichness_db,srichness_dband))
    abundances_db <- as.data.frame(cbind(abundances_db,abundances_dband))
    occurrences_db <- as.data.frame(cbind(occurrences_db,occurrences_dband))
  }
  
  names(srichness_db)[b] <- gsub(" ","",paste(namests_deep[b]))
  names(abundances_db)[b] <- gsub(" ","",paste(namests_deep[b]))
  names(occurrences_db)[b] <- gsub(" ","",paste(namests_deep[b]))
}

names(srichness_db)[1] <- "deep_1876_1900"
rownames(srichness_db) <- (1:11)
names(abundances_db)[1] <- "deep_1876_1900"
rownames(abundances_db) <- (1:11)
names(occurrences_db)[1] <- "deep_1876_1900"
rownames(occurrences_db) <- (1:11)

View(srichness_db)
#Shallow is one dataset and depth zone in itself,  species richness

nrow(timeSeriesJoint %>% filter(!is.na(individualCount)))
nrow(timeSeriesJoint %>% filter(database == "gbif"))
unique(timeSeriesJoint$matchContour)

##End script IVb.         

