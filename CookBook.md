#Clean Project

First call the library for data manipulation and point working directory to where the data is. The data is downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and unzipped.

```sh
  library(dplyr)
  setwd("/Users/sshen/Courses/clean_extract/project/UCI_HAR")
```

## Read in data
Read in features (X_), activities (Y_), study subject (sub_) files for both train and test sets. Also read in feature names (features.txt) and activity labels (activity_labels.txt).
```sh
  X_train = read.table("./train/X_train.txt")
  Y_train = read.table("./train/y_train.txt")
  sub_train = read.table("./train/subject_train.txt")
  X_test = read.table("./test/X_test.txt")
  Y_test = read.table("./test/y_test.txt")
  sub_test = read.table("./test/subject_test.txt")
  
  features = read.table("./features.txt")
  labels = read.table("./activity_labels.txt")
```

## Merges the training and the test sets to create one data set.
```sh
  feature_all = rbind(X_train, X_test)
  activity_all = rbind(Y_train, Y_test)
  subject_all = rbind(sub_train, sub_test)
```  

## Appropriately labels the data set with descriptive variable names. 
```sh
  names(feature_all) = features[,2]
  names(subject_all) = "subject"
```

## Uses descriptive activity names to name the activities in the data set
```sh
  activity <- merge(activity_all, labels, by.x="V1", by.y="V1")[,2] 
  names(activity) = "activity"
```

## Extracts only the measurements on the mean and standard deviation for each measurement. 

```sh
  mean_std = grep("mean|std", features$V2)
  subset = feature_all[,mean_std]
  tidy_df = cbind(subset, subject_all, activity)
```

## Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
```sh
  tidy_mean <-
    combined %>%
    group_by(subject, activity) %>%
    summarise_each(funs(mean))
``` 
## Output the second tidy data set
```sh
  write.table(tidy_mean,file="./tidy_mean.txt",row.name=FALSE)
```
The final data set has the following variables that are averages of mean and standard deviation of each measurement for each subject and activity. There are 35 observations and 81 variables. The variable names are:
"subject"                         "activity"                        "tBodyAcc-mean()-X"              
"tBodyAcc-mean()-Y"               "tBodyAcc-mean()-Z"               "tBodyAcc-std()-X"               
"tBodyAcc-std()-Y"                "tBodyAcc-std()-Z"                "tGravityAcc-mean()-X"           
"tGravityAcc-mean()-Y"            "tGravityAcc-mean()-Z"            "tGravityAcc-std()-X"            
"tGravityAcc-std()-Y"             "tGravityAcc-std()-Z"             "tBodyAccJerk-mean()-X"          
"tBodyAccJerk-mean()-Y"           "tBodyAccJerk-mean()-Z"           "tBodyAccJerk-std()-X"           
"tBodyAccJerk-std()-Y"            "tBodyAccJerk-std()-Z"            "tBodyGyro-mean()-X"             
"tBodyGyro-mean()-Y"              "tBodyGyro-mean()-Z"              "tBodyGyro-std()-X"              
"tBodyGyro-std()-Y"               "tBodyGyro-std()-Z"               "tBodyGyroJerk-mean()-X"         
"tBodyGyroJerk-mean()-Y"          "tBodyGyroJerk-mean()-Z"          "tBodyGyroJerk-std()-X"          
"tBodyGyroJerk-std()-Y"           "tBodyGyroJerk-std()-Z"           "tBodyAccMag-mean()"             
"tBodyAccMag-std()"               "tGravityAccMag-mean()"           "tGravityAccMag-std()"           
"tBodyAccJerkMag-mean()"          "tBodyAccJerkMag-std()"           "tBodyGyroMag-mean()"            
"tBodyGyroMag-std()"              "tBodyGyroJerkMag-mean()"         "tBodyGyroJerkMag-std()"         
"fBodyAcc-mean()-X"               "fBodyAcc-mean()-Y"               "fBodyAcc-mean()-Z"              
"fBodyAcc-std()-X"                "fBodyAcc-std()-Y"                "fBodyAcc-std()-Z"               
"fBodyAcc-meanFreq()-X"           "fBodyAcc-meanFreq()-Y"           "fBodyAcc-meanFreq()-Z"          
"fBodyAccJerk-mean()-X"           "fBodyAccJerk-mean()-Y"           "fBodyAccJerk-mean()-Z"          
"fBodyAccJerk-std()-X"            "fBodyAccJerk-std()-Y"            "fBodyAccJerk-std()-Z"           
"fBodyAccJerk-meanFreq()-X"       "fBodyAccJerk-meanFreq()-Y"       "fBodyAccJerk-meanFreq()-Z"      
"fBodyGyro-mean()-X"              "fBodyGyro-mean()-Y"              "fBodyGyro-mean()-Z"             
"fBodyGyro-std()-X"               "fBodyGyro-std()-Y"               "fBodyGyro-std()-Z"              
"fBodyGyro-meanFreq()-X"          "fBodyGyro-meanFreq()-Y"          "fBodyGyro-meanFreq()-Z"         
"fBodyAccMag-mean()"              "fBodyAccMag-std()"               "fBodyAccMag-meanFreq()"         
"fBodyBodyAccJerkMag-mean()"      "fBodyBodyAccJerkMag-std()"       "fBodyBodyAccJerkMag-meanFreq()" 
"fBodyBodyGyroMag-mean()"         "fBodyBodyGyroMag-std()"          "fBodyBodyGyroMag-meanFreq()"    
"fBodyBodyGyroJerkMag-mean()"     "fBodyBodyGyroJerkMag-std()"      "fBodyBodyGyroJerkMag-meanFreq()"
