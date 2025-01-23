#Packages and GBIF keys 
#Thanks to all vontributors for knowledge and tools.
#For R packages and citations, run citation("package").
#Install and load these packages previously to running scripts.
#install with install.packages("package") and load with the command library.

library("EMODnetWFS")
#Krystalli A, Fernández-Bejarano S, Salmon M (????). _EMODnetWFS: Access EMODnet Web Feature Service data through R_. R package version
#2.0.1.9001. Integrated data products created under the European Marine Observation Data Network (EMODnet) Biology project
#(EASME/EMFF/2017/1.3.1.2/02/SI2.789013), funded by the by the European Union under Regulation (EU) No 508/2014 of the European Parliament and
#of the Council of 15 May 2014 on the European Maritime and Fisheries Fund, <https://github.com/EMODnet/EMODnetWFS>.

library("rgbif")  
#Chamberlain S, Barve V, Mcglinn D, Oldoni D, Desmet P, Geffert L, Ram K (2025). _rgbif: Interface to the Global Biodiversity Information
#Facility API_. R package version 3.8.0, <https://CRAN.R-project.org/package=rgbif>.
#Chamberlain S, Boettiger C (2017). “R Python, and Ruby clients for GBIF species occurrence data.” _PeerJ PrePrints_.
#<https://doi.org/10.7287/peerj.preprints.3304v1>.

library("robis")
#Provoost P, Bosch S (2022). _robis: Ocean Biodiversity Information System (OBIS) Client_. R package version 2.11.3,
#<https://CRAN.R-project.org/package=robis>.

library(cowplot)
#Wilke C (2024). _cowplot: Streamlined Plot Theme and Plot Annotations for 'ggplot2'_. R package version 1.1.3, <https://CRAN.R-project.org/package=cowplot>.

library(data.table)
#Barrett T, Dowle M, Srinivasan A, Gorecki J, Chirico M, Hocking T (2024). _data.table: Extension of `data.frame`_. R package version 1.15.4,
#<https://CRAN.R-project.org/package=data.table>.

library(directlabels)
#Hocking TD (2024). _directlabels: Direct Labels for Multicolor Plots_. R package version 2024.1.21,
#<https://CRAN.R-project.org/package=directlabels>.

library(downloader)
#Chang W (2015). _downloader: Download Files over HTTP and HTTPS_. R package version 0.4, <https://CRAN.R-project.org/package=downloader>.

library(dplyr)
#Wickham H, François R, Henry L, Müller K, Vaughan D (2023). _dplyr: A Grammar of Data Manipulation_. R package version 1.1.4,
#<https://CRAN.R-project.org/package=dplyr>.

library(exactextractr)
#Daniel Baston (2023). _exactextractr: Fast Extraction from Raster Datasets using Polygons_. R package version 0.10.0,
#<https://CRAN.R-project.org/package=exactextractr>.

library(ggplot2)
#H. Wickham. ggplot2: Elegant Graphics for Data Analysis. Springer-Verlag New York, 2016.

library(ggspatial)
#Dunnington D (2023). _ggspatial: Spatial Data Framework for ggplot2_. R package version 1.1.9,
#<https://CRAN.R-project.org/package=ggspatial>.

library(grid)
#R Core Team (2024). _R: A Language and Environment for Statistical Computing_. R Foundation for Statistical Computing, Vienna, Austria.
#<https://www.R-project.org/>.

library(gridExtra)
#Auguie B (2017). _gridExtra: Miscellaneous Functions for "Grid" Graphics_. R package version 2.3, <https://CRAN.R-project.org/package=gridExtra>.

library(IRdisplay)
#Kluyver T, Angerer P, Schulz J (2022). _IRdisplay: 'Jupyter' Display Machinery_. R package version 1.1,
#<https://CRAN.R-project.org/package=IRdisplay>.

library(janitor)
#Firke S (2023). _janitor: Simple Tools for Examining and Cleaning Dirty Data_. R package version 2.2.0,
#<https://CRAN.R-project.org/package=janitor>.

