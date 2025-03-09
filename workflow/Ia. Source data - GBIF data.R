  

#Packages to be used
if (!("rgbif" %in% installed.packages())) {install.packages("rgbif")} #this package enables the connection with the GBIF API 
library(rgbif) 

#Setting up the GBIF username and password.
source("functions/storeCredentials.R")


#Step A: Setting the request to the server.
#GBIF allows up to three simultaneous downloads. To check the status of the download and to get the records, see step B.
#Intervals every decade (first and last interval differ, see manuscript). 14 intervals in total for this work.   
#For further information, see the documentation for the rgbif package and the GBIF website.

#1. 1876-1899
gbif_1876to1899 <- occ_download(
  pred("hasGeospatialIssue", FALSE),
  pred("hasCoordinate", TRUE),
  pred("occurrenceStatus","PRESENT"), 
  pred_not(pred_in("basisOfRecord",c("FOSSIL_SPECIMEN","LIVING_SPECIMEN"))),
  pred_not(pred_in("classKey",c(212, 359))),
  pred_within("POLYGON((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))"),
  pred_and(pred_gte("year", 1876), pred_lte("year", 1899)),
  format = "SIMPLE_CSV")
gbif_1876to1899_key <- occ_download_meta(gbif_1876to1899) 
saveRDS(gbif_1876to1899_key, file = "data/keyStorage/gbif_1876to1899_key.RDS")

#2. 1900-1909
gbif_1900to1909 <- occ_download(
  pred("hasGeospatialIssue", FALSE),
  pred("hasCoordinate", TRUE),
  pred("occurrenceStatus","PRESENT"), 
  pred_not(pred_in("basisOfRecord",c("FOSSIL_SPECIMEN","LIVING_SPECIMEN"))),
  pred_not(pred_in("classKey",c(212, 359))),
  pred_within("POLYGON((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))"),
  pred_and(pred_gte("year", 1900), pred_lte("year", 1909)),
  format = "SIMPLE_CSV")
gbif_1900to1909_key <- occ_download_meta(gbif_1900to1909) 
saveRDS(gbif_1900to1909_key, file = "data/keyStorage/gbif_1900to1909_key.RDS")

#3. 1910-1919
gbif_1910to1919 <- occ_download(
  pred("hasGeospatialIssue", FALSE),
  pred("hasCoordinate", TRUE),
  pred("occurrenceStatus","PRESENT"), 
  pred_not(pred_in("basisOfRecord",c("FOSSIL_SPECIMEN","LIVING_SPECIMEN"))),
  pred_not(pred_in("classKey",c(212, 359))),
  pred_within("POLYGON((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))"),
  pred_and(pred_gte("year", 1910), pred_lte("year", 1919)),
  format = "SIMPLE_CSV")
gbif_1910to1919_key <- occ_download_meta(gbif_1910to1919) 
saveRDS(gbif_1910to1919_key, file = "data/keyStorage/gbif_1910to1919_key.RDS")


#4. 1920-1929
gbif_1920to1929 <- occ_download(
  pred("hasGeospatialIssue", FALSE),
  pred("hasCoordinate", TRUE),
  pred("occurrenceStatus","PRESENT"), 
  pred_not(pred_in("basisOfRecord",c("FOSSIL_SPECIMEN","LIVING_SPECIMEN"))),
  pred_not(pred_in("classKey",c(212, 359))),
  pred_within("POLYGON((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))"),
  pred_and(pred_gte("year", 1920), pred_lte("year", 1929)),
  format = "SIMPLE_CSV")
gbif_1920to1929_key <- occ_download_meta(gbif_1920to1929) 
saveRDS(gbif_1920to1929_key, file = "data/keyStorage/gbif_1920to1929_key.RDS")

