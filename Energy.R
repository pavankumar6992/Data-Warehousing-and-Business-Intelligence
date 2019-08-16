getwd()
setwd("C:/Users/Pavan Kumar/Desktop/DWBI/WorkingDirectory/")
library(dplyr)
library(tidyr)
library(xml2)
library(rvest)
library(sqldf)


Oil_Production <- read.csv("C:/Users/Pavan Kumar/Desktop/DWBI/Energy/Crude_Oil_Production.csv")
Oil_Production <- Oil_Production[c(-1,-3:-7),]
colnames(Oil_Production) <- as.character(unlist(Oil_Production[1,]))
colnames(Oil_Production)[colnames(Oil_Production) == "1" ] <- 'Country' 
Oil_Production <- Oil_Production[-1,]
Oil_Production$Region <-  ifelse(Oil_Production$Country == 'Canada',"North America",
                                 ifelse(Oil_Production$Country == 'United States',"North America",                                                           
                                        ifelse(Oil_Production$Country == 'Argentina',"South and Central America",
                                               ifelse(Oil_Production$Country == 'Brazil',"South and Central America",
                                                      ifelse(Oil_Production$Country == 'Chile',"South and Central America",
                                                             ifelse(Oil_Production$Country == 'Colombia',"South and Central America",
                                                                    ifelse(Oil_Production$Country == 'Mexico',"South and Central America",
                                                                           ifelse(Oil_Production$Country == 'Venezuela',"South and Central America",
                                                                                  ifelse(Oil_Production$Country == 'China',"Asia Pacific",
                                                                                         ifelse(Oil_Production$Country == 'India',"Asia Pacific",
                                                                                                ifelse(Oil_Production$Country == 'Indonesia',"Asia Pacific",
                                                                                                       ifelse(Oil_Production$Country == 'Japan',"Asia Pacific",
                                                                                                              ifelse(Oil_Production$Country == 'Malaysia',"Asia Pacific",
                                                                                                                     ifelse(Oil_Production$Country == 'South Korea',"Asia Pacific",
                                                                                                                            ifelse(Oil_Production$Country == 'Taiwan',"Asia Pacific",
                                                                                                                                   ifelse(Oil_Production$Country == 'Thailand',"Asia Pacific",                                                 
                                                                                                                                          ifelse(Oil_Production$Country == 'Australia',"Asia Pacific",
                                                                                                                                                 ifelse(Oil_Production$Country == 'New Zealand',"Asia Pacific",
                                                                                                                                                        ifelse(Oil_Production$Country == 'South Africa',"Middle East and Africa",
                                                                                                                                                               ifelse(Oil_Production$Country == 'Algeria',"Middle East and Africa",
                                                                                                                                                                      ifelse(Oil_Production$Country == 'Egypt',"Middle East and Africa",
                                                                                                                                                                             ifelse(Oil_Production$Country == 'Nigeria',"Middle East and Africa",
                                                                                                                                                                                    ifelse(Oil_Production$Country == 'Iran',"Middle East and Africa",
                                                                                                                                                                                           ifelse(Oil_Production$Country == 'Kuwait',"Middle East and Africa",
                                                                                                                                                                                                  ifelse(Oil_Production$Country == 'Saudi Arabia',"Middle East and Africa", 
                                                                                                                                                                                                         ifelse(Oil_Production$Country == 'United Arab Emirates',"Middle East and Africa","Europe and CIS")))))))))))))))))))))))))) 
rownames(Oil_Production) <- c(1:nrow(Oil_Production))
Oil_Production <- Oil_Production[c(-1,-16,-21,-22,-25,-32,-41,-44,-49,-54,-55),]
Oil_Production <- Oil_Production[,c(1,24:28,32)]
Oil_Production <- Oil_Production[c(7,1:6)]
Oil_Production <- Oil_Production %>% gather(Year,Production,`2012`,`2013`,`2014`,`2015`,`2016`)
Oil_Production$Fuel_Type <- rep("Oil",nrow(Oil_Production))
Oil_Production <- Oil_Production[c(3,5,1,2,4)]
write.csv(Oil_Production,file = "Oil_Production.csv",row.names = FALSE)



