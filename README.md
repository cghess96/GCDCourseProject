# Getting and Cleaning Data Final Course Project

This is the course project for the Coursera class 'Getting and Cleaning Data.'

The R script titled 'run_analysis.R' does the following:

1. Downloads the data from the supplied URL to the working directory
2. Unzips the dataset
3. Reads the unzipped files into R by creating variables
4. Assigns column names
5. Merges the training data and the test data to create one complete dataset
6. Extracts the mean and standard deviation for each measurement
7. Names activities in dataset by the activity labels
8. Creates a second tidy datset which includes the average of each variable and is repeated for each subject

The results are shown the file 'tidy.txt'