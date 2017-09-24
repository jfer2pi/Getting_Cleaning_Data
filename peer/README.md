## Getting and Cleaning Data
### Week 4:  Peer-Reviewed Assignment

This analysis builds on the "Human Activity Recognition Using Smartphones Dataset" by Reyes-Ortiz, et al,
available at "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#### Original Description

*The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.* 

*The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details.*


### Processing

The analysis is completed with the file "run_analysis.R", which first downloads the dataset and unzips the file.   The dataset is divided into a test and a training set, as usually done for machine leearning applications.

The analysis joins the rows of the training and testing datasets and provides the column names, known as features in this dataset.  The analysis then joins the columns containing information on the test subject and activities in each row, then converts the numbered activity codes into labelled activity codes for easier recognition.  

The analysis also summarizes each variable as a mean and reports these results in a separate tidy CSV file, where data is arranged first by subject, then activity for easier reading.