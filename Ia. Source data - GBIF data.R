#Ia. GBIF data. 
setwd("//workingdirectory") #setting up the working directory.   

#Packages to be used
install.packages("rgbif") #this package enables the connection with the GBIF API 
library(rgbif) 

#Setting up the GBIF username and password.
install.packages("usethis") #this package allows the access to the GBIF server with existing credentials.
usethis::edit_r_environ()
GBIF_USER="insert user here"
GBIF_PWD="insert password here"
GBIF_EMAIL="insert email here"   


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
  pred_within("POLYGON((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))"),
  pred_and(pred_gte("year", 1876), pred_lte("year", 1899)),
  format = "SIMPLE_CSV")

#2. 1900-1909
gbif_1900to1909 <- occ_download(
  pred("hasGeospatialIssue", FALSE),
  pred("hasCoordinate", TRUE),
  pred("occurrenceStatus","PRESENT"), 
  pred_not(pred_in("basisOfRecord",c("FOSSIL_SPECIMEN","LIVING_SPECIMEN"))),
  pred_within("POLYGON((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))"),
  pred_and(pred_gte("year", 1900), pred_lte("year", 1909)),
  format = "SIMPLE_CSV")

#3. 1910-1919
gbif_1910to1919 <- occ_download(
  pred("hasGeospatialIssue", FALSE),
  pred("hasCoordinate", TRUE),
  pred("occurrenceStatus","PRESENT"), 
  pred_not(pred_in("basisOfRecord",c("FOSSIL_SPECIMEN","LIVING_SPECIMEN"))),
  pred_within("POLYGON((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))"),
  pred_and(pred_gte("year", 1910), pred_lte("year", 1919)),
  format = "SIMPLE_CSV")


#4. 1920-1929
gbif_1920to1929 <- occ_download(
  pred("hasGeospatialIssue", FALSE),
  pred("hasCoordinate", TRUE),
  pred("occurrenceStatus","PRESENT"), 
  pred_not(pred_in("basisOfRecord",c("FOSSIL_SPECIMEN","LIVING_SPECIMEN"))),
  pred_within("POLYGON((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))"),
  pred_and(pred_gte("year", 1920), pred_lte("year", 1929)),
  format = "SIMPLE_CSV")

#5. 1930-1939
gbif_1930to1939 <- occ_download(
  pred("hasGeospatialIssue", FALSE),
  pred("hasCoordinate", TRUE),
  pred("occurrenceStatus","PRESENT"), 
  pred_not(pred_in("basisOfRecord",c("FOSSIL_SPECIMEN","LIVING_SPECIMEN"))),
  pred_within("POLYGON((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))"),
  pred_and(pred_gte("year", 1930), pred_lte("year", 1939)),
  format = "SIMPLE_CSV")

#6. 1940-1949
gbif_1940to1949 <- occ_download(
  pred("hasGeospatialIssue", FALSE),
  pred("hasCoordinate", TRUE),
  pred("occurrenceStatus","PRESENT"), 
  pred_not(pred_in("basisOfRecord",c("FOSSIL_SPECIMEN","LIVING_SPECIMEN"))),
  pred_within("POLYGON((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))"),
  pred_and(pred_gte("year", 1940), pred_lte("year", 1949)),
  format = "SIMPLE_CSV")

#7. 1950-1959 
gbif_1950to1959 <- occ_download(
  pred("hasGeospatialIssue", FALSE),
  pred("hasCoordinate", TRUE),
  pred("occurrenceStatus","PRESENT"), 
  pred_not(pred_in("basisOfRecord",c("FOSSIL_SPECIMEN","LIVING_SPECIMEN"))),
  pred_within("POLYGON((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))"),
  pred_and(pred_gte("year", 1950), pred_lte("year", 1959)),
  format = "SIMPLE_CSV")


#8. 1960-1969
gbif_1960to1969 <- occ_download(
  pred("hasGeospatialIssue", FALSE),
  pred("hasCoordinate", TRUE),
  pred("occurrenceStatus","PRESENT"), 
  pred_not(pred_in("basisOfRecord",c("FOSSIL_SPECIMEN","LIVING_SPECIMEN"))),
  pred_within("POLYGON((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))"),
  pred_and(pred_gte("year", 1960), pred_lte("year", 1969)),
  format = "SIMPLE_CSV")