library(knitr)
#Xie Y (2024). _knitr: A General-Purpose Package for Dynamic Report Generation in R_. R package version 1.47, <https://yihui.org/knitr/>.
#Yihui Xie (2015) Dynamic Documents with R and knitr. 2nd edition. Chapman and Hall/CRC. ISBN 978-1498716963
#Yihui Xie (2014) knitr: A Comprehensive Tool for Reproducible Research in R. In Victoria Stodden, Friedrich Leisch and Roger D. Peng,
#editors, Implementing Reproducible Computational Research. Chapman and Hall/CRC. ISBN 978-1466561595

library(mapdata)
#Becker OScbRA, Brownrigg. ARWRvbR (2022). _mapdata: Extra Map Databases_. R package version 2.3.1,
#<https://CRAN.R-project.org/package=mapdata>.

library(ncdf4)
#Pierce D (2023). _ncdf4: Interface to Unidata netCDF (Version 4 or Earlier) Format Data Files_. R package version 1.22,
#<https://CRAN.R-project.org/package=ncdf4>.

library(rgdal)
#Bivand R, Keitt T, Rowlingson B (2023). _rgdal: Bindings for the 'Geospatial' Data Abstraction Library_. R package version 1.6-7/r1203,
#<https://R-Forge.R-project.org/projects/rgdal/>
  
library(raster)
#Hijmans R (2023). _raster: Geographic Data Analysis and Modeling_. R package version 3.6-26, <https://CRAN.R-project.org/package=raster>.

library(rasterVis)
#Oscar Perpinan Lamigueiro and Robert Hijmans (2023), rasterVis. R package version 0.51.6.

library(readxl)  
#Wickham H, Bryan J (2023). _readxl: Read Excel Files_. R package version 1.4.3, <https://CRAN.R-project.org/package=readxl>.

library(repr)
#Angerer P, Kluyver T, Schulz J (2024). _repr: Serializable Representations_. R package version 1.1.7,
#<https://CRAN.R-project.org/package=repr>.

library(reshape2)
#Hadley Wickham (2007). Reshaping Data with the reshape Package. Journal of Statistical Software, 21(12), 1-20. URL
#http://www.jstatsoft.org/v21/i12/.

library(rnaturalearth)
#Massicotte P, South A (2023). _rnaturalearth: World Map Data from Natural Earth_. R package version 1.0.1,
#<https://CRAN.R-project.org/package=rnaturalearth>.

library(rnaturalearthdata)
#South A, Michael S, Massicotte P (2024). _rnaturalearthdata: World Vector Map Data from Natural Earth Used in 'rnaturalearth'_. R package
#version 1.0.0, <https://CRAN.R-project.org/package=rnaturalearthdata>.

library(s2)
#Dunnington D, Pebesma E, Rubak E (2023). _s2: Spherical Geometry Operators Using the S2 Geometry Library_. R package version 1.1.6,
#<https://CRAN.R-project.org/package=s2>.

library(sf)
#Pebesma, E., & Bivand, R. (2023). Spatial Data Science: With Applications in R. Chapman and Hall/CRC. https://doi.org/10.1201/9780429459016
#Pebesma, E., 2018. Simple Features for R: Standardized Support for Spatial Vector Data. The R Journal 10 (1), 439-446,
#https://doi.org/10.32614/RJ-2018-009

library(sp)
#Pebesma E, Bivand R (2005). “Classes and methods for spatial data in R.” _R News_, *5*(2), 9-13. <https://CRAN.R-project.org/doc/Rnews/>.
#Bivand R, Pebesma E, Gomez-Rubio V (2013). _Applied spatial data analysis with R, Second edition_. Springer, NY. <https://asdar-book.org/>.

library(stars)
#Pebesma E, Bivand R (2023). _Spatial Data Science: With applications in R_. Chapman and Hall/CRC, London. doi:10.1201/9780429459016
#<https://doi.org/10.1201/9780429459016>, <https://r-spatial.org/book/>.

library(stringr)
#Wickham H (2023). _stringr: Simple, Consistent Wrappers for Common String Operations_. R package version 1.5.1,
#<https://CRAN.R-project.org/package=stringr>.

