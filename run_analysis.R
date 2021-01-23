## ---------------------------
##
## Script name: run_analysis.R
##
## Purpose of script: Tidying data for the Coursera course: Getting and Cleaning Data
##      - Merges the training and the test sets to create one data set.
##      - Extracts only the measurements on the mean and standard deviation for each measurement. 
##      - Uses descriptive activity names to name the activities in the data set
##      - Appropriately labels the data set with descriptive variable names. 
##      - From the data set in step 4, creates a second, independent tidy data set with the average of 
##              each variable for each activity and each subject.
## 
## Author: K. Limtao
##
## Date Created: 2019-01-23
##
## ---------------------------
##
## Notes: Using R Script template from Tim Ferris: https://timfarewell.co.uk/my-r-script-header-template/
##   
## ---------------------------
## load up the packages we will need:

require(data.table)
require(dplyr)

## ---------------------------
## Create and set directories

dataDirectory <- "./CourseraData"
if(!file.exists(dataDirectory)) {
        dir.create(dataDirectory)
}

## ---------------------------
## Download data from the interwebs

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, "CourseraData/UCIHARdataset.zip")
unzip("CourseraData/UCIHARdataset.zip", exdir = dataDirectory)

## ---------------------------
## Load up data sets
x_trainData <- tbl_df(read.table("CourseraData/UCI HAR Dataset/train/X_train.txt"))
y_trainData <- tbl_df(read.table("CourseraData/UCI HAR Dataset/train/y_train.txt", col.names = "activity"))
s_trainData <- tbl_df(read.table("CourseraData/UCI HAR Dataset/train/subject_train.txt", col.names = "subject"))

x_testData <- tbl_df(read.table("CourseraData/UCI HAR Dataset/test/X_test.txt"))
y_testData <- tbl_df(read.table("CourseraData/UCI HAR Dataset/test/y_test.txt", col.names = "activity"))
s_testData <- tbl_df(read.table("CourseraData/UCI HAR Dataset/test/subject_test.txt", col.names = "subject"))

## Prepare column names and factor levels for data sets
activities <- tbl_df(read.table("CourseraData/UCI HAR Dataset/activity_labels.txt", col.names = c("index", "activity")))
features <- tbl_df(read.table("CourseraData/UCI HAR Dataset/features.txt", col.names = c("index", "featureFunction")))


## Merge the training and test sets to create one data set.
x_data <- rbind(x_trainData, x_testData)
names(x_data) <- features$featureFunction
y_data <- rbind(y_trainData, y_testData)
s_data <- rbind(s_trainData, s_testData)

mergedData <- cbind(x_data, y_data, s_data)

## ---------------------------
## Extract the measurements on the mean and standard deviation for each measurement.
meanVariables <- grep("mean", names(mergedData))
stdVariables <- grep("std", names(mergedData))
extractParameter <- c(meanVariables, stdVariables)
filteredData <- select(mergedData, sort(extractParameter), activity, subject)

## ---------------------------
## Use descriptive activity names to name the activities in the data set.
filteredData$activity <- activities[filteredData$activity, 2]


## ---------------------------
## Label the data set with descriptive variable names.

names(filteredData) <- gsub("^t", "Time", names(filteredData))
names(filteredData) <- gsub("^f", "Frequency", names(filteredData))
names(filteredData) <- gsub("mean()", "Mean", names(filteredData))
names(filteredData) <- gsub("std()", "STD", names(filteredData))
names(filteredData) <- gsub("meanFreq()", "MeanFrequency", names(filteredData))
names(filteredData) <- gsub("Acc", "Accelerometer", names(filteredData))
names(filteredData) <- gsub("Gyro", "Gyroscope", names(filteredData))
names(filteredData) <- gsub("Mag", "Magnitude", names(filteredData))

## ---------------------------
## Create a second, independent tidy data set with the average of each variable for each activity and each subject.

## group by each activity and each subject
groupedData <- group_by(filteredData, subject, activity)
tidyData <- summarize_all(groupedData, mean)

write.table(tidyData, "tidyData.txt", row.name = FALSE)
