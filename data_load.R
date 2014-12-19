
# This script downloads the data, reads it, and subsets it for Project 2

# Get the file url
fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
# Create a temporary directory
td = tempdir()
# Create the placeholder file
tf = tempfile(tmpdir=td, fileext=".zip")
# Download into the placeholder file
download.file(fileUrl, tf)
                
# Create a list of files
fnames = unzip(tf, list = TRUE)$Name
# Unzip the files to the temporary directory
unzip(tf, files=fnames, exdir=td, overwrite=TRUE)
# Fpath is the full path to the extracted files
fpath = file.path(td, fnames)
                
# Load data
NEI <- readRDS(fpath[[2]])
SCC <- readRDS(fpath[[1]])

