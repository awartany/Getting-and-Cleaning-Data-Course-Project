## Download data file from the specified URL
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","UCI_HAR_Dataset.zip") 

## Unzip the downloaded file into existing directory
unzip("UCI_HAR_Dataset.zip",  exdir=".")

## Load data.table library
library(data.table)

## Read features data table
features <- read.table("UCI HAR Dataset/features.txt")

## Read X training data set X_train.txt and apply the names from "features" data frame
X_train <- fread("UCI HAR Dataset/train/X_train.txt", col.names = as.vector(features[,2]))

## Read Y training data set Y_train.txt and name the only variable as "activity_label"
Y_train <- read.table("UCI HAR Dataset/train/Y_train.txt",col.names = "activity_label")

## Read subjects training data set subject_train.txt and name the only variable as "subject_id"
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt",col.names="subject_id")

## Combine the 3 data sets into one "train" data set
train <- cbind(subject_train,X_train,Y_train)



## Read X testing data set X_test.txt and apply the names from "features" data frame
X_test<- fread("UCI HAR Dataset/test/X_test.txt", col.names = as.vector(features[,2]))

## Read Y testing data set Y_test.txt and name the only variable as "activity_label"
Y_test <- read.table("UCI HAR Dataset/test/Y_test.txt",col.names = "activity_label")

## Read subjects testing data set subject_test.txt and name the only variable as "subject_id"
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt",col.names="subject_id")

## Combine the 3 data sets into one "test" data set
test <- cbind(subject_test,X_test,Y_test)

## Q1: Merges the training and the test sets to create one data set.
## Merge the train and test data frames into one data frame called "complete_data"
complete_data<-rbind(train,test)

## Q2: Extracts only the measurements on the mean and standard deviation for each measurement.
## Create a logical vector "names_list" of variable names matching the pattern "mean" or "std" or "subject_id" or "activity_label"
names_list<-grepl("mean|std|subject_id|activity_label",names(complete_data))

## Subset the data frame "complete_data" based on th elogical variable of names to keep only variables with "mean" or "std" in the name
final_data_set<-complete_data[ ,names_list]

## Q3: Uses descriptive activity names to name the activities in the data set
## Read the activity labels data set and apply proper column names
activity_labels_table <- read.table("UCI HAR Dataset/activity_labels.txt",col.names = c("activity_label","activity_description"))

## Merge "final_data_set" with "activity_labels_table" to get the relevant activity labels
final_data_set<-merge(final_data_set,activity_labels_table, by = "activity_label")

## Q4: Appropriately labels the data set with descriptive variable names.
## Names already covered while reading the data



## Q5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library("reshape2")

## use melt function to melt data into two dimensions of subject and activity
melt_data <- melt(final_data_set,(id.vars=c("subject_id","activity_label","activity_description")))

## use dcast function to cast the data using mean and the dimensionsal variables
final_data_set <- dcast(melt_data, subject_id + activity_label + activity_description ~ variable, mean)

## write the file back to the working directory
write.table(final_data_set, "final__tidy_data_set.txt",row.name=FALSE)
