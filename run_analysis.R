# Merge the training and the test sets to create one data set

if(!file.exists("/Users/hannahdoty1/Documents/CourseProject")) {
  dir.create("/Users/hannahdoty1/Documents/CourseProject")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile= "/Users/hannahdoty1/Documents/CourseProject/data.zip", method="curl")
unzip("/Users/hannahdoty1/Documents/CourseProject/data.zip")

actLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
actLabels[,2] <- as.character(actLabels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

## Clean up the variable names you will use later

meanSTD <- grep(".*mean.*|.*std.*", features[,2])
meanSTD.names <- features[meanSTD,2]
meanSTD.names = gsub('-mean', 'Mean', meanSTD.names)
meanSTD.names = gsub('-std', 'Std', meanSTD.names)
meanSTD.names <- gsub('[-()]', '', meanSTD.names)

## Read data into R with desired clean variables
### train data merge first

trainData <- read.table("UCI HAR Dataset/train/X_train.txt")[meanSTD]
trainAct <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSub <- read.table("UCI HAR Dataset/train/subject_train.txt")
trainData <- cbind(trainSub, trainAct, trainData)

### test data merge second

testData <- read.table("UCI HAR Dataset/test/X_test.txt")[meanSTD]
testAct <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSub <- read.table("UCI HAR Dataset/test/subject_test.txt")
testData <- cbind(testSub, testAct, testData)

#### Merge test and train data

finalData <- rbind(trainData, testData)
colnames(finalData) <- c("subject", "activity", meanSTD.names)

#change to factors

finalData$activity <- factor(finalData$activity, levels = actLabels[,1], labels = actLabels[,2])
finalData$subject <- as.factor(finalData$subject)

#finalize and write!
meltedfinalData <- melt(finalData, id = c("subject", "activity"))
finalData.mean <- dcast(meltedfinalData, subject + activity ~ variable, mean)
write.table(finalData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
