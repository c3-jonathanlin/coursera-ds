install.packages(c("data.table", "reshape2"))

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "Dataset.zip")
unzip(zipfile="Dataset.zip")

# Get better column labels
activityLabels <- fread("UCI HAR Dataset/activity_labels.txt", col.names=c("classLabels", "activityName"))
allFeatures <- fread("UCI HAR Dataset/features.txt", col.names=c("index", "featureNames"))
meanAndStdFeatures <- grep("(mean|std)\\(\\)", allFeatures[, featureNames])
newColNames <- gsub('[()]', '', allFeatures[meanAndStdFeatures, featureNames])

# Load the train and test datasets
X_train <- fread("UCI HAR Dataset/train/X_train.txt")[, meanAndStdFeatures, with=FALSE]
Y_train <- fread("UCI HAR Dataset/train/Y_train.txt", col.names=c("activity"))
subject_train <- fread("UCI HAR Dataset/train/subject_train.txt", col.names=c("subjectId"))
X_test <- fread("UCI HAR Dataset/test/X_test.txt")[, meanAndStdFeatures, with=FALSE]
Y_test <- fread("UCI HAR Dataset/test/Y_test.txt", col.names=c("activity"))
subject_test <- fread("UCI HAR Dataset/test/subject_test.txt", col.names=c("subjectId"))
setnames(X_train, colnames(X_train), newColNames)
setnames(X_test, colnames(X_test), newColNames)
train <- cbind(subject_train, Y_train, X_train)
test <- cbind(subject_test, Y_test, X_test)

# Combine the test and train datasets
combined <- rbind(train, test)

# Make Activity values more descriptive
combined[["Activity"]] <- factor(combined[, Activity], levels=activityLabels[["classLabels"]], labels=activityLabels[["activityName"]])

# Aggregate mean/SD for each subject-activity combination
combined[["SubjectNum"]] <- as.factor(combined[, SubjectNum])
combined <- melt(data=combined, id=c("SubjectNum", "Activity"))
combined <- dcast(data=combined, SubjectNum + Activity ~ variable, fun.aggregate=mean)

# Write final dataset to file
fwrite(x=combined, file="tidy_dataset.txt", quote=FALSE)