library(terra)
#Hijmans R (2024). _terra: Spatial Data Analysis_. R package version 1.7-78, <https://CRAN.R-project.org/package=terra>.

library(tibble)
#Müller K, Wickham H (2023). _tibble: Simple Data Frames_. R package version 3.2.1, <https://CRAN.R-project.org/package=tibble>.

library(tidyr)
#Wickham H, Vaughan D, Girlich M (2024). _tidyr: Tidy Messy Data_. R package version 1.3.1, <https://CRAN.R-project.org/package=tidyr>.

library(wdpar)
#Hanson JO (2022). “wdpar: Interface to the World Database on Protected Areas.” _Journal of Open Source Software_, *7*, 4594.
#doi:10.21105/joss.04594 <https://doi.org/10.21105/joss.04594>.
#UNEP-WCMC and IUCN (2023) Protected Planet: The World Database on Protected Areas (WDPA), v.1.3.7,
#Cambridge, UK: UNEP-WCMC and IUCN. Available at: www.protectedplanet.net.
#UNEP-WCMC and IUCN (2023) Protected Planet: The world database on other effective area-based conservation measures, v.1.3.7, Cambridge, UK: UNEP-WCMC and IUCN. Available at: www.protectedplanet.net.

library(XML)
#Temple Lang D (2024). _XML: Tools for Parsing and Generating XML Within R and S-Plus_. R package version 3.99-0.16.1,
#<https://CRAN.R-project.org/package=XML>.


#The GBIF keys used in this work and their citations are:

#gbif_1876to1899: 0015546-241007104925546
#GBIF.org (15 October 2024) GBIF Occurrence Download  https://doi.org/10.15468/dl.7q3w44

#gbif_1900to1909: 0015547-241007104925546
#GBIF.org (15 October 2024) GBIF Occurrence Download  https://doi.org/10.15468/dl.j87zrs

#gbif_1910to1919: 0015548-241007104925546
#GBIF.org (15 October 2024) GBIF Occurrence Download  https://doi.org/10.15468/dl.26bb98

#gbif_1920to1929: 0015664-241007104925546
#GBIF.org (15 October 2024) GBIF Occurrence Download  https://doi.org/10.15468/dl.8k5va3

#gbif_1930to1939: 0015665-241007104925546
#GBIF.org (15 October 2024) GBIF Occurrence Download  https://doi.org/10.15468/dl.arz5mm

#gbif_1940to1949: 0015666-241007104925546
#GBIF.org (15 October 2024) GBIF Occurrence Download  https://doi.org/10.15468/dl.x9jbcv

#gbif_1950to1959: 0015769-241007104925546
#GBIF.org (15 October 2024) GBIF Occurrence Download  https://doi.org/10.15468/dl.mrbmm9

#gbif_1960to1969: 0015770-241007104925546
#GBIF.org (15 October 2024) GBIF Occurrence Download  https://doi.org/10.15468/dl.4k6p8z                  

#gbif_1970to1979: 0015771-241007104925546
#GBIF.org (15 October 2024) GBIF Occurrence Download  https://doi.org/10.15468/dl.c4vbxa                  

#gbif_1980to1989: 0015858-241007104925546
#GBIF.org (15 October 2024) GBIF Occurrence Download  https://doi.org/10.15468/dl.ntf4qr

#gbif_1990to1999: 0015859-241007104925546
#GBIF.org (15 October 2024) GBIF Occurrence Download  https://doi.org/10.15468/dl.gj2a8q

#gbif_2000to2009: 0015860-241007104925546
#GBIF.org (15 October 2024) GBIF Occurrence Download  https://doi.org/10.15468/dl.xshx7q

#gbif_2010to2019: 0016726-241007104925546
#GBIF.org (16 October 2024) GBIF Occurrence Download  https://doi.org/10.15468/dl.cgx8eh

#gbif_2020to2024: 0016727-241007104925546
#GBIF.org (16 October 2024) GBIF Occurrence Download https://doi.org/10.15468/dl.c362rp

#End of script.