#5. 1930-1939
gbif_1930to1939 <- occ_download(
  pred("hasGeospatialIssue", FALSE),
  pred("hasCoordinate", TRUE),
  pred("occurrenceStatus","PRESENT"), 
  pred_not(pred_in("basisOfRecord",c("FOSSIL_SPECIMEN","LIVING_SPECIMEN"))),
  pred_not(pred_in("classKey",c(212, 359))),
  pred_within("POLYGON((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))"),
  pred_and(pred_gte("year", 1930), pred_lte("year", 1939)),
  format = "SIMPLE_CSV")
gbif_1930to1939_key <- occ_download_meta(gbif_1930to1939) 
saveRDS(gbif_1930to1939_key, file = "data/keyStorage/gbif_1930to1939_key.RDS")

#6. 1940-1949
gbif_1940to1949 <- occ_download(
  pred("hasGeospatialIssue", FALSE),
  pred("hasCoordinate", TRUE),
  pred("occurrenceStatus","PRESENT"), 
  pred_not(pred_in("basisOfRecord",c("FOSSIL_SPECIMEN","LIVING_SPECIMEN"))),
  pred_not(pred_in("classKey",c(212, 359))),
  pred_within("POLYGON((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))"),
  pred_and(pred_gte("year", 1940), pred_lte("year", 1949)),
  format = "SIMPLE_CSV")
gbif_1940to1949_key <- occ_download_meta(gbif_1940to1949) 
saveRDS(gbif_1940to1949_key, file = "data/keyStorage/gbif_1940to1949_key.RDS")

#7. 1950-1959 
gbif_1950to1959 <- occ_download(
  pred("hasGeospatialIssue", FALSE),
  pred("hasCoordinate", TRUE),
  pred("occurrenceStatus","PRESENT"), 
  pred_not(pred_in("basisOfRecord",c("FOSSIL_SPECIMEN","LIVING_SPECIMEN"))),
  pred_not(pred_in("classKey",c(212, 359))),
  pred_within("POLYGON((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))"),
  pred_and(pred_gte("year", 1950), pred_lte("year", 1959)),
  format = "SIMPLE_CSV")
gbif_1950to1959_key <- occ_download_meta(gbif_1950to1959) 
saveRDS(gbif_1950to1959_key, file = "data/keyStorage/gbif_1950to1959_key.RDS")


#8. 1960-1969
gbif_1960to1969 <- occ_download(
  pred("hasGeospatialIssue", FALSE),
  pred("hasCoordinate", TRUE),
  pred("occurrenceStatus","PRESENT"), 
  pred_not(pred_in("basisOfRecord",c("FOSSIL_SPECIMEN","LIVING_SPECIMEN"))),
  pred_not(pred_in("classKey",c(212, 359))),
  pred_within("POLYGON((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))"),
  pred_and(pred_gte("year", 1960), pred_lte("year", 1969)),
  format = "SIMPLE_CSV")
gbif_1960to1969_key <- occ_download_meta(gbif_1960to1969) 
saveRDS(gbif_1960to1969_key, file = "data/keyStorage/gbif_1960to1969_key.RDS")

#9. 1970-1979
gbif_1970to1979 <- occ_download(
  pred("hasGeospatialIssue", FALSE),
  pred("hasCoordinate", TRUE),
  pred("occurrenceStatus","PRESENT"), 
  pred_not(pred_in("basisOfRecord",c("FOSSIL_SPECIMEN","LIVING_SPECIMEN"))),
  pred_not(pred_in("classKey",c(212, 359))),
  pred_within("POLYGON((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))"),
  pred_and(pred_gte("year", 1970), pred_lte("year", 1979)),
  format = "SIMPLE_CSV")
gbif_1970to1979_key <- occ_download_meta(gbif_1970to1979) 
saveRDS(gbif_1970to1979_key, file = "data/keyStorage/gbif_1970to1979_key.RDS")

#10. 1980-1989
gbif_1980to1989 <- occ_download(
  pred("hasGeospatialIssue", FALSE),
  pred("hasCoordinate", TRUE),
  pred("occurrenceStatus","PRESENT"), 
  pred_not(pred_in("basisOfRecord",c("FOSSIL_SPECIMEN","LIVING_SPECIMEN"))),
  pred_not(pred_in("classKey",c(212, 359))),
  pred_within("POLYGON((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))"),
  pred_and(pred_gte("year", 1980), pred_lte("year", 1989)),
  format = "SIMPLE_CSV")
