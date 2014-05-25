library(reshape2)

# Creates a data set with the average of each variable for each activity and each subject
AverageData <- function(dataset) {
  molten <- melt(dataset, id.vars=c("subject", "activity"))
  dcast(molten, subject + activity ~ variable, mean)
}