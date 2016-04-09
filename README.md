## run_analysis

the run.analysis.R script is structured as follows:

# Part 0 - Preliminary phases

This is about loading libraries and reading data that has been extracted in the folder ./UCI HAR Dataset



# Part 1 - Merge the training and the test sets to create one data set

* Links the datasets based on the rows
* gives the column the names identified by the feature variable
* changes the names of the columns containing the activities and the subjects
* produces a final_data data.table to work on



# Part 2 - Extracts only the measurements of the mean and standard deviation for each measurement

* finds the column needed in the rest of the analysis
* extracts the data related to these columns



# Part 4 - Appropriately labels the data set with descriptive variable names
Appropriately names these columns based on what they really mean

# Part 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

Tidies the dataset arranging it by Subject and Sctivity, using the plyr package


