##Download file
if(!file.exists("./data2")){dir.create("./data2")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl,destfile="./data2/Dataset.zip",method="curl")

##Unzip file
unzip(zipfile="./data2/Dataset.zip",exdir="./data2")

NEI <- readRDS("~/Desktop/data2/summarySCC_PM25.rds")
SCC <- readRDS("~/Desktop/data2/Source_Classification_Code.rds")

PM25Totals <- aggregate(Emissions ~ year,NEI, sum)

##Plot 1
png("Plot1.png")
barplot((PM25Totals$Emissions)/10^3,names.arg = PM25Totals$year,xlab="Year",ylab="PM2.5 Emissions (10^3 Tons)",main="Total PM2.5 Emissions From All US Sources")

dev.off()