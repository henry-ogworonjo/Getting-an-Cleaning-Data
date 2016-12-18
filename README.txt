Getting and Cleaning Data Course Project


The script that does the data cleaning to produce a tidy data named tidyData.txt
is run_analysis.R. The well commented script does the following:

Check to see if the UCI HAR dataset exists.If the dataset does not exit 
in the working directly, it downloads it

Unzip the downloaded data set

Loads the activity labels as character

Loads the features as character

Extract a subset of the features based on the ones with mean or std and call it newFeatures

clean the reduced feature 

Load the train dataset

Load the test dataset

Merge the train and test data into a single data

Assign names to the new data to make the labels of the data set more descriptive

Use the melt and dcast functions to create a second, independent tidy data set with the average of 
each variable for each activity and each subject

Write the independent clean data  saved as tidyData.txt


