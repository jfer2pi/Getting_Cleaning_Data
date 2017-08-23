# Week 1 Quiz:  Getting and Cleaning Data

# Question 1:  The American Community Survey distributes downloadable data about United States communities. 
# Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
# and load the data into R. The code book, describing the variable names is here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
# How many properties are worth $1,000,000 or more?

# Create handle for url
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

# Download file with destination and matching filetype
download.file(url, destfile = "idaho.csv", method = "curl")

# Read csv file into R
read.csv("idaho.csv", header = T) -> idaho
# Record download date
date_idaho <- date()

# Install data.table library
library(data.table)

# Create a data.table for Idaho data
idaho.dt <- data.table(idaho)

# Subset Idaho data for VAL = 24, which are homes with values above $1MM
subset(idaho.dt, VAL == 24) -> id.million

# Count the number of entries that are above $1MM
q1 <- nrow(id.million)

# Question 2:  Download the Excel spreadsheet on Natural Gas Aquisition Program here
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx
# Read rows 18-23 and columns 7-15 into R and assign the result to a variable called: dat
# What is the value of: sum(dat$Zip*dat$Ext,na.rm=T)?


# Get gas data in Excel format, create handle 
url2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"

# Download file into computer
download.file(url2, destfile = "gas.xlsx", method = "curl")

# Record download date
date_excel <- date()

# Install xlsx packages
#install.packages("xlsx")
library("xlsx")

# Rows and columns of interest
rowIndex <- 18:23
colIndex <- 7:14

# Read excel file into R, only with the relevant rows, columns of the first sheet
dat <- read.xlsx("gas.xlsx", sheetIndex = 1, colIndex = colIndex, rowIndex = rowIndex)

# Answer question 3
q3 <- sum(dat$Zip*dat$Ext, na.rm = T)


# Question 4:  Read the XML data on Baltimore restaurants from here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml
# How many restaurants have zip code 21231?

# Create handle
url4 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"

# Download file as an xml
baltimore <- download.file(url4, "baltimore.xml", method = "curl")

# Install xml packages
#install.packages("XML")
library(XML)

# Parse through the xml file
baltimore.parse <- xmlTreeParse("baltimore.xml", useInternal = T)

# Get root node
rootNode <- xmlRoot(baltimore.parse)

# Get root node name
xmlName(rootNode)

# Print out names of nodes below the root node
names(rootNode)

# Extract zip codes from data
zips <- xpathSApply(rootNode, "//zipcode",xmlValue)

# Subset all zip codes equal to zip code of interest
zips.want <- subset(zips, zips == "21231")

# Count number of elements
q4 <- length(zips.want)

# Question 5: he American Community Survey distributes downloadable data about United States communities. 
# Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv
# using the fread() command load the data into an R object DT
# The following are ways to calculate the average value of the variable: pwgtp15
# broken down by sex. Using the data.table package, which will deliver the fastest user time?

url5 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(url5, "gender.csv", method = "curl")

DT <- fread("gender.csv")

# Use system.time to measure elapsed times

# Option 1

times <- data.frame()

times <- rbind(times, system.time(mean(DT[DT$SEX==1,]$pwgtp15)) + system.time(mean(DT[DT$SEX==2,]$pwgtp15)))

colnames <- c("user", "system", "elapsed")
colnames(times) <- colnames
times <- rbind(times, system.time(sapply(split(DT$pwgtp15,DT$SEX),mean)))

times <- rbind(times, system.time(rowMeans(DT)[DT$SEX==1]) + system.time(rowMeans(DT)[DT$SEX==2]))
    
times <- rbind(times, system.time(tapply(DT$pwgtp15,DT$SEX,mean)))

times <- rbind(times, system.time(mean(DT$pwgtp15,by=DT$SEX))) #fastest

times <- rbind(times, system.time(DT[,mean(pwgtp15),by=SEX]))

times