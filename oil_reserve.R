setwd("C:/Users/Pavan Kumar/Desktop/DWBI/WorkingDirectory/")
library(dplyr)
library(tidyr)
library(xml2)
library(rvest)
library(sqldf)

Gas_Reserve <- read.csv("C:/Users/Pavan Kumar/Desktop/DWBI/Energy/Natural_Gas_Reserves.csv")
colnames(Gas_Reserve) <- as.character(unlist(Gas_Reserve[2,]))
Gas_Reserve <- Gas_Reserve[c(-1:-2),c(-2,-3,-9,-10)]
colnames(Gas_Reserve)[colnames(Gas_Reserve) == "1" ] <- 'Region' 
Gas_Reserve <- Gas_Reserve %>% gather(Year,Reserves_in_Percentage,`2012`,`2013`,`2014`,`2015`,`2016`,-Region)
write.csv(Gas_Reserve,file = "Gas_Reserve.csv", row.names = FALSE)



Oil_Reserve <- read.csv("C:/Users/Pavan Kumar/Desktop/DWBI/Energy/Oil_Reserves.csv")
colnames(Oil_Reserve) <- as.character(unlist(Oil_Reserve[2,]))
Oil_Reserve <- Oil_Reserve[c(-1:-3),c(-2,-3,-9)]
colnames(Oil_Reserve)[colnames(Oil_Reserve) == "" ] <- 'Region' 
Oil_Reserve <- Oil_Reserve %>% gather(Year,Reserves_in_BillionBarrels,`2012`,`2013`,`2014`,`2015`,`2016`,-Region)



Oil_Reserve1 <- split( Oil_Reserve , f = Oil_Reserve$Year)
a <- Oil_Reserve1[1]
a <- as.data.frame(a)
a$X2012.Reserves_in_BillionBarrels = as.numeric(a$X2012.Reserves_in_BillionBarrels)
a$percentage = (a$X2012.Reserves_in_BillionBarrels / sum(a$X2012.Reserves_in_BillionBarrels)) * 100
colnames(a) <- c("Region","Year","Reserves_in_billion_barrels","Percentage")

b <- Oil_Reserve1[2]
b <- as.data.frame(b)
b$X2013.Reserves_in_BillionBarrels = as.numeric(b$X2013.Reserves_in_BillionBarrels)
b$percentage = (b$X2013.Reserves_in_BillionBarrels / sum(b$X2013.Reserves_in_BillionBarrels)) * 100
colnames(b) <-  c("Region","Year","Reserves_in_billion_barrels","Percentage")

c <- Oil_Reserve1[3]
c <- as.data.frame(c)
c$X2014.Reserves_in_BillionBarrels = as.numeric(c$X2014.Reserves_in_BillionBarrels)
c$percentage = (c$X2014.Reserves_in_BillionBarrels / sum(c$X2014.Reserves_in_BillionBarrels)) * 100
colnames(c) <-  c("Region","Year","Reserves_in_billion_barrels","Percentage")

d <- Oil_Reserve1[4]
d <- as.data.frame(d)
d$X2015.Reserves_in_BillionBarrels = as.numeric(d$X2015.Reserves_in_BillionBarrels)
d$percentage = (d$X2015.Reserves_in_BillionBarrels / sum(d$X2015.Reserves_in_BillionBarrels)) * 100
colnames(d) <-  c("Region","Year","Reserves_in_billion_barrels","Percentage")

e <- Oil_Reserve1[5]
e <- as.data.frame(e)
e$X2016.Reserves_in_BillionBarrels = as.numeric(e$X2016.Reserves_in_BillionBarrels)
e$percentage = (e$X2016.Reserves_in_BillionBarrels / sum(e$X2016.Reserves_in_BillionBarrels)) * 100
colnames(e) <-  c("Region","Year","Reserves_in_billion_barrels","Percentage")


Oil_Reserve <- rbind(a,b,c,d,e)
write.csv(Oil_Reserve,file = "Oil_Reserve.csv", row.names = FALSE)
Oil_Reserve$Percentage <- format(round(Oil_Reserve$Percentage, 2), nsmall = 2)

Gas_Reserve <- Gas_Reserve[order(Gas_Reserve$Region),]
Oil_Reserve <- Oil_Reserve[order(Oil_Reserve$Region),]
Oil_Reserve <- Oil_Reserve[c(1,2,4)]
Gas_Reserve$Fuel_Type <- rep("Gas",nrow(Gas_Reserve))
Oil_Reserve$Fuel_Type <- rep("Oil",nrow(Oil_Reserve))
colnames(Oil_Reserve) <- c("Region","Year","Reserves_in_Percentage","Fuel_Type")

middle <- sqldf("Select Region,Year,sum(Reserves_in_Percentage) as Reserves_in_Percentage,Fuel_Type from Gas_Reserve where Region = 'Africa' or Region = 'Middle East' group by Year")
middle$Region <- gsub("Middle East",middle$Region,"Middle East and Africa")
Gas_Reserve <- sqldf("Select * from Gas_Reserve where Region != 'Africa' and Region != 'Middle East'")
Gas_Reserve <- rbind(Gas_Reserve,middle)

middle <- sqldf("Select Region,Year,sum(Reserves_in_Percentage) as Reserves_in_Percentage,Fuel_Type from Oil_Reserve where Region = 'Africa' or Region = 'Middle East' group by Year")
middle$Region <- gsub("Middle East",middle$Region,"Middle East and Africa")
Oil_Reserve <- sqldf("Select * from Oil_Reserve where Region != 'Africa' and Region != 'Middle East'")
Oil_Reserve <- rbind(Oil_Reserve,middle)

Oil_Reserve[order(Oil_Reserve[,1]),]
Gas_Reserve[order(Gas_Reserve[,1]),]

Reserve <- rbind(Gas_Reserve,Oil_Reserve)
Reserve$Fuel_ID <- as.integer(factor(Reserve$Fuel_Type))
Reserve <- Reserve[order(Reserve$Region),]
Reserve$Region_ID <- rep(c(1,2,4,5,3),each=10)


write.csv(Reserve,file = "Reserve.csv",row.names = FALSE) 
