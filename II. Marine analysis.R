#II. Marine analysis 
setwd("//workingdirectory") #setting up the working directory.    

#1.Masking data to include only data in the AOI and in the marine area.
all24 <- c("gbifa_1876to1899","gbifa_1900to1909","gbifa_1910to1919","gbifa_1920to1929","gbifa_1930to1939",
           "gbifa_1940to1949","gbifa_1950to1959","gbifa_1960to1969","gbifa_1970to1979", "gbifa_1980to1989", 
           "gbifa_1990to1999","gbifa_2000to2009","gbifa_2010to2019","gbifa_2020to2024","obisb_1876to1899",
           "obisb_1900to1909","obisb_1910to1919","obisb_1920to1929","obisb_1930to1939","obisb_1940to1949",
           "obisb_1950to1959","obisb_1960to1969","obisb_1970to1979","obisb_1980to1989","obisb_1990to1999",
           "obisb_2000to2009","obisb_2010to2019","obisb_2020to2024","emodc","nexpd")
all24

#Keeping track of results
rm(i)
all24nrow <- c()
for(i in 1:length(all24)){all24nrow[i] <- nrow(get(all24[i]))} 
all24nrow

###Performing operations in segments, due to the size of data downloads
rm(x,i,a)
for(i in 1:length(all24)){ 
  x <- get(all24[i])
  int <- 800000
  tot <- nrow(x)
  spl <- split(x, rep(1:ceiling(tot/int), each=int, length.out=tot))
  rm(a,y)
  splity <- c()
  for(a in 1:length(spl)){
    y <- spl[[a]]  
    assign(gsub(" ","",paste(all24[i],a,"_split")),y)
    splity[a] <- gsub(" ","",paste(all24[i],a,"_split"))
  }
  assign(gsub(" ","",paste(all24[i],"_splity")),splity)
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
  vectorx <- get(gsub(" ","",paste(all24[i],"_splity")))
  
  for(a in 1:length(vectorx)){
    x <- st_read("polygonSouth.shp")
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

    
    assign(gsub(" ","",paste(all24[i],"_",a,"_mkdS")),databases_mkd)
    all24_mkdSspl[a] <- gsub(" ","",paste(all24[i],"_",a,"_mkdS"))
    all24_mkdSln[a] <- nrow(databases_mkd)

  }
  assign(gsub(" ","",paste(all24[i],"_wCoordvec")),all24wCoord)
  assign(gsub(" ","",paste(all24[i],"_mkdSspl")),all24_mkdSspl)
  all24_mkdS[i] <- gsub(" ","",paste(all24[i],"_mkdS"))
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
  vectorx <- get(gsub(" ","",paste(all24[i],"_mkdSspl")))
  
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

    assign(gsub(" ","",paste(all24[i],"_",a,"_mkd")),databases_mkd)
    all24_mkdspl[a] <- gsub(" ","",paste(all24[i],"_",a,"_mkd"))
    all24_mkdln[a] <- nrow(databases_mkd)
    if(a == 1){databases_mkdAll <- databases_mkd}
    if(a > 1){databases_mkdAll <- rbind(databases_mkdAll,databases_mkd)}
    assign(gsub(" ","",paste(all24[i], "_mkd")),databases_mkdAll)
  }
  assign(gsub(" ","",paste(all24[i],"_mkdspl")),all24_mkdspl)
  all24_mkd[i] <- gsub(" ","",paste(all24[i],"_mkd"))
  all24_mkdnrow[i] <- sum(all24_mkdln)
}
rm(databases_mkd,databases_mkdAll,vectorx) 

# Keeping track of results
rm(i)
all24_mkdnrow
all24_mkdnrow <- c()
for(i in 1:length(all24_mkd)){all24_mkdnrow[i] <- nrow(get(all24_mkd[i]))}
all24_mkdnrow
tableA <- cbind(all24,all24_mkdnrow)
View(tableA)

