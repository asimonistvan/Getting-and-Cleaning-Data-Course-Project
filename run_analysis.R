# Clear workspace and read tables into R

rm(list=ls())
activityLabels <- read.table("activity_labels.txt")
features <- read.table("features.txt", stringsAsFactors = FALSE)
subjectTest <- read.table("subject_test.txt")
subjectTrain <- read.table("subject_train.txt")
xTest <- read.table("X_test.txt")
xTrain <- read.table("X_train.txt")
yTest <- read.table("y_test.txt")
yTrain <- read.table("y_train.txt")

# Merge the training and the test sets to create one data set. Descriptive set
# identifier added to avoid information loss
train <- cbind(subjectTrain, "train", yTrain, xTrain)
colnames(train) <- c("subject", "set", "activity", features[,2])
test <- cbind(subjectTest, "test", yTest, xTest)
colnames(test) <- c("subject", "set", "activity", features[,2])
data <- rbind(train, test)

# Extract only the measurements on the mean and standard deviation for each
# measurement
colIndex <- grepl("mean\\(\\)|std\\(\\)", colnames(data))
colIndex[1:3] = TRUE
extract <- data[,colIndex]

# Use descriptive activity names to name the activities in the data set
extract$activity <- activityLabels$V2[
        match(extract$activity, activityLabels$V1)
        ]

# Appropriately label the data set with descriptive variable names. 
colnames(extract) <- gsub("BodyBody", "Body", colnames(extract))
colnames(extract) <- gsub("^t", "time", colnames(extract))
colnames(extract) <- gsub("^f", "fft", colnames(extract))
colnames(extract) <- gsub("Acc", "Accelerometer", colnames(extract))
colnames(extract) <- gsub("Gyro", "Gyroscope", colnames(extract))
colnames(extract) <- gsub("Mag", "Magnitude", colnames(extract))
colnames(extract) <- gsub("mean", "Mean", colnames(extract))
colnames(extract) <- gsub("std", "StandardDeviation", colnames(extract)) 
colnames(extract) <- gsub("[^[:alnum:]]", "", colnames(extract))

# Creates a second, independent tidy data set with the average of each variable
# for each activity and each subject. 
library("plyr")
tidyData <- ddply(extract, .(subject, set, activity), numcolwise(mean))
colnames(tidyData)[-1:-3] <- paste(colnames(tidyData)[-1:-3], "Mean", sep="")
write.table(tidyData, file = "tidy_data.txt", sep = ",", row.names = FALSE)