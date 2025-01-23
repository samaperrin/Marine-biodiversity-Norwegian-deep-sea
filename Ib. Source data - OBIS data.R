#Ib. OBIS data. 
setwd("//workingdirectory") #setting up the working directory.   

#Packages to be used
install.packages("robis") #this package allows to connect with the OBIS API.
library(robis) 

#Here are the 17 fields coinciding with GBIF. The field "depthAccuracy" will be added with corresponding NA values for next sections of the code.

#1. obis_1876to1899
obisb_1876to1899 <- occurrence(geometry = "POLYGON ((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))", startdate = as.Date("1876-01-01"), enddate = as.Date("1899-12-31"), absence = NULL, flags = NULL)
obisb_1876to1899 = obisb_1876to1899[c("coordinateUncertaintyInMeters", "class", "datasetName", "dateIdentified", "day", "decimalLatitude", "decimalLongitude", "depth", "eventDate", "family", "id", "individualCount", "flags", "kingdom", "maximumDepthInMeters", "minimumDepthInMeters", "month", "scientificName", "taxonRank", "year")]

#2. obis_1900to1909
obisb_1900to1909 <- occurrence(geometry = "POLYGON ((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))", startdate = as.Date("1900-01-01"), enddate = as.Date("1909-12-31"), absence = NULL, flags = NULL)
obisb_1900to1909 = obisb_1900to1909[c("coordinateUncertaintyInMeters", "class", "datasetName", "dateIdentified", "day", "decimalLatitude", "decimalLongitude", "depth", "eventDate", "family", "id", "individualCount", "flags", "kingdom", "maximumDepthInMeters", "minimumDepthInMeters", "month", "scientificName", "taxonRank", "year")]

#3. obis_1910to1919
obisb_1910to1919 <- occurrence(geometry = "POLYGON ((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))", startdate = as.Date("1910-01-01"), enddate = as.Date("1919-12-31"), absence = NULL, flags = NULL)
obisb_1910to1919 = obisb_1910to1919[c("coordinateUncertaintyInMeters", "class", "datasetName", "dateIdentified", "day", "decimalLatitude", "decimalLongitude", "depth", "eventDate", "family", "id", "individualCount", "flags", "kingdom", "maximumDepthInMeters", "minimumDepthInMeters", "month", "scientificName", "taxonRank", "year")]

#4. obis_1920to1929
obisb_1920to1929 <- occurrence(geometry = "POLYGON ((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))", startdate = as.Date("1920-01-01"), enddate = as.Date("1929-12-31"), absence = NULL, flags = NULL)
obisb_1920to1929 = obisb_1920to1929[c("coordinateUncertaintyInMeters", "class", "datasetName", "dateIdentified", "day", "decimalLatitude", "decimalLongitude", "depth", "eventDate", "family", "id", "individualCount", "flags", "kingdom", "maximumDepthInMeters", "minimumDepthInMeters", "month", "scientificName", "taxonRank", "year")]

#5. obis_1930to1939
obisb_1930to1939 <- occurrence(geometry = "POLYGON ((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))", startdate = as.Date("1930-01-01"), enddate = as.Date("1939-12-31"), absence = NULL, flags = NULL)
obisb_1930to1939 = obisb_1930to1939[c("coordinateUncertaintyInMeters", "class", "datasetName", "dateIdentified", "day", "decimalLatitude", "decimalLongitude", "depth", "eventDate", "family", "id", "individualCount", "flags", "kingdom", "maximumDepthInMeters", "minimumDepthInMeters", "month", "scientificName", "taxonRank", "year")]

#6. obis_1940to1949
obisb_1940to1949 <- occurrence(geometry = "POLYGON ((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))", startdate = as.Date("1940-01-01"), enddate = as.Date("1949-12-31"), absence = NULL, flags = NULL)
obisb_1940to1949 = obisb_1940to1949[c("coordinateUncertaintyInMeters", "class", "datasetName", "dateIdentified", "day", "decimalLatitude", "decimalLongitude", "depth", "eventDate", "family", "id", "individualCount", "flags", "kingdom", "maximumDepthInMeters", "minimumDepthInMeters", "month", "scientificName", "taxonRank", "year")]

#7. obis_1950to1959
obisb_1950to1959 <- occurrence(geometry = "POLYGON ((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))", startdate = as.Date("1950-01-01"), enddate = as.Date("1959-12-31"), absence = NULL, flags = NULL)
obisb_1950to1959 = obisb_1950to1959[c("coordinateUncertaintyInMeters", "class", "datasetName", "dateIdentified", "day", "decimalLatitude", "decimalLongitude", "depth", "eventDate", "family", "id", "individualCount", "flags", "kingdom", "maximumDepthInMeters", "minimumDepthInMeters", "month", "scientificName", "taxonRank", "year")]

