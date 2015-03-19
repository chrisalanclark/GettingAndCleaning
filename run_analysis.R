## This script processes the data according to an interpretation of the
## instructions for the course project of Getting and Cleaning Data.  
## See README.MD for more details
## Make sure to set the working directory to the directory containing the 
## data as it is unzipped (that is, the directory containing the directory 
## "UCI HAR Dataset")
##  (e.g., on my setup, setwd("Coursera//JHDS//Getting and Cleaning Data//GettingAndCleaning"))

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


##############################################################################
## The getData function reads the features, subjects, and activities for either 
## the "train" set or the "test" set, and combines them into a single data frame.
## It optionally drops the features that are not based on our two targetted
## aggregate functions (mean and std).  Note however that this feature is not
## used in the script, in order to preserve the assignment's described order of 
## steps.
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

## combine the train and test sets
df_all<-bind_rows(getData("train", features, drop=FALSE), 
                  getData("test", features, drop=FALSE))

## replace the activity ids with their short description
df_all$activity<-activities$activity[match(df_all$activity, activities$index)]

## select only the columns we want (subject, activity, and those based on mean 
## or standard deviation)
df_all<-select(df_all, subject, activity, matches(".*(\\.mean\\.|\\.std\\.).*"))

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

## Summarise, while preserving a count of the number of observations for each
## group
tidy_summary<-df_all %>%
    group_by(activity, subject) %>%
    mutate(observations=n()) %>%
    summarise_each(funs(mean))

reorder=c(1:2, 69, 3:5,33,6:8, 34, 9:11, 35, 12:14, 36, 15:17, 37, 18:20, 38, 
          21:23, 39, 24:26, 40, 27:29, 41, 30:32, 42:45, 61, 46:48, 
          62, 49:51, 63, 52:54, 64, 55:57, 65, 58:60, 66:68)

## Reorder the columns
tidy_summary<-tidy_summary[reorder]

## Output the table
write.table(tidy_summary, "tidy_summary.txt", row.names=FALSE)