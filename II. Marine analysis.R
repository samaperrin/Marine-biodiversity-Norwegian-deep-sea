#II. Marine analysis
library(ggplot2)
library(rnaturalearth)
library(sf)
library(dplyr)
library(stringr)
#setwd("//workingdirectory") #setting up the working directory.    

# Create dataset. Start by loading Laura's environment.
load("data/obisemodnetnnaexp.RData")

# Names list
all24 <- c("gbifa_1876to1899","gbifa_1900to1909","gbifa_1910to1919","gbifa_1920to1929","gbifa_1930to1939",
           "gbifa_1940to1949","gbifa_1950to1959","gbifa_1960to1969","gbifa_1970to1979", "gbifa_1980to1989", 
           "gbifa_1990to1999","gbifa_2000to2009","gbifa_2010to2019","gbifa_2020to2024","obisb_1876to1899",
           "obisb_1900to1909","obisb_1910to1919","obisb_1920to1929","obisb_1930to1939","obisb_1940to1949",
           "obisb_1950to1959","obisb_1960to1969","obisb_1970to1979","obisb_1980to1989","obisb_1990to1999",
           "obisb_2000to2009","obisb_2010to2019","obisb_2020to2024","emodc","nexpd")

# Import two just as a sample
fullData <- lapply(all24, FUN = function(x) {
  if (grepl("gbif", x)) {
    dataset <- readRDS(paste0("data/gbif/", x, ".RDS"))
  } else {
    dataset <- get(x)
  }
  dataset
}) |> setNames(all24)
# saveRDS(fullData, "data/fullDataset.RDS")

#Keeping track of results
all24nrow <- c()
for(i in 1:length(all24)){all24nrow[i] <- nrow(fullData[[i]])} 
all24nrow

###Performing operations in segments, due to the size of data downloads
splitData <- list()
for(i in 1:length(all24)){ 
  x <- fullData[[i]]
  int <- 800000
  tot <- nrow(x)
  spl <- split(x, rep(1:ceiling(tot/int), each=int, length.out=tot))
  splity <- c()
  for(a in 1:length(spl)){
    y <- spl[[a]]  
    assign(paste0(all24[i],a,"_split"),y)
    splity[a] <- paste0(all24[i],a,"_split")
  }
  assign(paste0(all24[i],"_splity"),splity)
}

#2. Retrieving landshape: from <rnaturalearth>.
theme_set(theme_bw())
world <- ne_countries(scale = "medium", returnclass = "sf")
world2 <- st_crop(world, xmin = -27, ymin = 50, xmax = 38, ymax = 85)

#Step 1. Masking data with the polygon in the south (south of the AOI, see figure 1, for the coordinates defined above).    
rm(i,x,a)
all24_mkdS <- c()
all24_mkdSnrow <- c()
all24wCoord <- c()
all24_mkdSspl <- c()
all24_mkdSln <- c()

for(i in 1:length(all24)){
  vectorx <- get(paste0(all24[i],"_splity"))
  
  all24_mkdSspl <- c()
  for(a in 1:length(vectorx)){
    x <- st_read("data/polygonSouth.shp")
    st_is_valid(x, reason = TRUE)
    sf_use_s2(FALSE)
    st_is_valid(x, reason = TRUE)
    
    y0 <- get(vectorx[a]) 
    y0 <- y0 %>% filter(!is.na(decimalLongitude) | !is.na(decimalLatitude))
    y0$XCoord <- y0$decimalLongitude
    y0$YCoord <- y0$decimalLatitude
    all24wCoord[a] <- nrow(y0)
    
    y <- st_as_sf(x = y0,                         
                  coords = c("XCoord", "YCoord"),
                  crs = 4326)
    
    y_int <- st_intersects(y,x)
    y_log <- lengths(y_int) == 0 
    databases_mkd <- y[y_log, ]
    
    databases_mkd <- as.data.frame(databases_mkd)
    
    assign(paste0(all24[i],"_",a,"_mkdS"),databases_mkd)
    all24_mkdSspl[a] <- paste0(all24[i],"_",a,"_mkdS")
    all24_mkdSln[a] <- nrow(databases_mkd)
    
  }
  assign(paste0(all24[i],"_wCoordvec"),all24wCoord)
  assign(paste0(all24[i],"_mkdSspl"),all24_mkdSspl)
  all24_mkdS[i] <- paste0(all24[i],"_mkdS")
  all24_mkdSnrow[i] <- sum(all24_mkdSln)
  sf_use_s2(TRUE)
}
rm(databases_mkd,vectorx)

