### Getting and Cleaning Data - Coursera Data Science Course Project

###Overview of Data Source

This project details data related to wearable computing. The full description of the original data is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the original data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


###Objective

The objective of the project was to form a tidy data set from the data sourced above. This included merging train and test data sets as well as summarizing the data.

The attached R script (run_analysis.R) performs the following to clean up the data. Please ensure that the 'plyr' and 'dplyr' packages are installed before running the code.

  1. Merges the training and the test sets to create one data set.
  2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  3. Uses descriptive activity names to name the activities in the data set
  4. Appropriately labels the data set with descriptive variable names. 
  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each     activity and each subject.
  
Since the data includes a total of 30 subjects and 6 different activities, the final dataset includes 180 observations.