gbif_1980to1989_key <- occ_download_meta(gbif_1980to1989) 
saveRDS(gbif_1980to1989_key, file = "data/keyStorage/gbif_1980to1989_key.RDS")

#11. 1990-1999
gbif_1990to1999 <- occ_download(
  pred("hasGeospatialIssue", FALSE),
  pred("hasCoordinate", TRUE),
  pred("occurrenceStatus","PRESENT"), 
  pred_not(pred_in("basisOfRecord",c("FOSSIL_SPECIMEN","LIVING_SPECIMEN"))),
  pred_not(pred_in("classKey",c(212, 359))),
  pred_within("POLYGON((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))"),
  pred_and(pred_gte("year", 1990), pred_lte("year", 1999)),
  format = "SIMPLE_CSV")
gbif_1990to1999_key <- occ_download_meta(gbif_1990to1999) 
saveRDS(gbif_1990to1999_key, file = "data/keyStorage/gbif_1990to1999_key.RDS")

#12. 2000-2009
gbif_2000to2009 <- occ_download(
  pred("hasGeospatialIssue", FALSE),
  pred("hasCoordinate", TRUE),
  pred("occurrenceStatus","PRESENT"), 
  pred_not(pred_in("basisOfRecord",c("FOSSIL_SPECIMEN","LIVING_SPECIMEN"))),
  pred_not(pred_in("classKey",c(212, 359))),
  pred_within("POLYGON((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))"),
  pred_and(pred_gte("year", 2000), pred_lte("year", 2009)),
  format = "SIMPLE_CSV")
gbif_2000to2009_key <- occ_download_meta(gbif_2000to2009) 
saveRDS(gbif_2000to2009_key, file = "data/keyStorage/gbif_2000to2009_key.RDS")

#13. 2010-2019
gbif_2010to2019 <- occ_download(
  pred("hasGeospatialIssue", FALSE),
  pred("hasCoordinate", TRUE),
  pred("occurrenceStatus","PRESENT"), 
  pred_not(pred_in("basisOfRecord",c("FOSSIL_SPECIMEN","LIVING_SPECIMEN"))),
  pred_not(pred_in("classKey",c(212, 359))),
  pred_within("POLYGON((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))"),
  pred_and(pred_gte("year", 2010), pred_lte("year", 2019)),
  format = "SIMPLE_CSV")
gbif_2010to2019_key <- occ_download_meta(gbif_2010to2019) 
saveRDS(gbif_2010to2019_key, file = "data/keyStorage/gbif_2010to2019_key.RDS")

#14. 2020-2024
gbif_2020to2024 <- occ_download(
  pred("hasGeospatialIssue", FALSE),
  pred("hasCoordinate", TRUE),
  pred("occurrenceStatus","PRESENT"), 
  pred_not(pred_in("basisOfRecord",c("FOSSIL_SPECIMEN","LIVING_SPECIMEN"))),
  pred_not(pred_in("classKey",c(212, 359))),
  pred_within("POLYGON((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))"),
  pred_gte("year", 2020),
  format = "SIMPLE_CSV")
gbif_2020to2024_key <- occ_download_meta(gbif_2020to2024) 
saveRDS(gbif_2020to2024_key, file = "data/keyStorage/gbif_2020to2024_key.RDS")


#IMPORTANT NOTE:
#always cite the doi. It can be seen calling the download object (i.e. gbif_2020to2024).
#Step B: Checking the status of the download in the server and retrieving the datasets into R. 
#Tip: Use the quote = "" argument if needed.

