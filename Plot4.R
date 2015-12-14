##Download file
if(!file.exists("./data2")){dir.create("./data2")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl,destfile="./data2/Dataset.zip",method="curl")

##Unzip file
unzip(zipfile="./data2/Dataset.zip",exdir="./data2")

NEI <- readRDS("~/Desktop/data2/summarySCC_PM25.rds")
SCC <- readRDS("~/Desktop/data2/Source_Classification_Code.rds")

##Subset Coal combustion data
combustionRelated <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coalRelated <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE)
coalCombustion <- (combustionRelated & coalRelated)
combustionSCC <- SCC[coalCombustion,]$SCC
combustionNEI <- NEI[NEI$SCC %in% combustionSCC,]

##Plot 4
png("Plot4.png")
ggplot(combustionNEI,aes(factor(year),Emissions/10^3,fill=type)) +
        geom_bar(stat="identity",width=0.75) +
        theme_bw() +  guides(fill=FALSE) +
        labs(x="year", y=expression("Total PM2.5 Emission (10^3 Tons)")) +
        labs(title=expression("PM2.5 Coal Combustion Source Emissions Across US from 1999-2008"))

dev.off()