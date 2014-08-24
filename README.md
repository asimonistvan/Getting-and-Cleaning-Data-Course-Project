Getting and Cleaning Data Course Project
=================================================

The purpose of this project is to demonstrate my ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

The R script run_analysis.R ("the script") processes the Human Activity Recognition Using Smartphones Dataset Version 1.0 ("original data" or "original dataset"). The original dataset is publicly available at http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip. This document is to be read together with the documentation that comes with the original data.

The script reads the following files of the original data assuming that the files are available in the working directory:
* activity_labels.txt
* features.txt
* subject_test.txt
* subject_train.txt
* X_test.txt
* X_train.txt
* y_test.txt
* y_train.txt

For description of the files please refer to the original documentation.

The data in subject_test, X_test and y_test has the same number of records and contain different fields of the same observations; as such they can be merged as columns of a data frame named test. The same applies to subject_train, X_train and y_train resulting the data frame train.

The features table contains the field names of the X_ files, y_ files represent the activity codes and subject files has the subject IDs. Fields are named accordingly.

As test and train tables has the same fields of different observations, the two can be merged to one comprehensive table named data. Additional field is generated to flag if the particular record is from the test or train set.

Fields are filtered into a new table named extract keeping all records. Only the fields capturing means and standard deviations are included in addition to subject, set and activity data. Frequency means and angular means are excluded as these do not capture means of primary observations.

Activity codes are replaced with activity names based on the mapping in the activity_labels file.

Variable names are amended in the following ways:
* lowerCamelCase is applied
* Obvious typo BodyBody replaced with Body
* initial t and f changed to more descriptive time and fft
* Acc changed to more descriptive Accelerometer
* Gyro changed to more descriptive Gyroscope
* Mag changed to more descriptive Magnitude
* mean changed to Mean to meet lowerCamelCase
* std changed to more descriptive StandardDeviation
* all non-alphanumeric characters removed

Tidy data set is prepared containing the average of the observations for all fileds in extract by subject by set by activity. Set data is only included to be preserved in the resulting table, however it results no additional grouping as subjects belong to exactly one set category. Tidy data set is written to tidy_data.txt in comma separated format.