Oil_Trade <- read.csv("C:/Users/Pavan Kumar/Desktop/DWBI/Energy/Crude_Oil_Trade.csv")
Oil_Trade <- Oil_Trade[c(-1,-3:-6),]
colnames(Oil_Trade) <- as.character(unlist(Oil_Trade[1,]))
colnames(Oil_Trade)[colnames(Oil_Trade) == "1" ] <- 'Country' 
Oil_Trade <- Oil_Trade[-1,]
Oil_Trade$Region <-         ifelse(Oil_Trade$Country == 'Canada',"North America",
                                   ifelse(Oil_Trade$Country == 'United States',"North America",                                                           
                                          ifelse(Oil_Trade$Country == 'Argentina',"South and Central America",
                                                 ifelse(Oil_Trade$Country == 'Brazil',"South and Central America",
                                                        ifelse(Oil_Trade$Country == 'Chile',"South and Central America",
                                                               ifelse(Oil_Trade$Country == 'Colombia',"South and Central America",
                                                                      ifelse(Oil_Trade$Country == 'Mexico',"South and Central America",
                                                                             ifelse(Oil_Trade$Country == 'Venezuela',"South and Central America",
                                                                                    ifelse(Oil_Trade$Country == 'China',"Asia Pacific",
                                                                                           ifelse(Oil_Trade$Country == 'India',"Asia Pacific",
                                                                                                  ifelse(Oil_Trade$Country == 'Indonesia',"Asia Pacific",
                                                                                                         ifelse(Oil_Trade$Country == 'Japan',"Asia Pacific",
                                                                                                                ifelse(Oil_Trade$Country == 'Malaysia',"Asia Pacific",
                                                                                                                       ifelse(Oil_Trade$Country == 'South Korea',"Asia Pacific",
                                                                                                                              ifelse(Oil_Trade$Country == 'Taiwan',"Asia Pacific",
                                                                                                                                     ifelse(Oil_Trade$Country == 'Thailand',"Asia Pacific",                                                 
                                                                                                                                            ifelse(Oil_Trade$Country == 'Australia',"Asia Pacific",
                                                                                                                                                   ifelse(Oil_Trade$Country == 'New Zealand',"Asia Pacific",
                                                                                                                                                          ifelse(Oil_Trade$Country == 'South Africa',"Middle East and Africa",
                                                                                                                                                                 ifelse(Oil_Trade$Country == 'Algeria',"Middle East and Africa",
                                                                                                                                                                        ifelse(Oil_Trade$Country == 'Egypt',"Middle East and Africa",
                                                                                                                                                                               ifelse(Oil_Trade$Country == 'Nigeria',"Middle East and Africa",
                                                                                                                                                                                      ifelse(Oil_Trade$Country == 'Iran',"Middle East and Africa",
                                                                                                                                                                                             ifelse(Oil_Trade$Country == 'Kuwait',"Middle East and Africa",
                                                                                                                                                                                                    ifelse(Oil_Trade$Country == 'Saudi Arabia',"Middle East and Africa", 
                                                                                                                                                                                                           ifelse(Oil_Trade$Country == 'United Arab Emirates',"Middle East and Africa","Europe and CIS")))))))))))))))))))))))))) 
rownames(Oil_Trade) <- c(1:nrow(Oil_Trade))
Oil_Trade <- Oil_Trade[c(-1,-16,-21,-22,-25,-32,-41,-44,-49,-54,-55),]
Oil_Trade <- Oil_Trade[,c(1,24:28,32)]
Oil_Trade <- Oil_Trade[c(7,1:6)]
Oil_Trade <- Oil_Trade %>% gather(Year,Trade,`2012`,`2013`,`2014`,`2015`,`2016`)
Oil_Trade$Fuel_Type <- rep("Oil",nrow(Oil_Trade))
Oil_Trade <- Oil_Trade[c(3,5,1,2,4)]
write.csv(Oil_Trade,file = "Oil_Trade.csv",row.names = FALSE)



