# Getting and Cleaning Data, Week 2 Quiz

setwd("/Users/fer/Dropbox/Coursera DS/Getting_Cleaning_Data/week_2")

# Question 1:  Register an application with the Github API here https://github.com/settings/applications.
# Access the API to get information on your instructors repositories (hint: this is the url you want
# "https://api.github.com/users/jtleek/repos"). Use this data to find the time that the datasharing
# repo was created.  What time was it created?

install.packages("jsonlite")
library("httr",jsonlite)
oauth_endpoints("github")

myapp <- oauth_app("jfertest", 
                   key = "aa1069dc69d329d8b7fe", 
                   secret = "cdb338543b67c9da798e946a3fe631a644668c43")

github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

gtoken <- config(token = github_token)

req <- GET("https://api.github.com/users/jtleek/repos", gtoken)

stop_for_status(req)
content(req)

json1 <- content(req)
jsonData <- jsonlite::fromJSON("https://api.github.com/users/jtleek/repos")

created_on <- cbind(jsonData$name, jsonData$created_at)
colnames(created_on) <- c("repo", "created on")
datasharing_created_on <- subset(created_on, created_on[, 1] == "datasharing")


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
contact <- download.file(url4, "contact.html", method = "curl")

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

noaa <- read.fwf("file5.for", widths = c(10, 3, 5, 5, 5, 5, 5, 5, 5), skip = 3, sep = "\t", header)
noaa[, -c(2)]