relevantColumns <- c("coordinateUncertaintyInMeters", "class", "datasetKey", "dateIdentified", "day", "decimalLatitude", "decimalLongitude", "depth", 
                     "depthAccuracy", "eventDate", "family", "gbifID", "individualCount", "issue", "kingdom", "month", "scientificName", "taxonRank", "year")

#1. gbif_1876to1899 (here are the citation guidelines). To check the status and import the download:
gbif_1876to1899_key <- readRDS(file = "data/keyStorage/gbif_1876to1899_key.RDS")
downloadGet <- occ_download_get(key=gbif_1876to1899_key$key, path="data", overwrite=TRUE)
occurrences <- downloadGet %>% occ_download_import(header = TRUE, sep = "\t", na.strings = "NA", fill = TRUE) #,quote = "")
occurrences <- occurrences[,relevantColumns]
saveRDS(occurrences, "data/gbif/gbifa_1876to1899.RDS")

#2. gbif_1900to1909
gbif_1900to1909_key <- readRDS(file = "data/keyStorage/gbif_1900to1909_key.RDS")
downloadGet <- occ_download_get(key=gbif_1900to1909_key$key, path="data", overwrite=TRUE)
occurrences <- downloadGet %>% occ_download_import(header = TRUE, sep = "\t", na.strings = "NA", fill = TRUE) #,quote = "")
occurrences <- occurrences[,relevantColumns]
saveRDS(occurrences, "data/gbif/gbifa_1900to1909.RDS")

#3. gbif_1910to1919
gbif_1910to1919_key <- readRDS(file = "data/keyStorage/gbif_1910to1919_key.RDS")
downloadGet <- occ_download_get(key=gbif_1910to1919_key$key, path="data", overwrite=TRUE)
occurrences <- downloadGet %>% occ_download_import(header = TRUE, sep = "\t", na.strings = "NA", fill = TRUE) #,quote = "")
occurrences <- occurrences[,relevantColumns]
saveRDS(occurrences, "data/gbif/gbifa_1910to1919.RDS")

#4. gbif_1920to1929
gbif_1920to1929_key <- readRDS(file = "data/keyStorage/gbif_1920to1929_key.RDS")
downloadGet <- occ_download_get(key=gbif_1920to1929_key$key, path="data", overwrite=TRUE)
occurrences <- downloadGet %>% occ_download_import(header = TRUE, sep = "\t", na.strings = "NA", fill = TRUE) #,quote = "")
occurrences <- occurrences[,relevantColumns]
saveRDS(occurrences, "data/gbif/gbifa_1920to1929.RDS")

#5. gbif_1930to1939
gbif_1930to1939_key <- readRDS(file = "data/keyStorage/gbif_1930to1939_key.RDS")
downloadGet <- occ_download_get(key=gbif_1930to1939_key$key, path="data", overwrite=TRUE)
occurrences <- downloadGet %>% occ_download_import(header = TRUE, sep = "\t", na.strings = "NA", fill = TRUE) #,quote = "")
occurrences <- occurrences[,relevantColumns]
saveRDS(occurrences, "data/gbif/gbifa_1930to1939.RDS")

#6. gbif_1940to1949
gbif_1940to1949_key <- readRDS(file = "data/keyStorage/gbif_1940to1949_key.RDS")
downloadGet <- occ_download_get(key=gbif_1940to1949_key$key, path="data", overwrite=TRUE)
occurrences <- downloadGet %>% occ_download_import(header = TRUE, sep = "\t", na.strings = "NA", fill = TRUE) #,quote = "")
occurrences <- occurrences[,relevantColumns]
saveRDS(occurrences, "data/gbif/gbifa_1940to1949.RDS")

#7. gbif_1950to1959
gbif_1950to1959_key <- readRDS(file = "data/keyStorage/gbif_1950to1959_key.RDS")
downloadGet <- occ_download_get(key=gbif_1950to1959_key$key, path="data", overwrite=TRUE)
occurrences <- downloadGet %>% occ_download_import(header = TRUE, sep = "\t", na.strings = "NA", fill = TRUE) #,quote = "")
occurrences <- occurrences[,relevantColumns]
saveRDS(occurrences, "data/gbif/gbifa_1950to1959.RDS")