Oil_Consumption <- read.csv("C:/Users/Pavan Kumar/Desktop/DWBI/Energy/Crude_Oil_Consumption.csv")
Oil_Consumption <- Oil_Consumption[c(-1,-3:-7),]
colnames(Oil_Consumption) <- as.character(unlist(Oil_Consumption[1,]))
colnames(Oil_Consumption)[colnames(Oil_Consumption) == "1" ] <- 'Country' 
Oil_Consumption <- Oil_Consumption[-1,]
Oil_Consumption$Region <-         ifelse(Oil_Consumption$Country == 'Canada',"North America",
                                         ifelse(Oil_Consumption$Country == 'United States',"North America",                                                           
                                                ifelse(Oil_Consumption$Country == 'Argentina',"South and Central America",
                                                       ifelse(Oil_Consumption$Country == 'Brazil',"South and Central America",
                                                              ifelse(Oil_Consumption$Country == 'Chile',"South and Central America",
                                                                     ifelse(Oil_Consumption$Country == 'Colombia',"South and Central America",
                                                                            ifelse(Oil_Consumption$Country == 'Mexico',"South and Central America",
                                                                                   ifelse(Oil_Consumption$Country == 'Venezuela',"South and Central America",
                                                                                          ifelse(Oil_Consumption$Country == 'China',"Asia Pacific",
                                                                                                 ifelse(Oil_Consumption$Country == 'India',"Asia Pacific",
                                                                                                        ifelse(Oil_Consumption$Country == 'Indonesia',"Asia Pacific",
                                                                                                               ifelse(Oil_Consumption$Country == 'Japan',"Asia Pacific",
                                                                                                                      ifelse(Oil_Consumption$Country == 'Malaysia',"Asia Pacific",
                                                                                                                             ifelse(Oil_Consumption$Country == 'South Korea',"Asia Pacific",
                                                                                                                                    ifelse(Oil_Consumption$Country == 'Taiwan',"Asia Pacific",
                                                                                                                                           ifelse(Oil_Consumption$Country == 'Thailand',"Asia Pacific",                                                 
                                                                                                                                                  ifelse(Oil_Consumption$Country == 'Australia',"Asia Pacific",
                                                                                                                                                         ifelse(Oil_Consumption$Country == 'New Zealand',"Asia Pacific",
                                                                                                                                                                ifelse(Oil_Consumption$Country == 'South Africa',"Middle East and Africa",
                                                                                                                                                                       ifelse(Oil_Consumption$Country == 'Algeria',"Middle East and Africa",
                                                                                                                                                                              ifelse(Oil_Consumption$Country == 'Egypt',"Middle East and Africa",
                                                                                                                                                                                     ifelse(Oil_Consumption$Country == 'Nigeria',"Middle East and Africa",
                                                                                                                                                                                            ifelse(Oil_Consumption$Country == 'Iran',"Middle East and Africa",
                                                                                                                                                                                                   ifelse(Oil_Consumption$Country == 'Kuwait',"Middle East and Africa",
                                                                                                                                                                                                          ifelse(Oil_Consumption$Country == 'Saudi Arabia',"Middle East and Africa", 
                                                                                                                                                                                                                 ifelse(Oil_Consumption$Country == 'United Arab Emirates',"Middle East and Africa","Europe and CIS")))))))))))))))))))))))))) 
rownames(Oil_Consumption) <- c(1:nrow(Oil_Consumption))
Oil_Consumption <- Oil_Consumption[c(-1,-16,-21,-22,-25,-32,-41,-44,-49,-54,-55),]
Oil_Consumption <- Oil_Consumption[,c(1,24:28,32)]
Oil_Consumption <- Oil_Consumption[c(7,1:6)]
Oil_Consumption <- Oil_Consumption %>% gather(Year,Consumption,`2012`,`2013`,`2014`,`2015`,`2016`)
Oil_Consumption$Fuel_Type <- rep("Oil",nrow(Oil_Consumption))
Oil_Consumption <- Oil_Consumption[c(3,5,1,2,4)]
write.csv(Oil_Consumption,file = "Oil_Consumption.csv",row.names = FALSE)



#-- Gas-----

