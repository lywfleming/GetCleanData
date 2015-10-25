# Read in train data

trainsubjects_file <- "train/subject_train.txt"
trainsubjects <- read.table(trainsubjects_file)
#colnames(trainsubjects) <- ("Subject ID")

trainlabels_file<-"train/y_train.txt"
trainlabels<-read.table(trainlabels_file)

train_file<-"train/X_train.txt"
train_data<-read.table(train_file)

# Read in test data

testsubjects_file <- "test/subject_test.txt"
testsubjects <- read.table(testsubjects_file)


testlabels_file<-"test/y_test.txt"
testlabels<-read.table(testlabels_file)

test_file<-"test/X_test.txt"
test_data<-read.table(test_file)

# Read in activity features and extract mean() and std() variables

variables<-read.table("features.txt")

# Extract columns with mean() and std() data

colnames(train_data) <- variables[,2]
colnames(test_data) <- variables[,2]

vars_mean<-grepl("mean()", variables[,2], fixed = TRUE)
vars_std<-grepl("std()", variables[,2], fixed = TRUE)
vars_mean_std <- vars_mean | vars_std

train_data_mean_std <- train_data[,vars_mean_std]
colnames(train_data_mean_std) <- variables[vars_mean_std,2]

test_data_mean_std <- test_data[,vars_mean_std]

all_train_data <- cbind(trainsubjects, trainlabels, train_data_mean_std)

all_test_data <- cbind(testsubjects, testlabels, test_data_mean_std)

data<- rbind( all_train_data, all_test_data)

colnames(data)[1:2] <- c("SubjectID", "Activity")

#Split groups by Subject ID and then by Activity. Take average of all 
#variables.

order_data <- data[order(data$SubjectID, data$Activity),]

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
