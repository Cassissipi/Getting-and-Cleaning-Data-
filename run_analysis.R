
  if(!file.exists("./week4assign")){dir.create("week4assign")}
  URL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(URL, destfile = "./week4assign/Dataset.zip")
  unzip(zipfile="./week4assign/Dataset.zip")
  
  x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
  y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
  subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
  
  x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
  y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
  subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
  
  features <- read.table('./UCI HAR Dataset/features.txt')
  
  activityLabels = read.table('./UCI HAR Dataset/activity_labels.txt')
  
  colnames(x_train)<-features[,2]
  colnames(x_test)<-features[,2]
  
  colnames(y_test)<-"activity"
  colnames(y_train)<-"activity"
  
  colnames(subject_test)<-"subject"
  colnames(subject_train)<-"subject"
  
  colnames(activityLabels)<-c("activity", "activitytype")
  
  alltrain<-cbind(x_train, y_train, subject_train)
  alltest<-cbind(x_test, y_test, subject_test)
  
  alltesttrain<-rbind(alltrain, alltest)
  
  MeanStd<-(grepl("activity", names) | 
              grepl("subject", names) |
              grepl("mean", names) | 
              grepl("std", names)
  )
  
  MeanStdSubset<-(alltesttrain[, MeanStd ==TRUE])
  
  SubsetNamed<-merge(MeanStdSubset, activityLabels, by="activity", all.x=TRUE)
  
  SecondTidy<-aggregate(.~subject + activity, SubsetNamed, mean)
  SecondTidy<-SecondTidy[order(SecondTidy$subject, SecondTidy$activity), ]