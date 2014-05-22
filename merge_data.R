# Merges the HAR training and test data sets into a single data table
# Returns the merged data with tidy names and only the mean/std features
MergeData <- function() {
  # Test files
  x.test.file <- "./UCI HAR Dataset/test/X_test.txt"
  y.test.file <- "./UCI HAR Dataset/test/y_test.txt"
  subj.test.file <- "./UCI HAR Dataset/test/subject_test.txt"
  
  # Train files
  x.train.file <- "./UCI HAR Dataset/train/X_train.txt"
  y.train.file <- "./UCI HAR Dataset/train/y_train.txt"
  subj.train.file <- "./UCI HAR Dataset/train/subject_train.txt"
  
  # Get the features into a list
  features <- ReadFeatures()
  # Get the labels into a table
  labels <- ReadLabels()
  
  # Read both datasets into memory
  test.data <- ReadDataset(x.test.file, y.test.file, subj.test.file, features, labels)
  train.data <- ReadDataset(x.train.file, y.train.file, subj.train.file, features, labels)
  
  # Merge them
  rbind(test.data, train.data)
}

# Reads the dataset features a vector and returns the vector
ReadFeatures <- function() {
  features.file <- "./UCI HAR Dataset/features.txt"
  read.table(features.file)[[2]]
}

# Reads the dataset labels into a vector and returns the vector
ReadLabels <- function() {
  labels.file <- "./UCI HAR Dataset/activity_labels.txt"
  labels <- read.table(labels.file)
  names(labels) <- c("label", "activity")
  labels
}

# Given the features, labels and subjects (in x.file,
# y.file and subj.file respectively), reads the dataset
# into a data frame. Takes only the mean() and std()
# columns. Returns the dataset with only the mean and
# std columns, and with tidy labels
ReadDataset  <- function(x.file, y.file, subj.file, features, labels) {
  dataset <- read.table(x.file)
  names(dataset) <- features
  dataset["label"] <- read.table(y.file)
  dataset["subject"] <- read.table(subj.file)
  dataset <- merge(dataset, labels)
  TidyNames(dataset[grep("mean\\(\\)|std\\(\\)|activity|subject", names(dataset))])
}

# Tidies the names of the dataset by
# a. Removing non-alphanumeric characters
# b. Downcasing
# Returns the dataset with the tidied names
TidyNames <- function(dataset) {
  names(dataset) <- gsub("[^[:alnum:]]", "", tolower(names(dataset)))
  dataset
}