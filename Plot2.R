##Download file
if(!file.exists("./data2")){dir.create("./data2")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl,destfile="./data2/Dataset.zip",method="curl")

##Unzip file
unzip(zipfile="./data2/Dataset.zip",exdir="./data2")

NEI <- readRDS("~/Desktop/data2/summarySCC_PM25.rds")
SCC <- readRDS("~/Desktop/data2/Source_Classification_Code.rds")

NEIBaltimore <- NEI[NEI$fips=="24510",]
PM25TotalsBaltimore <- aggregate(Emissions ~ year, NEIBaltimore,sum)

##Plot 2
png("Plot2.png")
barplot(PM25TotalsBaltimore$Emissions,names.arg = PM25TotalsBaltimore$year,xlab="Year",ylab="PM2.5 Emissions (Tons)",main="Total PM2.5 Emissions From Baltimore")

dev.off()