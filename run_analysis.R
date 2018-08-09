### Download and unzip the dataset provided from Coursera site

# Download the dataset
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(URL, destfile = "/Users/dad/Documents/Coursera/Data-Science-Specialization/Course3GettingandCleaningData/GCDCourseProject/Dataset.zip")

# Unzip the dataset
unzip(zipfile = "/Users/dad/Documents/Coursera/Data-Science-Specialization/Course3GettingandCleaningData/GCDCourseProject/Dataset.zip", exdir = "/Users/dad/Documents/Coursera/Data-Science-Specialization/Course3GettingandCleaningData/GCDCourseProject")

### Read the files into R by creating variables

# Read the training data
x_train <- read.table("/Users/dad/Documents/Coursera/Data-Science-Specialization/Course3GettingandCleaningData/GCDCourseProject/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("/Users/dad/Documents/Coursera/Data-Science-Specialization/Course3GettingandCleaningData/GCDCourseProject/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("/Users/dad/Documents/Coursera/Data-Science-Specialization/Course3GettingandCleaningData/GCDCourseProject/UCI HAR Dataset/train/subject_train.txt")

# Read the test data
x_test <- read.table("/Users/dad/Documents/Coursera/Data-Science-Specialization/Course3GettingandCleaningData/GCDCourseProject/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("/Users/dad/Documents/Coursera/Data-Science-Specialization/Course3GettingandCleaningData/GCDCourseProject/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("/Users/dad/Documents/Coursera/Data-Science-Specialization/Course3GettingandCleaningData/GCDCourseProject/UCI HAR Dataset/test/subject_test.txt")

# Read the feature vector
features <- read.table("/Users/dad/Documents/Coursera/Data-Science-Specialization/Course3GettingandCleaningData/GCDCourseProject/UCI HAR Dataset/features.txt")

# Read the activity labels
activityLabels <- read.table("/Users/dad/Documents/Coursera/Data-Science-Specialization/Course3GettingandCleaningData/GCDCourseProject/UCI HAR Dataset/activity_labels.txt")

### Assign column names

# Assign column names for training data
colnames(x_train) <- features[,2] 
colnames(y_train) <- "activityId"
colnames(subject_train) <- "subjectId"

# Assign column names for test data
colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

# Assign column names for activity labels
colnames(activityLabels) <- c('activityId','activityType')

### Merge the training data and the test data to create one dataset

mrg_train <- cbind(y_train, subject_train, x_train)
mrg_test <- cbind(y_test, subject_test, x_test)
compData <- rbind(mrg_train, mrg_test)

### Extract mean and standard deviation for each measurement

# Read column names
colNames <- colnames(compData)

# Create vector in order to define ID, mean, and standard deviation 
MeanSTdev <- (grepl("activityId" , colNames) | grepl("subjectId" , colNames) | grepl("mean.." , colNames) | grepl("std.." , colNames))

# Create subset
subset_MeanSTdev <- compData[ , MeanSTdev == TRUE]

### Name activities in dataset by using the activity labels

ActivityNamesSet <- merge(subset_MeanSTdev, activityLabels, by='activityId', all.x=TRUE)

### Create a second tidy data set which includes the average of each variable and is repeated for each subject

# Make second tidy datset
secTidySet <- aggregate(. ~subjectId + activityId, ActivityNamesSet, mean)
secTidySet <- secTidySet[order(secTidySet$subjectId, secTidySet$activityId),]

# Write second tidy datset to txt file
write.table(secTidySet, "tidy.txt", row.name=FALSE)
