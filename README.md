# Getting and Cleaning Data Course Project

This is the course project for the coursera.org course "Getting and Cleaning Data".

## Project contents

* README.md: this file.

* run_analysis.R: R code for the analytics. Usage described in next section.

* CodeBook.md: Description for the run_analysis.R code.

Please note that the project does *not* include the data on which run_analysis.R works on. 

## Purpose
This project is intented for the cleaning of the data contained in

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
      
A description of these data can be found here:

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Internal working

First, the files under the "train" and "test" read, and merged. The data about means and standard deviations is extracted from the merged "X_*.txt" files.

Then, "clean" (lowercase, no symbols except commas and hyphens) labels are produced out of the "features.txt" file, and added to the columns.

In a similar way, activity labels are also cleaned and assigned to the data in the "y_.txt" files.

Finally, the subject information, taken from the "subject_*.txt" files, the activity labels, and the mean and standard deviation data are merged into a data frame.

This data frame is saved into the "tidy_data.csv" file.

In a second stage, all the data specific for each feature for each subject and activiy combination is averaged, and written to the "tidy_data_means.csv" file.

## Usage

The raw data to be loaded is relatively small (around 50 mb), so memory should not be a concern unless you are working on a very old machine.

1. Use git to clone this project onto your computer:

  `git clone https://github.com/ricrogz/getdata_CP`

2. Download the dataset on which this project works from:

  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

3. Unzip the downloaded file so that the "UCI HAR Dataset" directory resides in  the same directory created in step 1. This is necessary since the run_analysis.R expects to find the data under this path.

4. Start up R or Rstudio, set the working path to the project's directory, source the run_analysis.R file, and and call the `run_analysis()` function to load the data, tidy it up, and return a data frame with the clean data.