Gas_Production <- read.csv("C:/Users/Pavan Kumar/Desktop/DWBI/Energy/Natural_Gas_Production.csv")
Gas_Production <- Gas_Production[c(-1,-3:-7),]
colnames(Gas_Production) <- as.character(unlist(Gas_Production[1,]))
colnames(Gas_Production)[colnames(Gas_Production) == "1" ] <- 'Country' 
Gas_Production <- Gas_Production[-1,]
Gas_Production$Region <-        ifelse(Gas_Production$Country == 'Canada',"North America",
                                       ifelse(Gas_Production$Country == 'United States',"North America",                                                           
                                              ifelse(Gas_Production$Country == 'Argentina',"South and Central America",
                                                     ifelse(Gas_Production$Country == 'Brazil',"South and Central America",
                                                            ifelse(Gas_Production$Country == 'Chile',"South and Central America",
                                                                   ifelse(Gas_Production$Country == 'Colombia',"South and Central America",
                                                                          ifelse(Gas_Production$Country == 'Mexico',"South and Central America",
                                                                                 ifelse(Gas_Production$Country == 'Venezuela',"South and Central America",
                                                                                        ifelse(Gas_Production$Country == 'China',"Asia Pacific",
                                                                                               ifelse(Gas_Production$Country == 'India',"Asia Pacific",
                                                                                                      ifelse(Gas_Production$Country == 'Indonesia',"Asia Pacific",
                                                                                                             ifelse(Gas_Production$Country == 'Japan',"Asia Pacific",
                                                                                                                    ifelse(Gas_Production$Country == 'Malaysia',"Asia Pacific",
                                                                                                                           ifelse(Gas_Production$Country == 'South Korea',"Asia Pacific",
                                                                                                                                  ifelse(Gas_Production$Country == 'Taiwan',"Asia Pacific",
                                                                                                                                         ifelse(Gas_Production$Country == 'Thailand',"Asia Pacific",                                                 
                                                                                                                                                ifelse(Gas_Production$Country == 'Australia',"Asia Pacific",
                                                                                                                                                       ifelse(Gas_Production$Country == 'New Zealand',"Asia Pacific",
                                                                                                                                                              ifelse(Gas_Production$Country == 'South Africa',"Middle East and Africa",
                                                                                                                                                                     ifelse(Gas_Production$Country == 'Algeria',"Middle East and Africa",
                                                                                                                                                                            ifelse(Gas_Production$Country == 'Egypt',"Middle East and Africa",
                                                                                                                                                                                   ifelse(Gas_Production$Country == 'Nigeria',"Middle East and Africa",
                                                                                                                                                                                          ifelse(Gas_Production$Country == 'Iran',"Middle East and Africa",
                                                                                                                                                                                                 ifelse(Gas_Production$Country == 'Kuwait',"Middle East and Africa",
                                                                                                                                                                                                        ifelse(Gas_Production$Country == 'Saudi Arabia',"Middle East and Africa", 
                                                                                                                                                                                                               ifelse(Gas_Production$Country == 'United Arab Emirates',"Middle East and Africa","Europe and CIS")))))))))))))))))))))))))) 
rownames(Gas_Production) <- c(1:nrow(Gas_Production))
Gas_Production <- Gas_Production[c(-1,-16,-21,-22,-25,-32,-41,-44,-49,-54,-55),]
Gas_Production <- Gas_Production[,c(1,24:28,32)]
Gas_Production <- Gas_Production[c(7,1:6)]
Gas_Production <- Gas_Production %>% gather(Year,Production,`2012`,`2013`,`2014`,`2015`,`2016`)
Gas_Production$Fuel_Type <- rep("Gas",nrow(Gas_Production))
Gas_Production <- Gas_Production[c(3,5,1,2,4)]
write.csv(Gas_Production,file = "Gas_Production.csv",row.names = FALSE)



