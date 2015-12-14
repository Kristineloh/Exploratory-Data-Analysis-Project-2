##Download file
if(!file.exists("./data2")){dir.create("./data2")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl,destfile="./data2/Dataset.zip",method="curl")

##Unzip file
unzip(zipfile="./data2/Dataset.zip",exdir="./data2")

NEI <- readRDS("~/Desktop/data2/summarySCC_PM25.rds")
SCC <- readRDS("~/Desktop/data2/Source_Classification_Code.rds")

motorvehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[motorvehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]

baltimoreVehiclesNEI <- vehiclesNEI[vehiclesNEI$fips==24510,]

## Plot 5
png("Plot5.png")

ggplot(baltimoreVehiclesNEI,aes(factor(year),Emissions)) +
        geom_bar(stat="identity",fill="black",width=0.75) +
        theme_bw() +  guides(fill=FALSE) +
        labs(x="year", y=expression("Total PM2.5 Emission (Tons)")) +
        labs(title=expression("PM2.5 Motor Vehicle Source Emissions in Baltimore from 1999-2008"))

dev.off()

