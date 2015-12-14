##Download file
if(!file.exists("./data2")){dir.create("./data2")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl,destfile="./data2/Dataset.zip",method="curl")

##Unzip file
unzip(zipfile="./data2/Dataset.zip",exdir="./data2")

NEI <- readRDS("~/Desktop/data2/summarySCC_PM25.rds")
SCC <- readRDS("~/Desktop/data2/Source_Classification_Code.rds")

NEIBaltimore <- NEI[NEI$fips=="24510",]

library(ggplot2)

##Plot 3
png("Plot3.png")
ggplot(NEIBaltimore,aes(factor(year),Emissions,fill=type))+
        geom_bar(stat="identity")+
        theme_bw()+ 
        guides(fill=FALSE)+
        facet_grid(.~type,scales = "free",space="free")+
        labs(x="year", y=expression("Total PM2.5 Emission (Tons)"))+
        labs(title=expression("PM2.5 Emissions, Baltimore City 1999-2008 by Source Type"))

dev.off()