source("download_data.R")
source("merge_data.R")
source("average_data.R")

# Runs the full analysis, downloading the data if needed,
# merging the test and train datasets, and generating a
# new dataset containing the average of each variable
# for each activity on each subject. Outputs the new
# dataset at ./averages.txt
RunAnalysis <- function() {
  DownloadData()
  dataset <- AverageData(MergeData())
  write.table(dataset, "./averages.txt", sep=",", row.names=FALSE, quote=FALSE)
}

RunAnalysis()