#8. gbif_1960to1969
gbif_1960to1969_key <- readRDS(file = "data/keyStorage/gbif_1960to1969_key.RDS")
downloadGet <- occ_download_get(key=gbif_1960to1969_key$key, path="data", overwrite=TRUE)
occurrences <- downloadGet %>% occ_download_import(header = TRUE, sep = "\t", na.strings = "NA", fill = TRUE) #,quote = "")
occurrences <- occurrences[,relevantColumns]
saveRDS(occurrences, "data/gbif/gbifa_1960to1969.RDS")

#9. gbif_1970to1979
gbif_1970to1979_key <- readRDS(file = "data/keyStorage/gbif_1970to1979_key.RDS")
downloadGet <- occ_download_get(key=gbif_1970to1979_key$key, path="data", overwrite=TRUE)
occurrences <- downloadGet %>% occ_download_import(header = TRUE, sep = "\t", na.strings = "NA", fill = TRUE) #,quote = "")
occurrences <- occurrences[,relevantColumns]
saveRDS(occurrences, "data/gbif/gbifa_1970to1979.RDS")

#10. gbif_1980to1989
gbif_1980to1989_key <- readRDS(file = "data/keyStorage/gbif_1980to1989_key.RDS")
downloadGet <- occ_download_get(key=gbif_1980to1989_key$key, path="data", overwrite=TRUE)
occurrences <- downloadGet %>% occ_download_import(header = TRUE, sep = "\t", na.strings = "NA", fill = TRUE) #,quote = "")
occurrences <- occurrences[,relevantColumns]
saveRDS(occurrences, "data/gbif/gbifa_1980to1989.RDS")

#11. gbif_1990to1999
gbif_1990to1999_key <- readRDS(file = "data/keyStorage/gbif_1990to1999_key.RDS")
downloadGet <- occ_download_get(key=gbif_1990to1999_key$key, path="data", overwrite=TRUE)
occurrences <- downloadGet %>% occ_download_import(header = TRUE, sep = "\t", na.strings = "NA", fill = TRUE) #,quote = "")
occurrences <- occurrences[,relevantColumns]
saveRDS(occurrences, "data/gbif/gbifa_1990to1999.RDS")

#12. gbif_2000to2009
gbif_2000to2009_key <- readRDS(file = "data/keyStorage/gbif_2000to2009_key.RDS")
downloadGet <- occ_download_get(key=gbif_2000to2009_key$key, path="data", overwrite=TRUE)
occurrences <- downloadGet %>% occ_download_import(header = TRUE, sep = "\t", na.strings = "NA", fill = TRUE) #,quote = "")
occurrences <- occurrences[,relevantColumns]
saveRDS(occurrences, "data/gbif/gbifa_2000to2009.RDS")

#13. gbif_2010to2019
gbif_2010to2019_key <- readRDS(file = "data/keyStorage/gbif_2010to2019_key.RDS")
downloadGet <- occ_download_get(key=gbif_2010to2019_key$key, path="data", overwrite=TRUE)
occurrences <- downloadGet %>% occ_download_import(header = TRUE, sep = "\t", na.strings = "NA", fill = TRUE) #,quote = "")
occurrences <- occurrences[,relevantColumns]
saveRDS(occurrences, "data/gbif/gbifa_2010to2019.RDS")

#14. gbif_2020to2024 
gbif_2020to2024_key <- readRDS(file = "data/keyStorage/gbif_2020to2024_key.RDS")
downloadGet <- occ_download_get(key=gbif_2020to2024_key$key, path="data", overwrite=TRUE)
occurrences <- downloadGet %>% occ_download_import(header = TRUE, sep = "\t", na.strings = "NA", fill = TRUE) #,quote = "")
occurrences <- occurrences[,relevantColumns]
saveRDS(occurrences, "data/gbif/gbifa_2020to2024.RDS")