#9. 1970-1979
gbif_1970to1979 <- occ_download(
  pred("hasGeospatialIssue", FALSE),
  pred("hasCoordinate", TRUE),
  pred("occurrenceStatus","PRESENT"), 
  pred_not(pred_in("basisOfRecord",c("FOSSIL_SPECIMEN","LIVING_SPECIMEN"))),
  pred_within("POLYGON((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))"),
  pred_and(pred_gte("year", 1970), pred_lte("year", 1979)),
  format = "SIMPLE_CSV")

#10. 1980-1989
gbif_1980to1989 <- occ_download(
  pred("hasGeospatialIssue", FALSE),
  pred("hasCoordinate", TRUE),
  pred("occurrenceStatus","PRESENT"), 
  pred_not(pred_in("basisOfRecord",c("FOSSIL_SPECIMEN","LIVING_SPECIMEN"))),
  pred_within("POLYGON((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))"),
  pred_and(pred_gte("year", 1980), pred_lte("year", 1989)),
  format = "SIMPLE_CSV")

#11. 1990-1999
gbif_1990to1999 <- occ_download(
  pred("hasGeospatialIssue", FALSE),
  pred("hasCoordinate", TRUE),
  pred("occurrenceStatus","PRESENT"), 
  pred_not(pred_in("basisOfRecord",c("FOSSIL_SPECIMEN","LIVING_SPECIMEN"))),
  pred_within("POLYGON((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))"),
  pred_and(pred_gte("year", 1990), pred_lte("year", 1999)),
  format = "SIMPLE_CSV")

#12. 2000-2009
gbif_2000to2009 <- occ_download(
  pred("hasGeospatialIssue", FALSE),
  pred("hasCoordinate", TRUE),
  pred("occurrenceStatus","PRESENT"), 
  pred_not(pred_in("basisOfRecord",c("FOSSIL_SPECIMEN","LIVING_SPECIMEN"))),
  pred_within("POLYGON((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))"),
  pred_and(pred_gte("year", 2000), pred_lte("year", 2009)),
  format = "SIMPLE_CSV")

#13. 2010-2019
gbif_2010to2019 <- occ_download(
  pred("hasGeospatialIssue", FALSE),
  pred("hasCoordinate", TRUE),
  pred("occurrenceStatus","PRESENT"), 
  pred_not(pred_in("basisOfRecord",c("FOSSIL_SPECIMEN","LIVING_SPECIMEN"))),
  pred_within("POLYGON((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))"),
  pred_and(pred_gte("year", 2010), pred_lte("year", 2019)),
  format = "SIMPLE_CSV")

#14. 2020-2024
gbif_2020to2024 <- occ_download(
  pred("hasGeospatialIssue", FALSE),
  pred("hasCoordinate", TRUE),
  pred("occurrenceStatus","PRESENT"), 
  pred_not(pred_in("basisOfRecord",c("FOSSIL_SPECIMEN","LIVING_SPECIMEN"))),
  pred_within("POLYGON((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))"),
  pred_gte("year", 2020),
  format = "SIMPLE_CSV")


#IMPORTANT NOTE:
#always cite the doi. It can be seen calling the download object (i.e. gbif_2020to2024).
#Step B: Checking the status of the download in the server and retrieving the datasets into R. 
#Tip: Use the quote = "" argument if needed.

#1. gbif_1876to1899 (here are the citation guidelines). To check the status and import the download:
occ_download_wait(head(gbif_1876to1899))
gbifa_1876to1899 <- occ_download_get(head(gbif_1876to1899)) %>% occ_download_import(header = TRUE, sep = "\t", na.strings = "NA", fill = TRUE) #,quote = "")

#2. gbif_1900to1909
occ_download_wait(head(gbif_1900to1909))
gbifa_1900to1909 <- occ_download_get(head(gbif_1900to1909)) %>% occ_download_import(header = TRUE, sep = "\t", na.strings = "NA", fill = TRUE) #,quote = "")

#3. gbif_1910to1919
occ_download_wait(head(gbif_1910to1919))
gbifa_1910to1919 <- occ_download_get(head(gbif_1910to1919)) %>% occ_download_import(header = TRUE, sep = "\t", na.strings = "NA", fill = TRUE) #,quote = "")

