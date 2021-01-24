The `run_analysis.R` script can be broken down into 10 sections that perform the activities necessary to complete the assignment:

1. Create the directory to download the data into
    - `CourseraData` folder is created in the working directory as a place to download files into
2. Download and unzip the data set from the UCI Machine Learning Repository
    - `UCI HAR Dataset` is the directory for the unzipped files
3. Read training and test files into data tables (note: some files have been converted into tibbles using the tbl_df() function in dplyr for ease of readout in the console)
    - `x_trainData` = `X_train.txt`
    - `y_trainData` = `y_train.txt`
    - `s_trainData` = `subject_train.txt`
    - `x_testData` = `X_test.txt`
    - `y_testData` = `y_test.txt`
    - `s_testData` = `subject_test.txt`
4. Read labels and features into data tables so that columns and activity factors can be renamed
    - `activities` = `activity_labels.txt`
    - `features` = `features.txt`
5. Merge the training and test sets to create one data set
    - `mergedData` is the new data table that contains the training and test sets; 10299 observations and 563 variables
6. Filter the columns in 'mergedData' to only keep the variables that have mean and standard deviation measurements
    - `filteredData` is the new data table that only contains the columns with mean and standard deviation measurements; 10299 observations and 81 variables
7. Use the activity labels from `activity_labels.txt` to rename the numerical values in the `activity` column
8. Rename the measurement columns so that shorthands are replaced with plain English
    - `t` is replaced with `Time`
    - `f` is replaced with `Frequency`
    - `mean()` is replaced with `Mean`
    - `std()` is replaced with `STD`
    - `meanFreq()` is replaced with `MeanFrequency`  
    - `Acc` is replaced with `Accelerometer`
    - `Gyro` is replaced with `Gyroscope`
    - `Mag` is replaced with `Magnitude`)
9. Data is grouped and averaged by subject and activity
    - `groupedData` is a data table that regroups the data by subject, then activity
    - `tidyData` is a data table that averages each measurement by subject and activity
10. The tidy data is then written into a new .txt file called `tidyData.txt`
    - The data set may be read back into R using the command `View(read.table("tidyData.txt", header = TRUE))`