#Step 2. Masking out terrestrial data with the landshape from <rnaturalearth>. 
rm(i,a,b)
all24_mkd <- c()
all24_mkdnrow <- c()
all24_mkdln <- c()
all24_mkdspl <- c()

for(i in 1:length(all24_mkdS)){ 
  vectorx <- get(paste0(all24[i],"_mkdSspl"))
  
  for(a in 1:length(vectorx)){
    for(b in 1:2){
      if(b == 1){sf_use_s2(FALSE)}
      if(b == 2){sf_use_s2(TRUE)}
      x <- world2
      if(b == 1){y0 <- get(vectorx[a])}
      if(b == 2){y0 <- databases_mkd}
      y0$XCoord <- y0$decimalLongitude
      y0$YCoord <- y0$decimalLatitude
      
      y <- st_as_sf(x = y0,                         
                    coords = c("XCoord", "YCoord"),
                    crs = 4326)
      
      y_int <- st_intersects(y,x)
      y_log <- lengths(y_int) == 0 
      databases_mkd <- y[y_log, ]
      
      databases_mkd <- as.data.frame(databases_mkd)
      print(nrow(databases_mkd))
    }
    
    assign(paste0(all24[i],"_",a,"_mkd"),databases_mkd)
    all24_mkdspl[a] <- paste0(all24[i],"_",a,"_mkd")
    all24_mkdln[a] <- nrow(databases_mkd)
    if(a == 1){databases_mkdAll <- databases_mkd}
    if(a > 1){databases_mkdAll <- rbind(databases_mkdAll,databases_mkd)}
    assign(paste0(all24[i], "_mkd"),databases_mkdAll)
  }
  assign(gsub(" ","",paste(all24[i],"_mkdspl")),all24_mkdspl)
  all24_mkd[i] <- paste0(all24[i],"_mkd")
  all24_mkdnrow[i] <- sum(all24_mkdln)
}
rm(databases_mkd,databases_mkdAll,vectorx) 

# Keeping track of results
rm(i)
all24_mkdnrow
all24_mkdnrow <- c()
for(i in 1:length(all24_mkd)){all24_mkdnrow[i] <- nrow(get(all24_mkd[i]))}
all24_mkdnrow
saveRDS(all24_mkdnrow, "data/landMaskedObservations.RDS")
tableA <- cbind(all24,all24_mkdnrow)
View(tableA)

#Filtering to species level   
rm(x,i)
tableBsp <- c()
acceptableRanks <- c("FORM", "Species", "SPECIES", "SUBSPECIES", "UNRANKED", "VARIETY")
for(i in 1:length(all24_mkd)){  
  tableBsp[i] = nrow(get(all24_mkd[i]) %>% filter(taxonRank %in% acceptableRanks | is.na(taxonRank)))
}
tableBsp
tableBsp <- cbind(all24_mkd,tableBsp)
View(tableBsp)

#3. Marine taxon filtering with the WoRMS database dump (it can be requested through the WoRMS website)                
rm(i,a,b)
length(all24_mkd)
all24_mkd

filteredData <- list()

