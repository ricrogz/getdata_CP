Getting and Cleaning Data Course Project
# Code Book


## Purpose
This project is intented for the cleaning of the data contained in

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
      
A description of these data can be found here:

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
      
## Important notes
The data for which this code is designed is small (~ 50 mb) so there should be no memory concer.
      
## Code Files & Content
This project contains a single code file, run_analysis.R, which contains a single function (without any arguments), `run_analysis()`, which is intended to load and clean the data mentioned in the previous section, returning a cleaned data frame.

## Functions
**`run_analysis.R`**
This function is divided into five tasks, matching the objectives of the course project.


#### Task 1:

Atop of this block, variables are defined for the names of the files, to allow easy updates to the file names and/or paths.

Following this, all files are read, and data for training and tests are merged (in this same order), respectively for test data and subject and activity labeling.

The measurement data from the "X_test.txt" and "X_train.txt" are merged into "x" data.frame; the activity data from the "y_test.txt" and "y_train.txt" are merged into "y" data.frame, and the subjects data is loaded from the "subject_test.txt" and "subject_train.txt" files, and merged and stored into the "subject" data frame.

Feature labels are loaded into the "feature" data frame, and the activity labels, into the "activity_labels" one.

After merging the samples, the variables containing the read data, which are now useless, are now released to free memory.

At the end of this block we have the following data frames:

1.  "x" contains the data for each feature.
2.  "y" contains the activities matching the rows of "x".
3.  "subject" contains the test subjects matching the rows of "x".


#### Task 2:

The task is to filter the data (and also the feature labels) so that only the variables involving a mean value or standard deviation are kept.

To accomplish this, first we make a visual inspection of the feature names in the "features.txt" data file, after which we conclude that the variables we are interested in are those containing the substrings "-mean(" and "-std(" in no particular position of the string.

The next step is to create a logical vector indexing these features by means of the `grep` function. When passing the strings we are looking for, we have to specify the open parenthesis sign as a literal, using "\\(". The logical vector is stored in the "mean_std_feature_cols".

Once we have the logical vector "mean_std_feature_cols", we subset the feature data frame "x" to keep only the columns with the data we are interested in. The subset data is also stored under the variable "x".


#### Task 3:

Now we are to clean the activity names in the "activity_labels.txt" file.

After a visual inspection of the file, first we convert all the labels into lowercase, and then we remove underscore characters from all activity names, storing the results in the "activity_labels" data frame.

Once we have the labels, we substitute the activities list contained in "y" as number by the appropriate labels, and then, we convert the column into a factor.

Finally, we also set "activity" as the column name for the activities.


#### Task 4:

The purpose of this task is to properly label and identify all measurements.

For this, we start by setting "subject" as the column name for the subjects vector.

Then, we subset the feature names vector "features" using the "mean_std_feature_cols" logical vector we built in Task 2, storing the result in "feature_labels".

In the same fashion as we did for the activity labels, we convert all feature labels in "feature_labels" to lowercase and remove any parethesis symbols (both opening and closing), again storing the result in "feature_labels".

We set these "clean" feature labels as the names for the columns in "x" (remember that we had subset "x" in Task 2).

At this point, we merge the data frames "subject" for the subjects, "y" for the activity labels and "x" for the data (in this order), storing the result in the "data" data frame.

As we did before, after merging, we remove the unmerged variables to free memory.

Then, we reorder the data in "data", using subjects and activity as the first and second ordering criteria. Then, we remove the row names, and finally write the data to disk as a csv file, "tidy_data.csv", ignoring row names but storing column names.

A message is printed out to signal the finishing of this task.


#### Task 5:

We are to calculate column averages for each subject and activity pair.

We start by getting the unique values in the "subject" column of "data" (and storing them in the "subjects" vector), and also the unique activities, which match the levels in the "activity" column of "data" (this we store in the "activities" vector)

To store the averages, we create a new "means" data frame. We also create two auxiliar variables: "num_rows", which will be the number of rows in the "means" data frame, and "num_columns", which will hold the number of columns in the "means" data frame, which will also be the same as the number of columns we had in the "data" data frame.

As we are calculating averages for each pair of subject and activity, the dimension of the means array, and also the value of "num_rows" has to match the number of subjects times the number of actitivies (or, which is the same, the size of the "subjects" vector times the size of the "activities" vector).

To create the empty "means" data frame with defined number of rows and columns, we have to first define a matrix with these dimensions, and then cast it into a data.frame.

To calculate the averages we use a double for loop: the outer loop uses the variable "i" to iterate over "subjects", and the inner one does it over the "activities" using the variable "j".

Inside the loops, since "i" and "j" are numerical, we assign "current_subject" and "current_activity" to hold the number of the current subject and activity being averaged.

We also use a "count" variable to keep count on the current row of "means" we are assigning the averaged data.

To calculate the averages first we define a temprary storage named "tmp", where we store all avaialble data for the current subject and activity. Since the first two columns contain the identificators for subject and activity, they should not be averaged, and are not stored in "tmp".

Using the `colMeans` function, we calculate the averages of the columns in "tmp", and assign the results to columns 3 to the last ("num_columns") in the current row of "means".

Finally, the "means" data.frame is written to a csv file named "tidy_data_means.csv", and two messages are printed out to signal the end of the averaging and the execution of the function.

To check for the finalization, a value of "TRUE" is returned.