#4. gbif_1920to1929
occ_download_wait(head(gbif_1920to1929))
gbifa_1920to1929 <- occ_download_get(head(gbif_1920to1929)) %>% occ_download_import(header = TRUE, sep = "\t", na.strings = "NA", fill = TRUE) #,quote = "")

#5. gbif_1930to1939
occ_download_wait(head(gbif_1930to1939))
gbifa_1930to1939 <- occ_download_get(head(gbif_1930to1939)) %>% occ_download_import(header = TRUE, sep = "\t", na.strings = "NA", fill = TRUE) #,quote = "")

#6. gbif_1940to1949
occ_download_wait(head(gbif_1940to1949))
gbifa_1940to1949 <- occ_download_get(head(gbif_1940to1949)) %>% occ_download_import(header = TRUE, sep = "\t", na.strings = "NA", fill = TRUE) #,quote = "")

#7. gbif_1950to1959
occ_download_wait(head(gbif_1950to1959))
gbifa_1950to1959 <- occ_download_get(head(gbif_1950to1959)) %>% occ_download_import(header = TRUE, sep = "\t", na.strings = "NA", fill = TRUE) #,quote = "")

#8. gbif_1960to1969
occ_download_wait(head(gbif_1960to1969))
gbifa_1960to1969 <- occ_download_get(head(gbif_1960to1969)) %>% occ_download_import(header = TRUE, sep = "\t", na.strings = "NA", fill = TRUE) #,quote = "")

#9. gbif_1970to1979
occ_download_wait(head(gbif_1970to1979))
gbifa_1970to1979 <- occ_download_get(head(gbif_1970to1979)) %>% occ_download_import(header = TRUE, sep = "\t", na.strings = "NA", fill = TRUE) #,quote = "")

#10. gbif_1980to1989
occ_download_wait(head(gbif_1980to1989))
gbifa_1980to1989 <- occ_download_get(head(gbif_1980to1989)) %>% occ_download_import(header = TRUE, sep = "\t", na.strings = "NA", fill = TRUE) #,quote = "")

#11. gbif_1990to1999
occ_download_wait(head(gbif_1990to1999))
gbifa_1990to1999 <- occ_download_get(head(gbif_1990to1999)) %>% occ_download_import(header = TRUE, sep = "\t", na.strings = "NA", fill = TRUE) #,quote = "")

#12. gbif_2000to2009
occ_download_wait(head(gbif_2000to2009))
gbifa_2000to2009 <- occ_download_get(head(gbif_2000to2009)) %>% occ_download_import(header = TRUE, sep = "\t", na.strings = "NA", fill = TRUE) #,quote = "")

#13. gbif_2010to2019
occ_download_wait(head(gbif_2010to2019))
gbifa_2010to2019 <- occ_download_get(head(gbif_2010to2019)) %>% occ_download_import(header = TRUE, sep = "\t", na.strings = "NA", fill = TRUE) #,quote = "")

#14. gbif_2020to2024 
occ_download_wait(head(gbif_2020to2024))
gbifa_2020to2024 <- occ_download_get(head(gbif_2020to2024)) %>% occ_download_import(header = TRUE, sep = "\t", na.strings = "NA", fill = TRUE) #,quote = "")


#Step C. Select the database fields that you need to work with. For this work, these are 18 fields.

gbifa_1876to1899 = gbifa_1876to1899[c("coordinateUncertaintyInMeters", "class", "datasetKey", "dateIdentified", "day", "decimalLatitude", "decimalLongitude", "depth", "depthAccuracy", "eventDate", "family", "gbifID", "individualCount", "issue", "kingdom", "month", "scientificName", "taxonRank", "year")]
gbifa_1900to1909 = gbifa_1900to1909[c("coordinateUncertaintyInMeters", "class", "datasetKey", "dateIdentified", "day", "decimalLatitude", "decimalLongitude", "depth", "depthAccuracy", "eventDate", "family", "gbifID", "individualCount", "issue", "kingdom", "month", "scientificName", "taxonRank", "year")]
gbifa_1910to1919 = gbifa_1910to1919[c("coordinateUncertaintyInMeters", "class", "datasetKey", "dateIdentified", "day", "decimalLatitude", "decimalLongitude", "depth", "depthAccuracy", "eventDate", "family", "gbifID", "individualCount", "issue", "kingdom", "month", "scientificName", "taxonRank", "year")]

