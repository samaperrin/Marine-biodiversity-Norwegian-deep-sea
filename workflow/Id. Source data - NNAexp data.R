#Id. NNAexp data. 
setwd("//workingdirectory") #setting up the working directory.   

#File from the Norwegian North Atlantic expedition. For access to the files, please contact the corresponding author.
norwegian_expedition_database <- read_excel("~/R/norwegian_expedition_database.xlsx")

#filling the columns that are not present in the records with NAs
#and the ones with taxonomic details ready to be filled with the Worms database

taxon <- read.delim("~/R/taxon.txt")
speciesprofile <- read.delim("~/R/speciesprofile.txt")
worms <- right_join(taxon[,c(1,6:8,11:20,30)], speciesprofile %>% filter(isMarine == 1), by = "taxonID")


#filling up fields 
norwegian_expedition_database$coordinateUncertaintyInMeters <- NA
norwegian_expedition_database$class <- worms$class[match(norwegian_expedition_database$scientificNameSpecies, worms$scientificName)]

for (i in 1:length(norwegian_expedition_database$class)){
  if ((norwegian_expedition_database[i,]$class == "" | is.na(norwegian_expedition_database[i,]$class)) & (norwegian_expedition_database[i,]$group == "Holothuroidea"
                                                                                                          | norwegian_expedition_database[i,]$group == "Asteroidea"
                                                                                                          | norwegian_expedition_database[i,]$group == "Ophiuroidea")
  ){ norwegian_expedition_database[i,]$class <- norwegian_expedition_database[i,]$group   }}

rm(i)


norwegian_expedition_database$dataset <- NA
norwegian_expedition_database$dateIdentified <- NA
norwegian_expedition_database$decimalLatitude <- norwegian_expedition_database$yCoord
norwegian_expedition_database$decimalLongitude <- norwegian_expedition_database$xCoord
norwegian_expedition_database$depth <- norwegian_expedition_database$minDepthm

for (i in 1:length(norwegian_expedition_database$depth)){
  if (!is.na(norwegian_expedition_database[i,]$maxDepthm)){
    if (norwegian_expedition_database[i,]$minDepthm >0 & norwegian_expedition_database[i,]$maxDepthm > 0){
      norwegian_expedition_database[i,]$depth <-round(rowMeans(norwegian_expedition_database[i,][,c('maxDepthm', 'minDepthm')]), digits = 0) } } }

rm(i)

norwegian_expedition_database$depthAccuracy <- NA
norwegian_expedition_database$family <- worms$family[match(norwegian_expedition_database$scientificNameSpecies, worms$scientificName)]
norwegian_expedition_database$id <- norwegian_expedition_database$recordId
norwegian_expedition_database$individualCount <- NA
norwegian_expedition_database$flags <- norwegian_expedition_database$observations
norwegian_expedition_database$kingdom <- worms$kingdom[match(norwegian_expedition_database$scientificNameSpecies, worms$scientificName)]


#kingdom classification for Annelida, Mollusca and Polyzoa phylum
for (i in 1:length(norwegian_expedition_database$kingdom)){
  
  if ((norwegian_expedition_database[i,]$kingdom == "" | is.na(norwegian_expedition_database[i,]$kingdom)) & (norwegian_expedition_database[i,]$group == "Fish" 
                                                                                                              | norwegian_expedition_database[i,]$group == "Annelida" 
                                                                                                              | norwegian_expedition_database[i,]$group == "Mollusca"
                                                                                                              | norwegian_expedition_database[i,]$group == "Holothuroidea"
                                                                                                              | norwegian_expedition_database[i,]$group == "Asteroidea"
                                                                                                              | norwegian_expedition_database[i,]$group == "Gephyrea"
                                                                                                              | norwegian_expedition_database[i,]$group == "Ophiuroidea")
  ){ norwegian_expedition_database[i,]$kingdom <- "Animalia" }
  
  if ((norwegian_expedition_database[i,]$kingdom == "" | is.na(norwegian_expedition_database[i,]$kingdom)) & (norwegian_expedition_database[i,]$group == "Cilioflagellata" 
                                                                                                              | norwegian_expedition_database[i,]$group == "Silicoflagellata")
  ){ norwegian_expedition_database[i,]$kingdom <- "Chromista" } } 

rm(i)

norwegian_expedition_database$scientificName <- norwegian_expedition_database$scientificNameSpecies
norwegian_expedition_database$taxonRank <- "SPECIES"
norwegian_expedition_database$database <- "norexp_1876_78"
norwegian_expedition_database$YCoord <- norwegian_expedition_database$yCoord
norwegian_expedition_database$XCoord <- norwegian_expedition_database$xCoord
norwegian_expedition_database$minimumDepthInMeters <- norwegian_expedition_database$minDepthm
norwegian_expedition_database$maximumDepthInMeters <- norwegian_expedition_database$maxDepthm
names(norwegian_expedition_database)
norwegian_expedition_database <- norwegian_expedition_database[c(25:28,16,29:37,17,38:39,18,41:44)]
norwegian_expedition_database$eventDate <- NA
names(norwegian_expedition_database)
nexpd <- norwegian_expedition_database

##End script Id
