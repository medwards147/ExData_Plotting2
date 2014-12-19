## Creates plot4.png and saves it to project folder

# Checks to see if data is loaded, if it isn't then it downloads it and create datasets it using data_load.R
if (!(exists('NEI')) source("data_load.R")

# I was able to determine that EI.Sector groups by fuel combusion then further down by coal
# I will filter by 'comb' first then filter the result by 'coal' to subset the data
# In order to filter by these strings, I need to use grepl to search for them

# Find string 'fuel comb'
comb <- grepl('fuel comb', SCC$EI.Sector, ignore.case = TRUE)

# Filter by comb (need dplyr loaded)
library(dplyr)
SCCfiltered <- filter(SCC, comb)

# Find coal only
coal <- grepl('coal', SCCfiltered$EI.Sector, ignore.case = TRUE)

# Filter by comb
SCCfiltered <- filter(SCCfiltered, coal)

# filtered NEI based on SCCfiltered
NEIfiltered <- filter(NEI, NEI$SCC %in% SCCfiltered$SCC)

# Create File
png(filename = "plot4.png", width = 480, height = 480)

# load ggplot2 library
library(ggplot2)

# Create barplot
g <- ggplot( NEIfiltered, aes( factor(year), Emissions/1000 ) )

# Add bars. Need to do stat="identity" in order to give the bars values
g <- g + geom_bar(stat="identity") 

# Add labels. Print method automatically called.
g + labs( x = "year", 
          y = expression("PM"[2.5]* " Emissions (Kilotons)"),
          title = expression("PM"[2.5]* " Emissions from Coal Combustion Sources by Year") )

# Turn plotting device off              
dev.off()