#8. obis_1960to1969
obisb_1960to1969 <- occurrence(geometry = "POLYGON ((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))", startdate = as.Date("1960-01-01"), enddate = as.Date("1969-12-31"), absence = NULL, flags = NULL)
obisb_1960to1969 = obisb_1960to1969[c("coordinateUncertaintyInMeters", "class", "datasetName", "dateIdentified", "day", "decimalLatitude", "decimalLongitude", "depth", "eventDate", "family", "id", "individualCount", "flags", "kingdom", "maximumDepthInMeters", "minimumDepthInMeters", "month", "scientificName", "taxonRank", "year")]

#9. obis_1970to1979
obisb_1970to1979 <- occurrence(geometry = "POLYGON ((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))", startdate = as.Date("1970-01-01"), enddate = as.Date("1979-12-31"), absence = NULL, flags = NULL)
obisb_1970to1979 = obisb_1970to1979[c("coordinateUncertaintyInMeters", "class", "datasetName", "dateIdentified", "day", "decimalLatitude", "decimalLongitude", "depth", "eventDate", "family", "id", "individualCount", "flags", "kingdom", "maximumDepthInMeters", "minimumDepthInMeters", "month", "scientificName", "taxonRank", "year")]

#10. obis_1980to1989
obisb_1980to1989 <- occurrence(geometry = "POLYGON ((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))", startdate = as.Date("1980-01-01"), enddate = as.Date("1989-12-31"), absence = NULL, flags = NULL)
obisb_1980to1989 = obisb_1980to1989[c("coordinateUncertaintyInMeters", "class", "datasetName", "dateIdentified", "day", "decimalLatitude", "decimalLongitude", "depth", "eventDate", "family", "id", "individualCount", "flags", "kingdom", "maximumDepthInMeters", "minimumDepthInMeters", "month", "scientificName", "taxonRank", "year")]

#11. obis_1990to1999  
obisb_1990to1999 <- occurrence(geometry = "POLYGON ((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))", startdate = as.Date("1990-01-01"), enddate = as.Date("1999-12-31"), absence = NULL, flags = NULL)
obisb_1990to1999 = obisb_1990to1999[c("coordinateUncertaintyInMeters", "class", "datasetName", "dateIdentified", "day", "decimalLatitude", "decimalLongitude", "depth", "eventDate", "family", "id", "individualCount", "flags", "kingdom", "maximumDepthInMeters", "minimumDepthInMeters", "month", "scientificName", "taxonRank", "year")]

#12. obis_2000to2009 
obisb_2000to2009 <- occurrence(geometry = "POLYGON ((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))", startdate = as.Date("2000-01-01"), enddate = as.Date("2009-12-31"), absence = NULL, flags = NULL)
obisb_2000to2009 = obisb_2000to2009[c("coordinateUncertaintyInMeters", "class", "datasetName", "dateIdentified", "day", "decimalLatitude", "decimalLongitude", "depth", "eventDate", "family", "id", "individualCount", "flags", "kingdom", "maximumDepthInMeters", "minimumDepthInMeters", "month", "scientificName", "taxonRank", "year")]

#13. obis_2010to2019
obisb_2010to2019 <- occurrence(geometry = "POLYGON ((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))", startdate = as.Date("2010-01-01"), enddate = as.Date("2019-12-31"), absence = NULL, flags = NULL)
obisb_2010to2019 = obisb_2010to2019[c("coordinateUncertaintyInMeters", "class", "datasetName", "dateIdentified", "day", "decimalLatitude", "decimalLongitude", "depth", "eventDate", "family", "id", "individualCount", "flags", "kingdom", "maximumDepthInMeters", "minimumDepthInMeters", "month", "scientificName", "taxonRank", "year")]

#14. obis_2020to2024                     
obisb_2020to2024 <- occurrence(geometry = "POLYGON ((38.000 85.000, -27.000 85.000, -27.000 56.000, 38.000 56.000, 38.000 85.000))", startdate = as.Date("2020-01-01"), absence = NULL, flags = NULL)
obisb_2020to2024 = obisb_2020to2024[c("coordinateUncertaintyInMeters", "class", "datasetName", "dateIdentified", "day", "decimalLatitude", "decimalLongitude", "depth", "eventDate", "family", "id", "individualCount", "flags", "kingdom", "maximumDepthInMeters", "minimumDepthInMeters", "month", "scientificName", "taxonRank", "year")]

##End script Ib