# Getting_and_Cleaning_Data_Coursera
Week 4 peer-graded assignment for the Coursera Getting and Cleaning Data course

The assignment has students get data from the UCI Machine Learning Repository. The exact data set is called the 'Human Activity Recognition Using Smartphones Data Set' which can be found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

This repo contains an R script, 'run_analysis.R', that performs the following tasks according to the assignment:

1. Merges the training and the test sets to create one data set.
    - The script reads in all training and test sets and binds the data into a new data table called 'mergedData'
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
    - The script selects only the columns of the 'mergedData' that contain mean and standard deviation values
    - The selected data is placed into a new data table called 'filteredData'
3. Uses descriptive activity names to name the activities in the data set
    - Using the activity names provided in the 'activity_labels.txt' file in the original data set, the script replaces the codified activities (e.g. 1-6) with the specified activity label
4. Appropriately labels the data set with descriptive variable names. 
    - The script renames the data set columns with names that are more easily interpreted by a human (e.g. Acc becomes Accelerometer)
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    - The script groups the 'filteredData' by the 'subject' and 'activity' columns such that an average can be taken for each of the variables by the activity type and subject
    - The output of the above step is placed into a new data table called 'tidyData'
    - A text file called 'tidyData.txt' is generated which pulls in the 'tidyData' data table
    - Use the command 'View(read.table("tidyData.txt", header = TRUE))' to see the tidy data in R.
    
This repo also contains a code book, 'CodeBook.md' which describes the variables, data, and code used to get and clean the data from the UCI Machine Learning Repository.
