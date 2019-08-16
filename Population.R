getwd()
library(dplyr)
library(tidyr)
library(xml2)
library(rvest)
library(sqldf)
setwd("C:/Users/Pavan Kumar/Desktop/DWBI/WorkingDirectory/")
Population <- read.csv("C:/Users/Pavan Kumar/Desktop/DWBI/Energy/Population.csv")
Population <- Population[c(-1:-3),c(-2:-56,-62)]
row.names(Population) <- c(1:nrow(Population))
colnames(Population) <- as.character(unlist(Population[1,]))
colnames(Population)[colnames(Population) == "1" ] <- 'Country' 
Population <- Population[-1,]
Population <- Population[order(Population[,1]),]
row.names(Population) <- c(1:nrow(Population))
Population <- Population[c(3,9,12,20,28,37,44,45,46,56,66,82,87,110,111,112,117,119,121,127,150,157,173,175,178,181,194,195,200,201,206,218,125,222,233,237,238,244,249,250,251,252,255,257),]
row.names(Population) <- c(1:nrow(Population))
Population$`53` <- as.character(Population$`53`)
Population[36,1] <- "Taiwan"
Population <- Population %>% gather(Year,Population,-`53`)
colnames(Population) <- c("Country","Year","Population")
Population <- Population[c(2,1,3)]
Population$Region <-  ifelse(Population$Country == 'Canada',"North America",
                          ifelse(Population$Country == 'United States',"North America",                                                           
                                 ifelse(Population$Country == 'Argentina',"South and Central America",
                                        ifelse(Population$Country == 'Brazil',"South and Central America",
                                               ifelse(Population$Country == 'Chile',"South and Central America",
                                                      ifelse(Population$Country == 'Colombia',"South and Central America",
                                                             ifelse(Population$Country == 'Mexico',"South and Central America",
                                                                    ifelse(Population$Country == 'Venezuela',"South and Central America",
                                                                           ifelse(Population$Country == 'China',"Asia Pacific",
                                                                                  ifelse(Population$Country == 'India',"Asia Pacific",
                                                                                         ifelse(Population$Country == 'Indonesia',"Asia Pacific",
                                                                                                ifelse(Population$Country == 'Japan',"Asia Pacific",
                                                                                                       ifelse(Population$Country == 'Malaysia',"Asia Pacific",
                                                                                                              ifelse(Population$Country == 'South Korea',"Asia Pacific",
                                                                                                                     ifelse(Population$Country == 'Taiwan',"Asia Pacific",
                                                                                                                            ifelse(Population$Country == 'Thailand',"Asia Pacific",                                                 
                                                                                                                                   ifelse(Population$Country == 'Australia',"Asia Pacific",
                                                                                                                                          ifelse(Population$Country == 'New Zealand',"Asia Pacific",
                                                                                                                                                 ifelse(Population$Country == 'South Africa',"Middle East and Africa",
                                                                                                                                                        ifelse(Population$Country == 'Algeria',"Middle East and Africa",
                                                                                                                                                               ifelse(Population$Country == 'Egypt',"Middle East and Africa",
                                                                                                                                                                      ifelse(Population$Country == 'Nigeria',"Middle East and Africa",
                                                                                                                                                                             ifelse(Population$Country == 'Iran',"Middle East and Africa",
                                                                                                                                                                                    ifelse(Population$Country == 'Kuwait',"Middle East and Africa",
                                                                                                                                                                                           ifelse(Population$Country == 'Saudi Arabia',"Middle East and Africa", 
                                                                                                                                                                                                  ifelse(Population$Country == 'United Arab Emirates',"Middle East and Africa","Europe and CIS"))))))))))))))))))))))))))

Population$Country_ID <- as.integer(factor(Population$Country))
Population$Region_ID <- as.integer(factor(Population$Region))
Population <- Population[c(1,6,4,5,2,3)]
write.csv(Population,file="Population.csv", row.names = FALSE)
