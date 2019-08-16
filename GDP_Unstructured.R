library(stringr)
library(tesseract)
library(splitstackshape)

getwd()
setwd("C:/Users/Pavan Kumar/Desktop/DWBI/WorkingDirectory/")
eng <- tesseract("eng")
text <- ocr("https://www.wto.org/images/img_press/768tbl1_e.png",engine = eng)
North_America <- as.data.frame(substr(text,854,892))
South_Central_America <- as.data.frame(substr(text,893,943))
Europe_CIS <- as.data.frame(substr(text,944,975))
Asia_Pacific <- as.data.frame(substr(text,976,1004))
Middle_East <- as.data.frame(substr(text,1005,1044))

colnames(North_America) <- c("xxy")
North_America <- cSplit(North_America, "xxy", " ")
North_America[1,1] <- paste(North_America$xxy_1,North_America$xxy_2)
North_America <- North_America[,c(1,3,4,5,6,7)]
colnames(North_America) <- c("Region","2012","2013","2014","2015","2016")

colnames(South_Central_America) <- c("xxy")
South_Central_America <- cSplit(South_Central_America,"xxy"," ")
South_Central_America[1,1] <- paste(South_Central_America$xxy_01,South_Central_America$xxy_02,South_Central_America$xxy_03,South_Central_America$xxy_04)
South_Central_America <- South_Central_America[,c(1,5,6,7,8,10)]
colnames(South_Central_America) <- c("Region","2012","2013","2014","2015","2016")


colnames(Europe_CIS) <- c("xxy")
Europe_CIS <- cSplit(Europe_CIS,"xxy"," ")
Europe_CIS[1,1] <- paste(Europe_CIS$xxy_1,"and CIS")
Europe_CIS <- Europe_CIS[,c(1:6)]
colnames(Europe_CIS) <- c("Region","2012","2013","2014","2015","2016")

colnames(Asia_Pacific) <- c("xxy")
Asia_Pacific <- cSplit(Asia_Pacific,"xxy"," ")
Asia_Pacific[1,1] <- paste(Asia_Pacific$xxy_1," Pacific")
Asia_Pacific <- Asia_Pacific[,c(1:6)]
colnames(Asia_Pacific) <- c("Region","2012","2013","2014","2015","2016")

colnames(Middle_East) <- c("xxy")
Middle_East <- cSplit(Middle_East,"xxy", " ")
Middle_East[1,1] <- "Middle East"
Middle_East <- Middle_East[,c(1,4,5,6,7,8)]
colnames(Middle_East) <- c("Region","2012","2013","2014","2015","2016")
GDP_Growth <- rbind(North_America,South_Central_America,Europe_CIS,Asia_Pacific,Middle_East)
colnames(GDP_Growth) <- c("Region","2012","2013","2014","2015","2016")
GDP_Growth$`2012` <- as.numeric(GDP_Growth$`2012`)
GDP_Growth$`2013` <- as.numeric(GDP_Growth$`2013`)
GDP_Growth$`2014` <- as.numeric(GDP_Growth$`2014`)
GDP_Growth$`2015` <- as.numeric(GDP_Growth$`2015`)
GDP_Growth$`2016` <- as.numeric(GDP_Growth$`2016`)
GDP_Growth[3,2] <- -0.2
GDP_Growth[2,5] <- -1.0
GDP_Growth[2,6] <- -1.7
GDP_Growth <- GDP_Growth %>% gather(Year,Growth_in_Percentage,`2012`,`2013`,`2014`,`2015`,`2016`)

GDP_Growth <- GDP_Growth[order(GDP_Growth[,1]),]
GDP_Growth$Region_ID <- rep(c(4,5,2,1,3),each=5)
GDP_Growth$Region <- gsub(pattern = "Middle East",GDP_Growth$Region,replacement = "Middle East and Africa")
write.csv(GDP_Growth,file="GDP_Growth.csv",row.names = FALSE) 

