## Creates plot2.png and saves it to project folder

# Checks to see if data is loaded, if it isn't then it downloads it and create datasets it using data_load.R
if (!(exists('NEI')) source("data_load.R")

# Select all rows where fips equal 24510 representing Baltimore, MD
NEI_BAL <- NEI[NEI$fips == "24510",]

# Create File
png(filename = "plot2.png", width = 480, height = 480)

# Create plot but need to summarize the data by year first
aggbyyear <- aggregate(Emissions ~ year, NEI_BAL, sum )

# Create barplot
barplot(aggbyyear$Emissions, 
        width = 1.5, 
        names.arg = aggbyyear$year,
        ylab = expression("PM"[2.5]* " Emissions (Tons)"),
        main = expression("Baltimore, MD PM"[2.5]* " Emissions by Year"))

# Turn plotting device off              
dev.off()