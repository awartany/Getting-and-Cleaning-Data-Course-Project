# Code Book for Getting and Cleaning Data Course Project

This code book explains the codes in the script run_analysis.R and describes the variables, the data, and the transformations that was performed to clean up the data.

## 1. Download and unzip the data file
In the first part of the code, the zipped file containg all project data is download and unzipped in the working directory. 
The zipped packages is downloaded from the following URL:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A description of the data set obtained from this expirement is available here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## 2. Reading the data
In this part, the following data files are read into R from their respective locations:
- 'features.txt': List of all features.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
***And then all columns from train files are combined into `train` data frame***
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.
- 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
***And then all columns from test files are combined into `test` data frame***

***And finaly all rows from the two data frames `train` and `test` are combined into one `complete_data` data frame*** 

## 3. Subsetting the data to include only required columns
Pattern Matching and Replacement tools are used to subset the data frame and keep only columns with "mean" or "std" in their names in addition to the two columns `subject_id` and `activity_label` columns. First a logical vector is created using the `grepl` function and then this vector is used to create a new subsetted data frame called `final_data_set`



## 4. Reading label descriptions and merging with `final_data_set` data frame
The next step is to read label descriptions from file "activity_labels.txt" and load it into data frame `activity_labels_table` with proper naming of columns.

After that, `final_data_set` is merged with `activity_labels_table` using `activity_label` variable to add the corresponding activity descriptions to the data frame `final_data_set` under the variable `activity_description`

## 4. Melting and casting the data to create final tidy_data_set.txt file
The final step involves melting the data frame into one skinny data frame keeping the columns subject_id, activity_label, and activity_description as dimensions.

Then the data is casted using `dcast` funciton and written to a file called tidy_data_set.txt in the working directory.
