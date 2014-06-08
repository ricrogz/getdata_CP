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

After merging the samples, the variables containing the read data, which are now useless, are now released to free memory.

At the end of this task we have the following data frames:

1.  "x" contains the data for each feature.
2.  "y" contains the activities matching the rows of "x".
3.  "subject" contains the test subjects matching the rows of "x".

#### Task 2:

The task is to filter the data (and also the feature labels) so that only the variables involving a mean value or standard deviation are kept.

To accomplish this, first we make a visual inspection of the feature names in the "features.txt" data file, after which we conclude that the variables we are interested in are those containing the substrings "-mean(" and "-std(" in no particular position of the string.

The next step is to create a logical vector indexing these features by means of the `grep` function. When passing the strings we are looking for, we have to specify the open parenthesis sign as a literal, using "\\(".

Once we have the logical vector, we subset the feature vector to keep only the labels we are interested in, and also the columns of the data in the "x" frame.


#### Task 3:

Now we are to clean the activity names in the "activity_labels.txt" file.

After a visual inspection of the file, first we convert all the labels into lowercase, and then we remove underscore characters from all activity names.

We also set "activity" as the column name for the activities.


#### Task 4:

The purpose of this task is to properly label and identify all measurements. For this, we start by setting "subject" as the column name for the subjects vector.

The, we subset the feature names vector using the logical vector we built in Task 2, and in the same fashion as we did for the activity labels, we convert all feature labels to lowercase and remove any parethesis symbols (both opening and closing). Finally, we set these "clean" feature labels as the names for the columns in "x" (remember that we had subset "x" in Task 2).

At this point, we merge subjects, activity labels and data (in this order). After merging, we remove the unmerged variables to free memory.

Then, we reorder the data, using subjects and activity as the first and second ordering criteria. Then, we remove the column names, and write the data to disk as a csv file, "tidy_data.csv", ignoring row names but storing column names.


#### Task 5:

We are to calculate column averages for each subject and activity pair. To store those, we create a new data frame with the corresponding number of rows and columns (to create this dimensioned data frame we first define a matrix
with the dimensions we need, and then we cast it into a data.frame called "means").

To calculate the averages we use a double for loop: the outer loop iterates over subjects, the inner one does it over activities.

We subset the data for each subject and activity pair, putting it into a temporary storage ("tmp"), over which column averages are calculated. Then, the averages are stored in the "means" data.frame associated to the proper subject and activity.

Finally, the "means" data.frame is written to a csv file.
