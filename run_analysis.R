# This script works with the Human Activity Recognition Using Smartphones Dataset.
# The mean() and std() for each variable (excluding 'meanFreq') were extracted 
# from the "train" and "test" data sets and then combined. The mean for each variable
# associated with each Subject ID and subsetted with the Activity IDs. Activity IDs are properly
# are properly named prior to writing to file.

# Read in train data

   trainsubjects_file <- "train/subject_train.txt"  # contains subject IDs
   trainsubjects <- read.table(trainsubjects_file)

   trainlabels_file<-"train/y_train.txt"   # contains activity labels
   trainlabels<-read.table(trainlabels_file)

   train_file<-"train/X_train.txt"  # contains raw measurment data
   train_data<-read.table(train_file)

# Read in test data

   testsubjects_file <- "test/subject_test.txt"
   testsubjects <- read.table(testsubjects_file)


   testlabels_file<-"test/y_test.txt"
   testlabels<-read.table(testlabels_file)

   test_file<-"test/X_test.txt"
   test_data<-read.table(test_file)

# Read in measurement features from "features.txt" and extract mean() and std()
# variables (excluding meanFreq)

   variables<-read.table("features.txt")

 # Extract columns with mean() and std() data

  # Second column of 'variables' contains variable names from file
     colnames(train_data) <- variables[,2]
     colnames(test_data) <- variables[,2]
  
  # Find out which variables are the 'mean()' and 'std()'
     vars_mean<-grepl("mean()", variables[,2], fixed = TRUE)
     vars_std<-grepl("std()", variables[,2], fixed = TRUE)
     vars_mean_std <- vars_mean | vars_std
     
  # Subset the raw data set with just the 'mean()' and 'std()' data   
     train_data_mean_std <- train_data[,vars_mean_std]
     colnames(train_data_mean_std) <- variables[vars_mean_std,2]

     test_data_mean_std <- test_data[,vars_mean_std]

# Finally bind Subject, Activity, and remaining data columns for both the 'train'
# and 'test' data. Then, row bind the 'train' and 'test' data frames to make a
# complete data set.

  all_train_data <- cbind(trainsubjects, trainlabels, train_data_mean_std)

  all_test_data <- cbind(testsubjects, testlabels, test_data_mean_std)

  data<- rbind( all_train_data, all_test_data)

  colnames(data)[1:2] <- c("SubjectID", "Activity")

# Order data by Subject ID and Activity ID.

  order_data <- data[order(data$SubjectID, data$Activity),]

# Group data first by Subject ID and then subset with Activity ID. Calculate the
# mean for each measurement variable.

final_data <- order_data %>% group_by(SubjectID, Activity) %>% summarize_each(funs(mean))

# Change activity label with descriptive name

for(i in 1:length(final_data$Activity)) {
  if(final_data$Activity[i] == 1) final_data$Activity[i] <- "Walking"
  if(final_data$Activity[i] == 2) final_data$Activity[i] <- "Walking Upstairs"
  if(final_data$Activity[i] == 3) final_data$Activity[i] <- "Walking Downstairs"
  if(final_data$Activity[i] == 4) final_data$Activity[i] <- "Sitting"
  if(final_data$Activity[i] == 5) final_data$Activity[i] <- "Standing"
  if(final_data$Activity[i] == 6) final_data$Activity[i] <- "Laying"
}

write.table(final_data, file = "tidy_data.txt", row.names = FALSE)
