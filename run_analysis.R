## Script to create a tidy dataset from the Human Activity Recognition dataset.
## Course project for coursera getdata class.

# Set the path where the data lives.
datapath <- 'UCI HAR Dataset'

# Download and unzip the dataset, if the data directory is not already present
download_and_unzip_data <- function(force=FALSE)
{
  if( force | (! file.exists(datapath)) ) {  
    dir.create(datapath)
    zipfile <- "getdata-projectfiles-HCI HAR Dataset.zip"
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                  method="wget", destfile=zipfile)
    unzip(zipfile)
  }
}

# The function read_features() reads and cleans the features from the file 'features.txt'
read_features <- function() {
  # Read the names of the features from the 'features.txt' file.
  features <- read.table(file.path(datapath,'features.txt'), 
                         row.names = 1 , col.names = c('col','name'),
                         colClasses = c('numeric','character'))
  
  # The features to keep will have either "mean()" or "std()" in the name.
  features$keep <- grepl('mean\\(\\)|std\\(\\)',features$name)
  
  # Remove the '()' from the names, and replace '-' with '_', so that the
  # feature names can be legal R column names.
  features$name <- gsub('-','_',features$name)
  features$name <- gsub('\\(\\)','',features$name)
  features
}

# The function read_activity_labels() reads the activity labels from the
# file 'activity_labels.txt'.
read_activity_labels <- function() {
  # Read the activity labels
  activity_labels <- read.table(file.path(datapath,'activity_labels.txt'),
                                colClasses = c('numeric','character'),
                                col.names = c('code','label'))
  activity_labels
}

download_and_unzip_data()
features <- read_features()
activity_labels <- read_activity_labels()

# This function reads the data files associated with either the test or
# training dataset and returns a tidier data set that has the following
# characteristics:
# 1. activity codes are factors with descriptive labels
# 2. only measurements of means and stds are included
build_data_set <- function(which.set) {
  # Read the core data from the file "X_{train|test}.txt".
  # The column names for this data are in the features data frame.
  data_file <- file.path(datapath,which.set,sprintf('X_%s.txt',which.set))
  dat <- read.table(data_file, col.names = features$name)
  # Keep only columns matching features to keep
  dat <- dat[,features$keep]

  # Read the activities from the file "y_{train|test}.txt"
  act_file <- file.path(datapath,which.set,sprintf('y_%s.txt',which.set))
  act <- read.table(act_file, col.names = c('activity'))
  # Convert the integer codes to factors using the activity_label data frame
  act$activity <- factor(act$activity, levels=activity_labels$code,
                         labels = activity_labels$label)

  # Read the subjects from the file "subject_{train|test}.txt"
  subj_file <- file.path(datapath,which.set,sprintf('subject_%s.txt',which.set))
  subj <- read.table(subj_file, col.names = c('subject'))
  
  # Return a merged data frame of containing:
  # 1. The set label
  # 2. The subject id
  # 3. The activity label
  # 4. The observational data
  cbind(set=which.set, subj, act, dat)
}

# Read in and merge the test and training data into one data frame
tidy <- rbind( build_data_set('test'),
               build_data_set('train'))

## Generate a summary of the means of the variables by subject and activity
outfile = 'summary_means.txt'

# Either one of the following two functions will generate the output data.
# There are two functions because I was experimenting with using "reshape"
# versus using "aggregate".
summary_data_method1 <- function() {
  # Summarize the data 
  summary_means <- aggregate( . ~ subject + activity , data = tidy, mean)
  # Drop the 'set' variable, as its mean is meaningless
  summary_means$set <- NULL
  summary_means
}

library(reshape2)
summary_data_method2 <- function() {
  # Melt the data along the 3 ID variables.
  x <- melt(tidy, id = c('subject','activity','set'))
  # Drop the set ID variable
  x$set <- NULL
  # Cast back to from molten, using the mean to aggregate
  y <- dcast( x , subject + activity ~ variable, mean)
  y
}

# Write the summary data to a file.
write.table(summary_data_method1(), outfile, row.names=FALSE)

