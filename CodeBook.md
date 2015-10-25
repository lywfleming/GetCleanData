##Project Description

The purpose of this project is to download raw data files from the [Human Activity Recognition Using Smartphones Dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and provide an output file with each mean and standard deviation for each sensor variable averaged per subject (30 total) tested and the activity (6 options) they were performing at the time.

##Study design and data processing

###Collection of the raw data

Data was extracted from the zip file:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Within this list of files is the Readme.txt that describes how the data was collected and stored. For our purposes, the following files were read in:

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

###Notes on the original (raw) data

Recognition goes to:

Human Activity Recognition Using Smartphones Dataset
Version 1.0

Jorge L. Reyes-Ortiz(1,2), Davide Anguita(1), Alessandro Ghio(1), Luca Oneto(1) and Xavier Parra(2)
1 - Smartlab - Non-Linear Complex Systems Laboratory
DITEN - Università  degli Studi di Genova, Genoa (I-16145), Italy. 
2 - CETpD - Technical Research Centre for Dependency Care and Autonomous Living
Universitat Politècnica de Catalunya (BarcelonaTech). Vilanova i la Geltrú (08800), Spain
activityrecognition '@' smartlab.ws 

##Creating the tidy data file
###Guide to create the tidy data file
The run_analysis.R script works with the Human Activity Recognition Using Smartphones Dataset.
The mean() and std() for each variable (excluding 'meanFreq') were extracted 
from the "train" and "test" data sets and then combined. The mean for each variable
associated with each Subject ID and subsetted with the Activity IDs. Activity IDs are properly
are properly named prior to writing to file.

1. Read in train data using read.table function:
   "train/subject_train.txt"- contains subject IDs. Data frame dimensions are 7352 x 1.

   "train/y_train.txt" - contains activity labels. Data frame dimensions are 7352 x 1.

   "train/X_train.txt" - contains raw measurement data for 561 variables. Data frame dimensions are 7352 x 561.

2. Read in test data using read.table function

   "test/subject_test.txt" - contains subject IDs. Data frame dimensions are 2947 x 1.

   "test/y_test.txt" - contains activity labels. Data frame dimensions are 2947 x 1.

   "test/X_test.txt" - contains raw measurement data for 561 variables. Data frame dimensions are 2947 x 561.

3. Read in measurement features from "features.txt" (data frame is 561 x 2) and extract mean() and std() variables (excluding meanFreq) using the 'grepl' function. Subset the raw data set with just the "mean()" and "std()" data (66 variables total).

4. Finally bind Subject, Activity, and remaining data columns for both the 'train' and 'test' data. Then, row bind the 'train' and 'test' data frames to make a complete data set with final dimensions 10299 x 68.

5. Order data by Subject ID and then with Activity ID using the 'order' function.

6. Group data first by Subject ID and then subset with Activity ID using the 'group_by' function. Calculate the mean for each measurement variable and use 'summarize_each' function.

7. Change activity label with descriptive name so it's easier to interpret data.
8. Write to file "tidy_data.txt" using 'write.table' function.


###Cleaning of the Data

##Description of the variables in the tidy_data.txt

Each of the variables in 3 - 27 are described in detail in the raw data Readme.txt file. The variable names were maintained in the output file so there would not be any confusion between the raw and tidy data set. Importantly, the tidy data set contains only the **MEANS** of each variable for each subject and the particular activity they were performing. The units for the accelerations 'Acc' are 'g's (gravity of earth = 9.80665 m/seg^2) and gyroscope 'Gyro' are rad/seg.

1. SubjectID - 1 to 30
2. Activity - one of six options (Walking, Walking Upstairs, Walking Downstairs, Sitting, Standing, Laying)
3. tBodyAcc-mean()-X, tBodyAcc-mean()-Y, tBodyAcc-mean()-Z
4. tBodyAcc-std()-X, tBodyAcc-std()-Y,tBodyAcc-std()-Z
5. tGravityAcc-mean()-X, tGravityAcc-mean()-Y, tGravityAcc-mean()-Z
6. tGravityAcc-std()-X, tGravityAcc-std()-Y, tGravityAcc-std()-Z
7. tBodyAccJerk-mean()-X, tBodyAccJerk-mean()-Y, tBodyAccJerk-mean()-Z
8. tBodyAccJerk-std()-X, tBodyAccJerk-std()-Y, tBodyAccJerk-std()-Z
9. tBodyGyro-mean()-X, tBodyGyro-mean()-Y, tBodyGyro-mean()-Z
10. tBodyGyro-std()-X, tBodyGyro-std()-Y, tBodyGyro-std()-Z
11. tBodyGyroJerk-mean()-X, tBodyGyroJerk-mean()-Y, tBodyGyroJerk-mean()-Z, 
12. tBodyGyroJerk-std()-X, tBodyGyroJerk-std()-Y, tBodyGyroJerk-std()-Z
13. tBodyAccMag-mean(), tBodyAccMag-std()
14. tGravityAccMag-mean(), tGravityAccMag-std()
15. tBodyAccJerkMag-mean(), tBodyAccJerkMag-std()
16. tBodyGyroMag-mean(), tBodyGyroMag-std()
17. tBodyGyroJerkMag-mean(), tBodyGyroJerkMag-std()
18. fBodyAcc-mean()-X, fBodyAcc-mean()-Y, fBodyAcc-mean()-Z
19. fBodyAcc-std()-X, fBodyAcc-std()-Y, fBodyAcc-std()-Z
20. fBodyAccJerk-mean()-X, fBodyAccJerk-mean()-Y, fBodyAccJerk-mean()-Z
21. fBodyAccJerk-std()-X, fBodyAccJerk-std()-Y, fBodyAccJerk-std()-Z
22. fBodyGyro-mean()-X, fBodyGyro-mean()-Y, fBodyGyro-mean()-Z
23. fBodyGyro-std()-X, fBodyGyro-std()-Y, fBodyGyro-std()-Z
24. fBodyAccMag-mean(), fBodyAccMag-std()
25. fBodyBodyAccJerkMag-mean(), fBodyBodyAccJerkMag-std()
26. fBodyBodyGyroMag-mean(), fBodyBodyGyroMag-std()
27. fBodyBodyGyroJerkMag-mean(), fBodyBodyGyroJerkMag-std()
 