Gas_Trade <- read.csv("C:/Users/Pavan Kumar/Desktop/DWBI/Energy/Natural_Gas_Trade.csv")
Gas_Trade <- Gas_Trade[c(-1,-3:-6),]
colnames(Gas_Trade) <- as.character(unlist(Gas_Trade[1,]))
colnames(Gas_Trade)[colnames(Gas_Trade) == "1" ] <- 'Country' 
Gas_Trade <- Gas_Trade[-1,]
Gas_Trade$Region <-    ifelse(Gas_Trade$Country == 'Canada',"North America",
                              ifelse(Gas_Trade$Country == 'United States',"North America",                                                           
                                     ifelse(Gas_Trade$Country == 'Argentina',"South and Central America",
                                            ifelse(Gas_Trade$Country == 'Brazil',"South and Central America",
                                                   ifelse(Gas_Trade$Country == 'Chile',"South and Central America",
                                                          ifelse(Gas_Trade$Country == 'Colombia',"South and Central America",
                                                                 ifelse(Gas_Trade$Country == 'Mexico',"South and Central America",
                                                                        ifelse(Gas_Trade$Country == 'Venezuela',"South and Central America",
                                                                               ifelse(Gas_Trade$Country == 'China',"Asia Pacific",
                                                                                      ifelse(Gas_Trade$Country == 'India',"Asia Pacific",
                                                                                             ifelse(Gas_Trade$Country == 'Indonesia',"Asia Pacific",
                                                                                                    ifelse(Gas_Trade$Country == 'Japan',"Asia Pacific",
                                                                                                           ifelse(Gas_Trade$Country == 'Malaysia',"Asia Pacific",
                                                                                                                  ifelse(Gas_Trade$Country == 'South Korea',"Asia Pacific",
                                                                                                                         ifelse(Gas_Trade$Country == 'Taiwan',"Asia Pacific",
                                                                                                                                ifelse(Gas_Trade$Country == 'Thailand',"Asia Pacific",                                                 
                                                                                                                                       ifelse(Gas_Trade$Country == 'Australia',"Asia Pacific",
                                                                                                                                              ifelse(Gas_Trade$Country == 'New Zealand',"Asia Pacific",
                                                                                                                                                     ifelse(Gas_Trade$Country == 'South Africa',"Middle East and Africa",
                                                                                                                                                            ifelse(Gas_Trade$Country == 'Algeria',"Middle East and Africa",
                                                                                                                                                                   ifelse(Gas_Trade$Country == 'Egypt',"Middle East and Africa",
                                                                                                                                                                          ifelse(Gas_Trade$Country == 'Nigeria',"Middle East and Africa",
                                                                                                                                                                                 ifelse(Gas_Trade$Country == 'Iran',"Middle East and Africa",
                                                                                                                                                                                        ifelse(Gas_Trade$Country == 'Kuwait',"Middle East and Africa",
                                                                                                                                                                                               ifelse(Gas_Trade$Country == 'Saudi Arabia',"Middle East and Africa", 
                                                                                                                                                                                                      ifelse(Gas_Trade$Country == 'United Arab Emirates',"Middle East and Africa","Europe and CIS")))))))))))))))))))))))))) 
rownames(Gas_Trade) <- c(1:nrow(Gas_Trade))
Gas_Trade <- Gas_Trade[c(-1,-16,-21,-22,-25,-32,-41,-44,-49,-54,-55),]
Gas_Trade <- Gas_Trade[,c(1,24:28,32)]
Gas_Trade <- Gas_Trade[c(7,1:6)]
Gas_Trade <- Gas_Trade %>% gather(Year,Trade,`2012`,`2013`,`2014`,`2015`,`2016`)
Gas_Trade$Fuel_Type <- rep("Gas",nrow(Gas_Trade))
Gas_Trade <- Gas_Trade[c(3,5,1,2,4)]
write.csv(Gas_Trade,file = "Gas_Trade.csv",row.names = FALSE)



