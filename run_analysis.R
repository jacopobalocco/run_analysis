################################################################################
# Part 0 - Preliminary phases
################################################################################
setwd("/Users/jacopobalocco/data_science_specialization/projects/datasciencecoursera/getting_cleaning_data/week4")

# activity y
# features x

# libraries
library(data.table)
library(dplyr)

# Read Metadata
features <- read.table("UCI HAR Dataset/features.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)

# Read training data
act_train <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
fea_train <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)

# Read test data
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
act_test <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
fea_test <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)

################################################################################
# Part 1 - Merge the training and the test sets to create one data set
################################################################################

subject <- rbind(subject_train, subject_test)
act <- rbind(act_train, act_test)
fea <- rbind(fea_train, fea_test)

colnames(fea) <- t(features[2])

# Merge
colnames(act) <- "Activity"
colnames(subject) <- "Subject"
final_data <- cbind(fea,act,subject)

################################################################################
# Part 2 - Extracts only the measurements of the mean and standard deviation for each measurement
################################################################################

columns_needed <- grep(".*Mean.*|.*Std.*", names(final_data), ignore.case=TRUE)


extr_data <- final_data[,c( 562, 563, columns_needed)]
dim(extr_data)

################################################################################
# Part 3 - Uses descriptive activity names to name the activities in the data set
################################################################################

for (i in 1:6)
        {
        extr_data$Activity[extr_data$Activity == i] <- as.character(activity_labels[i,2])
}

# extr_data$Activity <- as.factor(extr_data$Activity)

################################################################################
# Part 4 - Appropriately labels the data set with descriptive variable names
################################################################################

names(extr_data)<-gsub("Acc", "Accelerometer", names(extr_data))
names(extr_data)<-gsub("BodyBody", "Body", names(extr_data))
names(extr_data)<-gsub("Gyro", "Gyroscope", names(extr_data))
names(extr_data)<-gsub("Mag", "Magnitude", names(extr_data))
names(extr_data)<-gsub("^t", "Time", names(extr_data))
names(extr_data)<-gsub("^f", "Frequency", names(extr_data))
names(extr_data)<-gsub("tBody", "TimeBody", names(extr_data))
names(extr_data)<-gsub("-mean()", "Mean", names(extr_data), ignore.case = TRUE)
names(extr_data)<-gsub("-std()", "STD", names(extr_data), ignore.case = TRUE)
names(extr_data)<-gsub("-freq()", "Frequency", names(extr_data), ignore.case = TRUE)
names(extr_data)<-gsub("angle", "Angle", names(extr_data))
names(extr_data)<-gsub("gravity", "Gravity", names(extr_data))


################################################################################
# Part 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
################################################################################

extr_data <- data.frame(extr_data)

tidy <- aggregate(. ~Subject + Activity, extr_data, mean)
names(tidy)

tidy <- arrange(tidy,Subject,Activity)

write.table(tidy, file = "tidy_data.txt", row.names = FALSE)
