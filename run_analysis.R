## Getting and Cleaning Data Project
  library(dplyr)
  setwd("/Users/sshen/Courses/clean_extract/project/UCI_HAR")

## Read in data
  X_train = read.table("./train/X_train.txt")
  Y_train = read.table("./train/y_train.txt")
  sub_train = read.table("./train/subject_train.txt")
  X_test = read.table("./test/X_test.txt")
  Y_test = read.table("./test/y_test.txt")
  sub_test = read.table("./test/subject_test.txt")
  
  features = read.table("./features.txt")
  labels = read.table("./activity_labels.txt")
  
## Appropriately labels the data set with descriptive variable names. 
  feature_all = rbind(X_train, X_test)
  activity_all = rbind(Y_train, Y_test)
  subject_all = rbind(sub_train, sub_test)
  
## Get variable names
  names(feature_all) = features[,2]
  names(subject_all) = "subject"
  
## Uses descriptive activity names to name the activities in the data set
  activity <- merge(activity_all, labels, by.x="V1", by.y="V1")[,2] 
  names(activity) = "activity"
  
## Extracts only the measurements on the mean and standard deviation for each measurement. 
  mean_std = grep("mean|std", features$V2)
  subset = feature_all[,mean_std]
  
  ## Combine to get one dataset
  tidy_df = cbind(subset, subject_all, activity)
  
## Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  tidy_mean <-
    combined %>%
    group_by(subject, activity) %>%
    summarise_each(funs(mean))
  
## Output the second tidy data set
  write.table(tidy_mean,file="./tidy_mean.txt",row.name=FALSE)
  