#Filtering to species level   
rm(x,i)
rm(tableBsp)
tableBsp <- c()
for(i in 1:length(all24_mkd)){  
  tableBsp[i] = nrow(get(all24_mkd[i]) %>% filter(taxonRank == "FORM" | taxonRank == "Species" | taxonRank == "SPECIES" | taxonRank == "SUBSPECIES" | taxonRank == "UNRANKED" | taxonRank == "VARIETY" | is.na(taxonRank)))
}
tableBsp
tableBsp <- cbind(all24_mkd,tableBsp)
View(tableBsp)

#3. Marine taxon filtering with the WoRMS database dump (it can be requested through the WoRMS website)                
rm(i,a,b)
length(all24_mkd)
all24_mkd

for (b in 1:length(all24_mkd)){ 
  #I. Masking the groups that do not correspond to the marine environment
  
  #Filter to the species level (inside the filter loop)
  if(b < 29){ #for GBIF and OBIS
    dbs_mkd_taxa = get(all24_mkd[b]) %>% filter(taxonRank == "FORM" | taxonRank == "species"| taxonRank == "Species" | taxonRank == "SPECIES" | taxonRank == "subspecies" | taxonRank == "Subspecies" | taxonRank == "SUBSPECIES" | taxonRank == "UNRANKED" | taxonRank == "VARIETY" | is.na(taxonRank)) }
  if(b > 28){dbs_mkd_taxa = get(all24_mkd[b])}
  
  dbs_mkd_taxa$scientificName = str_extract(string = dbs_mkd_taxa$scientificName, pattern = "[a-zA-Z]{1,25}\\s{1}[a-z]{2,25}")

  #Excluding some groups manually
  dbs_mkd_taxa <- dbs_mkd_taxa %>% filter(kingdom != "Plantae")
  exc_class = c("Tricholomataceae", "Fringillidae", "Insecta", "Arachnida", "Hexapoda", "Diplopoda", "Pauropoda", "Chilopoda", "Symphyla", "Diplura", "Protura", "Collembola")
  rm(i)
  
  for (i in exc_class){ dbs_mkd_taxa <- dbs_mkd_taxa %>% filter(class != i) }
  
  #II. Reading information from WoRMS in order to determine which families are non-marine 
  taxon <- read.delim("~/R/taxon.txt") %>% filter(acceptedNameUsage != "") # to get accepted names and the names where they come from (i.e Lophelia) # filter(taxonomicStatus == "accepted") only has accepted names, but not the species that has been re-assigned from their original designation.
  speciesprofile <- read.delim("~/R/speciesprofile.txt")
  unique(taxon$taxonRank) #verify that taxonomic level corresponds to species.
  worms <- right_join(taxon[,c(1,6:8,11:20,30)], speciesprofile %>% filter(isMarine == 1), by = "taxonID")
  unique(dbs_mkd_taxa$kingdom)
  unique(dbs_mkd_taxa$class)
  families_db <- unique(dbs_mkd_taxa$family)
  families_worms <- unique(worms$family)
  
  n <- 1
  rm(i)
  max_log <- c()

  #To see TRUE matches, we choose the maximum logical output, as this contains TRUE results.
  
  for(i in families_db){ max_log[i] <- length(unique(families_worms == i)) }
  max(max_log)
  
  #Removing NAs
  unique(max_log)
  length(families_db)
  
  if(length(which(max_log == 1))>0) { families_db <- families_db[-(which(max_log == 1))]  }
  length(families_db)
  
  #Repeat the previous operation after removing NA records, to find matching records in WoRMS
  n <- 1
  rm(i)
  max_log <- c()
  
  for(i in families_db){ max_log[i] <- length(unique(families_worms == i))   }
  
  unique(max_log)
  vector2false <- which(max_log == 2) #non-marine
  vector3true <- which(max_log == 3) #marine
  
  log_fam <- c()
  n <- 1
  rm(i)
 
  for(i in families_db){
    
    if (length(unique(families_worms == i)) == max(max_log)){
      log_fam[n] <- TRUE 
      n <- n+1  }
    
    else {
      log_fam[n] <- FALSE 
      n <- n+1  }}

  length(log_fam[log_fam == TRUE]) # Number for marine
  length(log_fam[log_fam == FALSE]) # Number for non-marine
  
  log_fam_nomar <- log_fam == FALSE
  mar_fam <- families_db[log_fam] #subsample marine families
  nomar_fam <- families_db[log_fam_nomar] #subsample non-marine families
  nomar_fam <- nomar_fam[-(which(is.na(nomar_fam)))] #To check if NAs are removed  
  
  #III. Use of the verificationList1, named and stored in an R object as 'one'.
  #Adding and removing families that are marine and present in non-marine list and
  #families that are non-marine and are present in marine list  
 
  #Confirmed marine in worms
  one <- read_excel("~/R/one.xlsx", col_names = FALSE)
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
  for (i in nomar_fam){ dbs_mkd_taxa <- dbs_mkd_taxa %>% filter(family != i)  }
  
  #IV. Removing the species within the families that are non-marine
  species_db <- unique(dbs_mkd_taxa$scientificName)
  species_worms <- c(worms$scientificName, worms$acceptedNameUsage) #no need of unique(worms$parentNameUsage), as this is a level above species and the species are the ones considered for this work.
  
  n <- 1
  rm(i)
  max_log <- c()

  # To see the match that was true (FALSE,NA,TRUE), we choose the maximum logical output
  for(i in species_db){ max_log[i] <- length(unique(species_worms == i))  }
  max(max_log)
  
  #Remove NAs
  unique(max_log)
  length(species_db)
  
  if(length(which(max_log == 1))>0) { species_db <- species_db[-(which(max_log == 1))]  }
  length(species_db)
  
  #Repeat without NAs present 
  rm(i)
  max_log <- c()
  
  for(i in species_db){ max_log[i] <- length(unique(species_worms == i))  }
  
  unique(max_log)
  
  vector2false <- which(max_log == 2) #non-marine  
  vector3true <- which(max_log == 3) #marine
  
  log_spp <- c()
  n <- 1
  rm(i)
  
  for(i in species_db){
    
    if (length(unique(species_worms == i)) == max(max_log)){
      log_spp[n] <- TRUE 
      n <- n+1    }
    
    else {
      log_spp[n] <- FALSE 
      n <- n+1  } }
  
  length(log_spp[log_spp == TRUE]) # Number for marine
  length(log_spp[log_spp == FALSE]) # Number for non-marine
  
  log_spp_nomar <- log_spp == FALSE
  mar_spp <- species_db[log_spp] #subsample marine species
  nomar_spp <- species_db[log_spp_nomar] #subsample non-marine species
  
  #V. Run comparing to the current database         
  rm(i)
  
  for (i in nomar_spp){ dbs_mkd_taxa <- dbs_mkd_taxa %>% filter(scientificName != i)  }
  
  length(unique(dbs_mkd_taxa$class))
  rm(i,n)
  
  #Preparing the dataset to obtain the species abundances later. Species counts that are NA are taken as 1 (one record) and added together afterwards within the same species.
  #It is advisable to preserve the original column in a new one: e.g. individualCountB for later queries.
  
  dbs_mkd_taxa$individualCount[is.na(dbs_mkd_taxa$individualCount)] <- 1
  #This line goes only to GBIF
  if(b < 15){ dbs_mkd_taxa$individualCount[dbs_mkd_taxa$individualCount < 0] <- (dbs_mkd_taxa$individualCount[dbs_mkd_taxa$individualCount < 0])*-1 }
  dbs_mkd_taxa$individualCount[dbs_mkd_taxa$individualCount == 0] <- 1
  
  assign(gsub(" ","",paste(all24[b], "_mkd_worms")),dbs_mkd_taxa)
}
rm(i,n,b)     
                            
#Recording useful information
rm(i)
all24_worms <- c()
all24_wormsnrow <- c()
for(i in 1:length(all24)){all24_worms[i] <- gsub(" ","",paste(all24[i], "_mkd_worms")) }
for(i in 1:length(all24)){all24_wormsnrow[i] <- nrow(get(all24_worms[i]))} 
all24_wormsnrow
all24_wormsnrow <- cbind(all24_worms,all24_wormsnrow)
View(all24_wormsnrow)
                          
##End script II.
  
