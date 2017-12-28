library(plyr)

# Readind datasets on R
X_train <- read.table("C:/Users/d835883/Downloads/UCI HAR Dataset/train/X_train.txt", sep = "")
Y_train <- read.table("C:/Users/d835883/Downloads/UCI HAR Dataset/train/y_train.txt", sep = "")
X_test <- read.table("C:/Users/d835883/Downloads/UCI HAR Dataset/test/X_test.txt", sep = "")
Y_test <- read.table("C:/Users/d835883/Downloads/UCI HAR Dataset/test/y_test.txt", sep = "")
trainSubject <- read.table("C:/Users/d835883/Downloads/UCI HAR Dataset/train/subject_train.txt", sep = "")
testSubject <- read.table("C:/Users/d835883/Downloads/UCI HAR Dataset/test/subject_test.txt", sep = "")
colnamesX <- read.table("C:/Users/d835883/Downloads/UCI HAR Dataset/features.txt", sep = "")
activityLabels <- read.table("C:/Users/d835883/Downloads/UCI HAR Dataset/activity_labels.txt", sep = "")        

# naming columns as "id" to create a key variable to perform the join
colnames(trainSubject) <- c("subjectid")
colnames(testSubject) <- c("subjectid")
colnames(activityLabels) <- c("activityid", "activity")
colnames(Y_train) <- c("activityid")
colnames(Y_test) <- c("activityid")
colnamesX <- colnamesX[,2]
colnames(X_train) <- colnamesX
colnames(X_test) <- colnamesX

# Performing the joining on Y base
Y_train <- join(Y_train, activityLabels, by = c("activityid"))
Y_test <- join(Y_test, activityLabels, by = c("activityid"))
X_train <- cbind(activity = Y_train$activity, X_train)  
X_train <- cbind(subjectid = trainSubject$subjectid, X_train)  
X_test <- cbind(activity = Y_test$activity, X_test) 
X_test <- cbind(subjectid = testSubject$subjectid, X_test)

# Creating the final dataset
DF <- rbind(X_train, X_test) 
View(DF)

write.table(DF,"C:/Users/d835883/Downloads/DF.txt", row.name = FALSE)
