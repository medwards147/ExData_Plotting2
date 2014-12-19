## Creates plot5.png and saves it to project folder

# Checks to see if data is loaded, if it isn't then it downloads it and create datasets it using data_load.R
if (!(exists('NEI')) source("data_load.R")

# Find string 'vehicle'. SCC.Level.Two covers all vehicles (SCC.Level.One categorizes to Mobile Sources)
vehicles <- grepl('vehicle', SCC$SCC.Level.Two, ignore.case = TRUE)

# Filter by comb (need dplyr loaded)
library(dplyr)
SCCfiltered <- filter(SCC, vehicles)

# subset NEI based on SCCfiltered and then by only fips = 24510 for Baltimore
NEIfiltered <- filter(NEI, NEI$SCC %in% SCCfiltered$SCC)
NEIfiltered <- filter(NEIfiltered, fips == "24510" )

# Create File
png(filename = "plot5.png", width = 480, height = 480)

# load ggplot2 library
library(ggplot2)

# Create barplot
g <- ggplot( NEIfiltered, aes( factor(year), Emissions ) )

# Add bars. Need to do stat="identity" in order to give the bars values
g <- g + geom_bar(stat="identity") 

# Add labels. Print method automatically called.
g + labs( x = "year", 
          y = expression("PM"[2.5]* " Emissions (tons)"),
          title = expression("PM"[2.5]* " Emissions from Motor Vehicles in Baltimore by Year") )

# Turn plotting device off              
dev.off()