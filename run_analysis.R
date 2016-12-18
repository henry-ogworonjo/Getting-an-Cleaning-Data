
# we need the reshape2 library for melt and dcast functions that we use to reshape
# the merged data

library(reshape2)

filename <- "finalAssigment.zip"

# Download the dataset if not already downloaded
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, method="curl")
  dateDownloaded<-date()
}  


#unzip the dataset if not already unzipped
if (!file.exists("FinalAssgt Dataset")) { 
  unzip(filename) 
}

# Load the activity labels as character
activityLabels<-read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
activityLabels[,2] <- as.character(activityLabels[,2])


#Load the features as character; note that there are 561 features in total
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

#Extract a subset of the 561 features based on the ones with mean or std 
newFeatures <- grep(".*mean.*|.*std.*", features[,2])
newFeaturesNames <- features[newFeatures,2]

#clean newFeatures by substituting "Std" for "-std"
newFeaturesNames = gsub('-std', 'Std', featuresWanted.names)
#clean newFeatures by substituting "Mean" for "-mean"
newFeaturesNames = gsub('-mean', 'Mean', newFeaturesNames)
newFeaturesNames <- gsub('[-()]', '', newFeaturesNames)

# Load the train datasets: Activities,Subjects and the train
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainFeatures <- read.table("UCI HAR Dataset/train/X_train.txt")[newFeatures]
trainData<-cbind(trainSubjects, trainActivities, trainFeatures)


# Load the test datasets: Activities,Subjects and the train
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testFeatures <- read.table("UCI HAR Dataset/test/X_test.txt")[newFeatures]
testData<-cbind(testSubjects, testActivities, testFeatures)

# Merge the train and test data into a single data
data <- rbind(trainData, testData)



# Assign names to the new data to make the labels of the data set more descriptive
colnames(data) <- c("subject", "activity", newFeaturesNames)

# Next, convert the variables "activities" and "subjects" into factors
data$activity <- factor(data$activity, levels = activityLabels[,1], labels = activityLabels[,2])
data$subject <- as.factor(data$subject)

# use the melt and dcase functions to create a second, independent tidy data set
#  with the average of each variable for each activity and each subject.
meltedData <- melt(data, id = c("subject", "activity"))
meanMeltedData <- dcast(meltedData, subject + activity ~ variable, mean)

# write the indpendent clean data
write.table(meanMeltedData, "tidyData.txt", row.names = FALSE, quote = FALSE)



