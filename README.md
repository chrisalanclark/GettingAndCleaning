# GettingAndCleaning
## Course Project for Getting and Cleaning Data

The script run\_analysis.R will produce the required tidy dataset (tidy\_summary.txt) if run in a directory containing the source data, which can be downloaded at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.  
Download the zip file and extract it in the directory containing run\_analysis.R, then run the script to produce tidy\_summary.txt.  See Codebook.md for more details on the source data and the output summary data.  
The script first carries out some basic setup, setting some constants for file and directory names and reading in the feature names and activity labels:
```
## Required library
library(dplyr)

## Some constants for reading data files
DATASET_FOLDER<-"UCI HAR Dataset//"
DATAFILE_PREFIX<-"X_"
SUBJECT_PREFIX<-"subject_"
ACTIVITY_PREFIX<-"y_"

## Get the list of features from the source dataset
features<-read.table(paste(DATASET_FOLDER,"features.txt", sep=""),
                     col.names = c("index","feature"))
## Get the list of activity labels from the source dataset
activities<-read.table(paste(DATASET_FOLDER,"activity_labels.txt", sep=""),
                     col.names = c("index","activity"))
```
After that, the script follows the step-by-step instructions of the assignment.  

### 1. Merges the training and the test sets to create one data set
The code that merges the sets is:
```
## combine the train and test sets
df_all<-bind_rows(getData("train", features, drop=FALSE), 
                  getData("test", features, drop=FALSE))
```
which calls the function getData, shown here.
```
getData <-function (dtype="train", features, drop=TRUE) {
    ## function to get the features file, and attach the appropriate column names
    getDataFile <- function() 
        read.table(paste(DATAFILE_PREFIX,dtype,".txt", sep=""), 
                   col.names=features$feature)
    ## function to get the subject id vector
    getSubjectFile <-function() 
        read.table(paste(SUBJECT_PREFIX,dtype,".txt", sep=""), 
                   col.names=c("subject"))
    ## function to get the activity vector
    getActivityFile <- function() 
        read.table(paste(ACTIVITY_PREFIX,dtype,".txt", sep=""), 
                   col.names=c("activity"))
    
    ##Body of getData starts
    oldwd<-getwd()  ## so we can restore it later
    setwd(paste(DATASET_FOLDER,dtype, sep="")) ## change to folder for type
    df<-getDataFile()  ## get features
    if(drop) {
        df<-df[,grep(".*(\\.mean\\.|\\.std\\.).*", colnames(df))]
    }
    df<-bind_cols(getSubjectFile(),df)  ## get subject ids
    df<-bind_cols(getActivityFile(),df) ## get activity ids
    setwd(oldwd)  ## restore working directory
    df  ## and return the data frame
}
```
getData takes a type ("train" or "test"), a vector of feature names, and an optional boolean drop as arguments.  
getData has internal functions for reading the feature matrix, the subject id vector, and the activity code vector.  It reads the main data (the feature matrix), using the passed feature-name vector for column names, and then binds subject and activity vectors as columns to that data, before returning it.  getData also has an option to drop the columns that are not required from the feature matrix, although this option was not used here in order to preserve second step as a distinct step.

### 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

This instruction was interpreted as the mean and standard deviation where they were applied to signals (along with a number of other aggregate functions).  Although there were a number of other occurences of the term "mean" (e.g. in MeanFreqs), these were not considered to be included in the instruction above.
The code uses the 'select' verb from dplyr and a regular expression match to select the appropriate features.
```
## select only the columns we want (subject, activity, and those based on mean 
## or standard deviation)
df_all<-select(df_all, subject, activity, matches(".*(\\.mean\\.|\\.std\\.).*"))
```

### 3. Uses descriptive activity names to name the activities in the data set

The activity names from the original label set, which were loaded into activities at the beginning of the script, were used:

```
## replace the activity ids with their short description
df_all$activity<-activities$activity[match(df_all$activity, activities$index)]
```

### 4. Appropriately labels the data set with descriptive variable names. 

The naming schema chosen is described in detain in Codebook.md.  In summary, the basic schema from the source data was preserved, with some minor simplifications.  BodyAcc was replaced with Acc, and GravityAcc with Gravity, to slightly simplify the names of the signals.  X, Y, Z, and Mag follow the names of the signals, to indicate the signal-component/characteristic in question.  Finally mean and std indicate which aggregate function is at issue.
The renaming was accomplished by reading the column names into a vector, and then doing a series of substitutions using regular expressions. Finally, the modified vector was applied back to the column names of the data frame.
```
## get the column names, in order to rename them according to new naming 
## standards and get rid of '.'s (which are an artifact of using the old 
## feature names as column names: '-' and '(' and ')' were replaced with '.'
## when the feature name vector was applied as column names to the data frame)
columns<-colnames(df_all)

## drop Body and BodyBody from the column names
columns<-sub("(Body)+", "", columns)
## rename GravityAcc to just Gravity
columns<-sub("GravityAcc","Gravity", columns)
## Reorder XYZ and mean/std in column names, and get rid of excess '.'s
columns<-sub("\\.mean\\.\\.\\.X", ".X.mean", columns)
columns<-sub("\\.mean\\.\\.\\.Y", ".Y.mean", columns)
columns<-sub("\\.mean\\.\\.\\.Z", ".Z.mean", columns)
columns<-sub("\\.std\\.\\.\\.X", ".X.std", columns)
columns<-sub("\\.std\\.\\.\\.Y", ".Y.std", columns)
columns<-sub("\\.std\\.\\.\\.Z", ".Z.std", columns)
## Separate Mag in column names with a period to make it like XYZ
columns<-sub("Mag", ".Mag", columns)
## Get rid of excess '.'s
columns<-sub("\\.\\.", "", columns)

## set the new column names
colnames(df_all)<-columns
```

### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The tidy data set is created simply by grouping on activity and subject, then summarising each non-grouping variable by the mean function.  One additional mutate step is taken to preserve the count of the number of observations that went into each group, in case it is later required to calculates means by subject or by activity independently.
```
## Summarise, while preserving a count of the number of observations for each
## group
tidy_summary<-df_all %>%
    group_by(activity, subject) %>%
    mutate(observations=n()) %>%
    summarise_each(funs(mean))
```
The columns of the new data set are reordered to put the magnitude measures next to their corresponding XYZ measures, and to put the number of observations near the left after subject id and activity.
Finally, the new data set is written to disk.

```
reorder=c(1:2, 69, 3:5,33,6:8, 34, 9:11, 35, 12:14, 36, 15:17, 37, 18:20, 38, 
          21:23, 39, 24:26, 40, 27:29, 41, 30:32, 42:45, 61, 46:48, 
          62, 49:51, 63, 52:54, 64, 55:57, 65, 58:60, 66:68)

## Reorder the columns
tidy_summary<-tidy_summary[reorder]

## Output the table
write.table(tidy_summary, "tidy_summary.txt", row.names=FALSE)
```