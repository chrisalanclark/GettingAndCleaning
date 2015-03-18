##setwd("Coursera//JHDS//Getting and Cleaning Data//CourseProject")
library(dplyr)
DATASET_FOLDER<-"UCI HAR Dataset//"
DATAFILE_PREFIX<-"X_"
SUBJECT_PREFIX<-"subject_"
ACTIVITY_PREFIX<-"y_"

features<-read.table(paste(DATASET_FOLDER,"features.txt", sep=""),
                     col.names = c("index","feature"))
activities<-read.table(paste(DATASET_FOLDER,"activity_labels.txt", sep=""),
                     col.names = c("index","activity"))

getData <-function (dtype="train", features, drop=TRUE) {
    getDataFile <- function() read.table(paste(DATAFILE_PREFIX,dtype,".txt", sep=""), col.names=features$feature)
    getSubjectFile <-function() read.table(paste(SUBJECT_PREFIX,dtype,".txt", sep=""), col.names=c("subject"))
    getActivityFile <- function() read.table(paste(ACTIVITY_PREFIX,dtype,".txt", sep=""), col.names=c("activity"))
    oldwd<-getwd()
    setwd(paste(DATASET_FOLDER,dtype, sep=""))
    df<-getDataFile()
    if(drop) {
        df<-df[,grep(".*(\\.mean\\.|\\.std\\.).*", colnames(df))]
    }
    df<-bind_cols(getSubjectFile(),df)
    df<-bind_cols(getActivityFile(),df)
    setwd(oldwd)
    df
}


df_all<-bind_rows(getData("train", features, drop=FALSE), getData("test", features, drop=FALSE))

df_all$activity<-activities$activity[match(df_all$activity, activities$index)]

df_all<-select(df_all, subject, activity, matches(".*(\\.mean\\.|\\.std\\.).*"))

columns<-colnames(df_all)

columns<-sub("(Body)+", "", columns)
##columns<-sub("Body", "", columns)
columns<-sub("GravityAcc","Gravity", columns)
columns<-sub("\\.mean\\.\\.\\.X", ".X.mean", columns)
columns<-sub("\\.mean\\.\\.\\.Y", ".Y.mean", columns)
columns<-sub("\\.mean\\.\\.\\.Z", ".Z.mean", columns)
columns<-sub("\\.std\\.\\.\\.X", ".X.std", columns)
columns<-sub("\\.std\\.\\.\\.Y", ".Y.std", columns)
columns<-sub("\\.std\\.\\.\\.Z", ".Z.std", columns)
columns<-sub("Mag", ".Mag", columns)
columns<-sub("\\.\\.", "", columns)

colnames(df_all)<-columns

tidy_summary<-df_all %>%
    group_by(activity, subject) %>%
    mutate(observations=n()) %>%
    summarise_each(funs(mean))

write.table(tidy_summary, "tidy_summary.txt", row.names=FALSE)