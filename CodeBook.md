#Code Book

##This document describes the code in run_analysis.R

###Creating, Downloading and Unziping files
- **URL** = file to be downloaded

### Reading downloaded files into R
- **x_train, y_train** and **subject_train** = read files from **train** folder 
- **x_test**, **y_test** and **subject_test** = read files from **test** folder
- **features** and **activityLabels** = read files from **UCI HAR Dataset** folder

### Adding column names 
  colnames(x_train)<-features[,2]
  colnames(x_test)<-features[,2]
  
  colnames(y_test)<-"activity"
  colnames(y_train)<-"activity"
  
  colnames(subject_test)<-"subject"
  colnames(subject_train)<-"subject"
  
  colnames(activityLabels)<-c("activity", "activitytype")
 
### Combining train and test datasets
- **alltrain** = all "train" datasets combined by column 
- **alltest** = all "test" datasets combined by column
- **alltesttrain** = **alltrain** and **alltest** combined by row

### Subsetting the columns which contain mean and std
- **MeanStd** = creates a logical vector where TRUE equals column names that contain "mean", "std", "activity" or "subject"
- **MeanStdSubset** = subset of **alltesttrain** using **MeanStd**

### Naming the activities in the subset data
- **SubsetNamed** = merges the activity names in **activityLabels** with **SubsetNames** to add the description of each activity 

### "Tidying" the data
- **SecondTidy** = finds the mean of each variable for each subject and activity, this is then reorderd: SecondTidy<-SecondTidy[order(SecondTidy$subject, SecondTidy$activity)
