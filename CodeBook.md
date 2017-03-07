## Getting and Cleaning Data Course Project/HannahDoty

# Introduction

The script `run_analysis.R`performs the 5 steps described in the Course Project Assignment:

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set.
* Appropriately labels the data set with descriptive variable names.
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Variables

* `actLabels` contains data read from document: "UCI HAR Dataset/activity_labels.txt"
* `features` contains data read from document: "UCI HAR Dataset/features.txt"
* `trainData`, `trainAct`, and `trainSub` are used to create the merged train data set stored in `trainData` from downloaded files
* `testData`, `testAct`, and `testSub` are used to create the merged train data set stored in `testData` from downloaded files
* `finalData` is the mereged form of `testData` and `trainData` so analysis can be completed on one comprehensive data set.
* `all_data` merges `x_data`, `y_data` and `subject_data` in a big dataset.
* `finalData.mean` finds the relevant measurements requested above
