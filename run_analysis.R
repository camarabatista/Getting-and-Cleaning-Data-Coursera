library(plyr)

# Readind all datasets on R
X_train <- read.table("C:/Users/d835883/Downloads/UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("C:/Users/d835883/Downloads/UCI HAR Dataset/train/Y_train.txt")
subject_train <- read.table("C:/Users/d835883/Downloads/UCI HAR Dataset/train/subject_train.txt")
X_test <- read.table("C:/Users/d835883/Downloads/UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("C:/Users/d835883/Downloads/UCI HAR Dataset/test/Y_test.txt")
subject_test <- read.table("C:/Users/d835883/Downloads/UCI HAR Dataset/test/subject_test.txt")
features <- read.table("C:/Users/d835883/Downloads/UCI HAR Dataset/features.txt")

# Act. 1: Merges the training and the test sets to create one data set.
X_data <- rbind(X_train, X_test)
Y_data <- rbind(Y_train, Y_test)
subject_data <- rbind(subject_train, subject_test)

# Act. 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
mean_sd <- grep("-(mean|std)\\(\\)", features[, 2])
X_data <- X_data[, mean_sd]
names(X_data) <- features[mean_sd, 2]

# Act. 3: Uses descriptive activity names to name the activities in the data set
activities <- read.table("C:/Users/d835883/Downloads/UCI HAR Dataset/activity_labels.txt")
Y_data[, 1] <- activities[Y_data[, 1], 2]
names(Y_data) <- "activity"

# Act. 4: Appropriately labels the data set with descriptive variable names. 
names(subject_data) <- "subject"
all_data <- cbind(X_data, Y_data, subject_data)

# Act. 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
DF <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(DF, "C:/Users/d835883/Desktop/DF.txt", row.name=FALSE)
