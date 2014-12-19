## Creates plot1.png and saves it to project folder

# Checks to see if data is loaded, if it isn't then it downloads it and create datasets it using data_load.R
if (!(exists('NEI')) source("data_load.R")

# Create File
png(filename = "plot1.png", width = 480, height = 480)

# Create plot but need to summarize the data by year first
aggbyyear <- aggregate(Emissions ~ year, NEI, sum )

# Create barplot
barplot(aggbyyear$Emissions/10^6, 
      width = 1.5, 
      names.arg = aggbyyear$year,
      ylab = expression("PM"[2.5]* " Emissions (10^6 tons)"),
      main = expression("Total PM"[2.5]* " Emissions by Year"))

# Turn plotting device off              
dev.off()

