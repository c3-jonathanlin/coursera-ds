# Getting and cleaning data

The `run_analysis.R` fetches the **UCI HAR Dataset** and does the following things:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

The final tidy dataset is written to the `tidy_dataset.txt` file in the working directory.