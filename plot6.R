## Creates plot6.png and saves it to project folder

# Checks to see if data is loaded, if it isn't then it downloads it and create datasets it using data_load.R
if (!(exists('NEI')) source("data_load.R")

# Find string 'vehicle'. SCC.Level.Two covers all vehicles (SCC.Level.One categorizes to Mobile Sources)
vehicles <- grepl('vehicle', SCC$SCC.Level.Two, ignore.case = TRUE)

# Filter by comb (need dplyr loaded)
library(dplyr)
SCCfiltered <- filter(SCC, vehicles)

# subset NEI based on SCCfiltered
NEIfiltered <- filter(NEI, NEI$SCC %in% SCCfiltered$SCC)

# Filter by Baltimore
NEIfiltered_Bal <- filter(NEIfiltered, fips == "24510" )

# Filter by LA
NEIfiltered_LA <- filter(NEIfiltered, fips == "06037" )

# Combine data
NEIcombined <- rbind(NEIfiltered_Bal, NEIfiltered_LA)

# Create File
png(filename = "plot6.png", width = 720, height = 720)

# load ggplot2 library
library(ggplot2)

# Create barplot
g <- ggplot( NEIcombined, aes( factor(year), Emissions/1000 ) )

# Add bars. Need to do stat="identity" in order to give the bars values
g <- g + geom_bar(stat="identity") 

# Add facets to seperate LA and Baltimore
g <- g + facet_grid( . ~ fips)

# Add labels. Print method automatically called.
g + labs( x = "year", 
          y = expression("PM"[2.5]* " Emissions (Kilotons)"),
          title = expression("PM"[2.5]* " Emissions from Motor Vehicles in 
                             LA (06037) and Baltimore (24510) by Year") )

# Turn plotting device off              
dev.off()