Gas_Consumption <- read.csv("C:/Users/Pavan Kumar/Desktop/DWBI/Energy/Natural_Gas_Consumption.csv")
Gas_Consumption <- Gas_Consumption[c(-1,-3:-7),]
colnames(Gas_Consumption) <- as.character(unlist(Gas_Consumption[1,]))
colnames(Gas_Consumption)[colnames(Gas_Consumption) == "1" ] <- 'Country' 
Gas_Consumption <- Gas_Consumption[-1,]
Gas_Consumption$Region <-       ifelse(Gas_Consumption$Country == 'Canada',"North America",
                                       ifelse(Gas_Consumption$Country == 'United States',"North America",                                                           
                                              ifelse(Gas_Consumption$Country == 'Argentina',"South and Central America",
                                                     ifelse(Gas_Consumption$Country == 'Brazil',"South and Central America",
                                                            ifelse(Gas_Consumption$Country == 'Chile',"South and Central America",
                                                                   ifelse(Gas_Consumption$Country == 'Colombia',"South and Central America",
                                                                          ifelse(Gas_Consumption$Country == 'Mexico',"South and Central America",
                                                                                 ifelse(Gas_Consumption$Country == 'Venezuela',"South and Central America",
                                                                                        ifelse(Gas_Consumption$Country == 'China',"Asia Pacific",
                                                                                               ifelse(Gas_Consumption$Country == 'India',"Asia Pacific",
                                                                                                      ifelse(Gas_Consumption$Country == 'Indonesia',"Asia Pacific",
                                                                                                             ifelse(Gas_Consumption$Country == 'Japan',"Asia Pacific",
                                                                                                                    ifelse(Gas_Consumption$Country == 'Malaysia',"Asia Pacific",
                                                                                                                           ifelse(Gas_Consumption$Country == 'South Korea',"Asia Pacific",
                                                                                                                                  ifelse(Gas_Consumption$Country == 'Taiwan',"Asia Pacific",
                                                                                                                                         ifelse(Gas_Consumption$Country == 'Thailand',"Asia Pacific",                                                 
                                                                                                                                                ifelse(Gas_Consumption$Country == 'Australia',"Asia Pacific",
                                                                                                                                                       ifelse(Gas_Consumption$Country == 'New Zealand',"Asia Pacific",
                                                                                                                                                              ifelse(Gas_Consumption$Country == 'South Africa',"Middle East and Africa",
                                                                                                                                                                     ifelse(Gas_Consumption$Country == 'Algeria',"Middle East and Africa",
                                                                                                                                                                            ifelse(Gas_Consumption$Country == 'Egypt',"Middle East and Africa",
                                                                                                                                                                                   ifelse(Gas_Consumption$Country == 'Nigeria',"Middle East and Africa",
                                                                                                                                                                                          ifelse(Gas_Consumption$Country == 'Iran',"Middle East and Africa",
                                                                                                                                                                                                 ifelse(Gas_Consumption$Country == 'Kuwait',"Middle East and Africa",
                                                                                                                                                                                                        ifelse(Gas_Consumption$Country == 'Saudi Arabia',"Middle East and Africa", 
                                                                                                                                                                                                               ifelse(Gas_Consumption$Country == 'United Arab Emirates',"Middle East and Africa","Europe and CIS")))))))))))))))))))))))))) 
rownames(Gas_Consumption) <- c(1:nrow(Gas_Consumption))
Gas_Consumption <- Gas_Consumption[c(-1,-16,-21,-22,-25,-32,-41,-44,-49,-54,-55),]
Gas_Consumption <- Gas_Consumption[,c(1,24:28,32)]
Gas_Consumption <- Gas_Consumption[c(7,1:6)]
Gas_Consumption <- Gas_Consumption %>% gather(Year,Consumption,`2012`,`2013`,`2014`,`2015`,`2016`)
Gas_Consumption$Fuel_Type <- rep("Gas",nrow(Gas_Consumption))
Gas_Consumption <- Gas_Consumption[c(3,5,1,2,4)]
write.csv(Gas_Consumption,file = "Gas_Consumption.csv",row.names = FALSE)


Energy_Consumption <- rbind(Oil_Consumption,Gas_Consumption)
Energy_Production <- rbind(Oil_Production,Gas_Production)
Energy_Trade <- rbind(Oil_Trade,Gas_Trade)
Energy <- cbind.data.frame(Energy_Consumption,Energy_Production$Production,Energy_Trade$Trade)
colnames(Energy) <- c("Year","Fuel_Type","Region","Country","Consumption","Production","Trade")

Energy$Fuel_ID <- as.integer(factor(Energy$Fuel_Type))
Energy$Region_ID <- as.integer(factor(Energy$Region))
Energy$Country_ID <- as.integer(factor(Energy$Country))
Energy <- Energy[order(Energy$Region),]
Energy <- Energy[c(1,8,2,9,3,10,4,5,6,7)]
write.csv(Energy,file = "Energy.csv",row.names = FALSE) 

