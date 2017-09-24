# Getting and Cleaning Data: Week 4 Peer Reviewed Project
# You should create one R script called run_analysis.R that does the following.

# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement.
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names.
# From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

# Data source URL and filename
url1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
file1 <- "dataset.zip"

# Include libraries for r
library(dplyr)
library(tidyr)
library(readr)

# Checks if file exists, and avoids downloading it if already there (big file)
if(!file.exists(file1)) {
    dataset <- download.file(url1, destfile = file1, method = "curl")
    unzip(file1, exdir = ".")
}

# Read features names into R, selecting only the 2nd column as the 1st column is just an index
featdir <- "UCI HAR Dataset/features.txt"
features <- read.table(featdir)[,2]

# Read activity keys into R and add useful descriptions to the column names
actdir <- "UCI HAR Dataset/activity_labels.txt"
actlab <- read.table(actdir)
colnames(actlab) <- c("Key", "Activity_Description")

# Read test data into R, including base test, subject test, and activity codes
xtest <- "UCI HAR Dataset/test/X_test.txt"
subtest <-  "UCI HAR Dataset/test/subject_test.txt"
acttest <-  "UCI HAR Dataset/test/y_test.txt"

test <- read.table(xtest)
testsub <- read.table(subtest)
testact <- read.table(acttest)


# Read train data into R
xtrain <- "UCI HAR Dataset/train/X_train.txt"
subtrain <- "UCI HAR Dataset/train/subject_train.txt"
acttrain <- "UCI HAR Dataset/train/y_train.txt"

trainsub <- read.table(subtrain)
subact <- read.table(acttrain)
train <- read.table(xtrain)

# Join test and train data
jointt <- rbind(test, train)

# Name the data with the features labels
colnames(jointt) <- features 

# Use grep to select only columns containing the strings "mean" or "std" for average and standard deviation
jointt.ms <- jointt[, grep("mean|std", colnames(jointt))]

# Join subject data, test first, then training, then name the columns as subject
joinsub <- rbind(testsub, trainsub)
colnames(joinsub) <- "Subject"

# Join activity data, test first, then trining, then name the columns as activity
joinact <- rbind(testact, subact)
colnames(joinact) <- "Activity"

# Join features, subject, and activity datasets, then merge with the activity labels to add a useful description
joinall <- cbind(jointt.ms, joinsub, joinact)
joinfinal <- tbl_df(merge(joinall, actlab, by.x = "Activity", by.y = "Key"))

# Chain commands to group by subject and activity description, then use summarize_all to create a mean for each column and 
# sort by subject, then activity
jointidy <- joinfinal %>% 
    group_by(Subject, Activity_Description) %>%
    summarize_all(mean) %>% 
    arrange(Subject, Activity)

# Write tidy file as a CSV
write_csv(jointidy, "tidy.csv")





