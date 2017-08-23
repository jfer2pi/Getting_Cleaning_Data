# Getting and Cleaning Data, Week 2 Quiz

# Question 1:  Register an application with the Github API here https://github.com/settings/applications.
# Access the API to get information on your instructors repositories (hint: this is the url you want
# "https://api.github.com/users/jtleek/repos"). Use this data to find the time that the datasharing
# repo was created.  What time was it created?



# Question 2:  The sqldf package allows for execution of SQL commands on R 
# data frames. We will use the sqldf package to practice the queries we 
# might send with the dbSendQuery command in RMySQL.

# Install sqldf package

install.packages("sqldf")
library("sqldf")

# Download the American Community Survey data and load it into an R object called acs

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
acscsv <- download.file(url, "acs.csv", method = "curl")

acs <- read.csv("acs.csv", header = T)

# Question 3:  Using the same data frame you created in the previous problem, what is the equivalent
# function to unique(acs$AGEP)

# Answer: sqldf("select distinct AGEP from acs")


# Question 4:  How many characters are in the 10th, 20th, and 100th lines of HTML from this page

library("XML")

url4 <- "http://biostat.jhsph.edu/~jleek/contact.html"
contact <- download.file(url4, "contact.hmtl", method = "curl")

leekparse <- readLines("contact.html")

leek <- leekparse[c(10, 20, 30, 100)] 

q4 <- nchar(leek) 

# Question 5: Read this data set into R and report the sum of the numbers in the fourth of the nine columns.
# https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for
# Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for
# (Hint this is a fixed-width file format)

url5 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
file5 <- download.file(url5, "file5.for", method = "curl")

install.packages("foreign")
library("foreign")

noaa <- read.fwf("noaa.for.for", widths = 12, sep = " " header = T)
noaa