gbifa_1920to1929 = gbifa_1920to1929[c("coordinateUncertaintyInMeters", "class", "datasetKey", "dateIdentified", "day", "decimalLatitude", "decimalLongitude", "depth", "depthAccuracy", "eventDate", "family", "gbifID", "individualCount", "issue", "kingdom", "month", "scientificName", "taxonRank", "year")]
gbifa_1930to1939 = gbifa_1930to1939[c("coordinateUncertaintyInMeters", "class", "datasetKey", "dateIdentified", "day", "decimalLatitude", "decimalLongitude", "depth", "depthAccuracy", "eventDate", "family", "gbifID", "individualCount", "issue", "kingdom", "month", "scientificName", "taxonRank", "year")]
gbifa_1940to1949 = gbifa_1940to1949[c("coordinateUncertaintyInMeters", "class", "datasetKey", "dateIdentified", "day", "decimalLatitude", "decimalLongitude", "depth", "depthAccuracy", "eventDate", "family", "gbifID", "individualCount", "issue", "kingdom", "month", "scientificName", "taxonRank", "year")]

gbifa_1950to1959 = gbifa_1950to1959[c("coordinateUncertaintyInMeters", "class", "datasetKey", "dateIdentified", "day", "decimalLatitude", "decimalLongitude", "depth", "depthAccuracy", "eventDate", "family", "gbifID", "individualCount", "issue", "kingdom", "month", "scientificName", "taxonRank", "year")]
gbifa_1960to1969 = gbifa_1960to1969[c("coordinateUncertaintyInMeters", "class", "datasetKey", "dateIdentified", "day", "decimalLatitude", "decimalLongitude", "depth", "depthAccuracy", "eventDate", "family", "gbifID", "individualCount", "issue", "kingdom", "month", "scientificName", "taxonRank", "year")]
gbifa_1970to1979 = gbifa_1970to1979[c("coordinateUncertaintyInMeters", "class", "datasetKey", "dateIdentified", "day", "decimalLatitude", "decimalLongitude", "depth", "depthAccuracy", "eventDate", "family", "gbifID", "individualCount", "issue", "kingdom", "month", "scientificName", "taxonRank", "year")]

gbifa_1980to1989 = gbifa_1980to1989[c("coordinateUncertaintyInMeters", "class", "datasetKey", "dateIdentified", "day", "decimalLatitude", "decimalLongitude", "depth", "depthAccuracy", "eventDate", "family", "gbifID", "individualCount", "issue", "kingdom", "month", "scientificName", "taxonRank", "year")]
gbifa_1990to1999 = gbifa_1990to1999[c("coordinateUncertaintyInMeters", "class", "datasetKey", "dateIdentified", "day", "decimalLatitude", "decimalLongitude", "depth", "depthAccuracy", "eventDate", "family", "gbifID", "individualCount", "issue", "kingdom", "month", "scientificName", "taxonRank", "year")]
gbifa_2000to2009 = gbifa_2000to2009[c("coordinateUncertaintyInMeters", "class", "datasetKey", "dateIdentified", "day", "decimalLatitude", "decimalLongitude", "depth", "depthAccuracy", "eventDate", "family", "gbifID", "individualCount", "issue", "kingdom", "month", "scientificName", "taxonRank", "year")]

gbifa_2010to2019 = gbifa_2010to2019[c("coordinateUncertaintyInMeters", "class", "datasetKey", "dateIdentified", "day", "decimalLatitude", "decimalLongitude", "depth", "depthAccuracy", "eventDate", "family", "gbifID", "individualCount", "issue", "kingdom", "month", "scientificName", "taxonRank", "year")]
gbifa_2020to2024 = gbifa_2020to2024[c("coordinateUncertaintyInMeters", "class", "datasetKey", "dateIdentified", "day", "decimalLatitude", "decimalLongitude", "depth", "depthAccuracy", "eventDate", "family", "gbifID", "individualCount", "issue", "kingdom", "month", "scientificName", "taxonRank", "year")]

##End script Ia