for (b in 1:length(all24_mkd)){ 
  #I. Masking the groups that do not correspond to the marine environment
  
  dsName <- all24_mkd[b]
  
  #Filter to the species level (inside the filter loop)
  if(grepl("obis", dsName) |  grepl("gbif", dsName)) { #for GBIF and OBIS
    dbs_mkd_taxa = get(all24_mkd[b]) %>% filter(taxonRank %in% acceptableRanks | is.na(taxonRank)) 
  } else {
    dbs_mkd_taxa = get(all24_mkd[b])
  }
  
  dbs_mkd_taxa$scientificName = str_extract(string = dbs_mkd_taxa$scientificName, pattern = "[a-zA-Z]{1,25}\\s{1}[a-z]{2,25}")
  
  #Excluding some groups manually
  dbs_mkd_taxa <- dbs_mkd_taxa %>% filter(kingdom != "Plantae")
  exc_class = c("Tricholomataceae", "Fringillidae", "Insecta", "Arachnida", "Hexapoda", "Diplopoda", "Pauropoda", "Chilopoda", "Symphyla", "Diplura", "Protura", "Collembola")
  rm(i)
  
  dbs_mkd_taxa <- dbs_mkd_taxa[!(dbs_mkd_taxa$class %in% exc_class),]
  
  #II. Reading information from WoRMS in order to determine which families are non-marine 
  taxon <- read.csv("data/taxon.csv") %>% filter(acceptedNameUsage != "") # to get accepted names and the names where they come from (i.e Lophelia) # filter(taxonomicStatus == "accepted") only has accepted names, but not the species that has been re-assigned from their original designation.
  speciesprofile <- read.csv("data/speciesprofile.csv")
  unique(taxon$taxonRank) #verify that taxonomic level corresponds to species.
  worms <- right_join(taxon[,c(1,6:8,11:20,30)], speciesprofile %>% filter(isMarine == 1), by = "taxonID")
  unique(dbs_mkd_taxa$kingdom)
  unique(dbs_mkd_taxa$class)
  families_db <- unique(dbs_mkd_taxa$family)
  families_worms <- unique(worms$family)
  
  
  mar_fam <- families_db[families_db %in% families_worms] #subsample marine families
  nomar_fam <- families_db[!(families_db %in% families_worms)] #To check if NAs are removed  
  
  #III. Use of the verificationList1, named and stored in an R object as 'one'.
  #Adding and removing families that are marine and present in non-marine list and
  #families that are non-marine and are present in marine list  
  
  #Confirmed marine in worms
  one <- readxl::read_excel("one.xlsx", col_names = FALSE)
  colnames(one) <- c("species")
  one <- one$species
  #Confirmed in artsdatabanken
  two <- c("Sistotremataceae", "Naetrocymbaceae", "Mycocaliciaceae", "Dacampiaceae", "Lirellidae")
  #Marine which turned out to be no marine after confirmation (or non-valid taxa)
  plus_nomarine <- c("Esocidae", "Clausiliidae", "Physetocarididae")
  
  #merging the new marine and removing from the non-marine list
  plus_marine <- append(one,two)
  nomar_fam <- nomar_fam[!nomar_fam %in% plus_marine]
  
  #adding the new non-marine
  nomar_fam <- append(nomar_fam,plus_nomarine)
  
  #Comparing to the current dataset  
  rm(i)
  for (i in nomar_fam){ 
    dbs_mkd_taxa <- dbs_mkd_taxa %>% filter(family != i)  
  }
  
  #IV. Removing the species within the families that are non-marine
  species_db <- unique(dbs_mkd_taxa$scientificName)
  species_worms <- c(worms$scientificName, worms$acceptedNameUsage) #no need of unique(worms$parentNameUsage), as this is a level above species and the species are the ones considered for this work.
  
  mar_spp <- species_db[species_db %in% species_worms] #subsample marine families
  nomar_spp <- species_db[!(species_db %in% species_worms)] #To check if NAs are removed  
  
  #V. Run comparing to the current database         
  rm(i)
  
  dbs_mkd_taxa <- dbs_mkd_taxa %>% 
    filter(!(scientificName %in% nomar_spp))
  
  length(unique(dbs_mkd_taxa$class))
  rm(i,n)
  
  #Preparing the dataset to obtain the species abundances later. Species counts that are NA are taken as 1 (one record) and added together afterwards within the same species.
  #It is advisable to preserve the original column in a new one: e.g. individualCountB for later queries.
  
  dbs_mkd_taxa$individualCount[is.na(dbs_mkd_taxa$individualCount)] <- 1
  #This line goes only to GBIF
  if(grepl("gbif", dsName)){ dbs_mkd_taxa$individualCount[dbs_mkd_taxa$individualCount < 0] <- (dbs_mkd_taxa$individualCount[dbs_mkd_taxa$individualCount < 0])*-1 }
  dbs_mkd_taxa$individualCount[dbs_mkd_taxa$individualCount == 0] <- 1
  
  assign(paste0(all24[b], "_mkd_worms"),dbs_mkd_taxa)
  filteredData[[b]] <- dbs_mkd_taxa
}
names(filteredData) <- all24
saveRDS(filteredData, "data/filteredData.RDS")     

#Recording useful information
rm(i)
all24_worms <- c()
all24_wormsnrow <- c()
for(i in 1:length(all24)){all24_worms[i] <- paste0(all24[i], "_mkd_worms") }
for(i in 1:length(all24)){all24_wormsnrow[i] <- nrow(get(all24_worms[i]))} 
all24_wormsnrow
all24_wormsnrow <- cbind(all24_worms,all24_wormsnrow)
View(all24_wormsnrow)
