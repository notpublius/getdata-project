# Overview

The file `summary_means.txt` contains a summarization of the data from the
Smartphone Data Set available at the UCI Machine Learning Repository.
The originial data is [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The summarized data includes the mean of 66 observational variables categorized by the subject 
and the activity being performed. The summaries include data from both the test and training sets of the
originial data. The summarized data is in "wide" format, with 68 variables per
observation.

# Code Book

The data contains variables the following two identifying variables:

**subject** 

An integer ID of the study participant. This corresponds to the same code used in the
originial study.

**activity**

An indication of the activity being performed, from the following codes: 

* WALKING
* WALKING_UPSTAIRS
* WALKING_DOWNSTAIRS
* SITTING
* STANDING
* LAYING

The remaining 64 variables have names based on the scheme used in the original study.
For reference, that scheme is described in the original data set file `features.txt`,
which is excerpted below:

<pre>
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constan
t rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separ
ated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals we
re calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern: 
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
</pre>

In this data set the names hold more-or-less to this scheme. So for example, the variable `tBodyGyro_mean_X`
is the time-domain mean of the body's gyroscope reading in the X axis. Moreover, since these variables
are summarized using the mean, this variable is the mean over all the means in the original data set.
Similarly, the variable `fBodyAcc_std_Y` is the mean over all the observations of the standard deviation
of a frequency-domain representation of a capture of the Y axis value of the gyro.

The original data set uses the following units, as explained [here](http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.names):
<pre>
Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.
- The units used for the accelerations (total and body) are 'g's (gravity of earth -> 9.80665 m/seg2).
- The gyroscope units are rad/seg.
- A video of the experiment including an example of the 6 recorded activities with one of the participants can be seen in the following link: http://www.youtube.com/watch?v=XOEN9W05_4A
</pre>

