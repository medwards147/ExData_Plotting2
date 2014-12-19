## Creates plot3.png and saves it to project folder

# Checks to see if data is loaded, if it isn't then it downloads it and create datasets it using data_load.R
if (!(exists('NEI')) source("data_load.R")

# Select all rows where fips equal 24510 representing Baltimore, MD
NEI_BAL <- NEI[NEI$fips == "24510",]

# Create plot but need to summarize the data by year first
aggbyyear <- aggregate(Emissions ~ year, NEI_BAL, sum )

# Create File
png(filename = "plot3.png", width = 480, height = 480)

# load ggplot2 library
library(ggplot2)

# Create barplot
g <- ggplot( NEI_BAL, aes( factor(year), Emissions ) )

# Add bars. Need to do stat="identity" in order to give the bars values
g <- g + geom_bar(stat="identity") 

# Add facet_grid to seperate out graphs by type
g <- g + facet_grid(. ~ type )

# Add labels. Note: Print method automatically called.
g + labs( x = "year", 
          y = expression("PM"[2.5]* " Emissions (Tons)"),
          title = expression("Baltimore, MD PM"[2.5]* " Emissions by Year by Source Type") )

# Turn plotting device off              
dev.off()