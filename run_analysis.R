run_analysis <- function() {
  # Task 1: merge data
  
  # Set variables for file names
  subject_train_file   <- "./UCI HAR Dataset/train/subject_train.txt"
  x_train_file         <- "./UCI HAR Dataset/train/X_train.txt"
  y_train_file         <- "./UCI HAR Dataset/train/y_train.txt"
  
  subject_test_file    <- "./UCI HAR Dataset/test/subject_test.txt"
  x_test_file          <- "./UCI HAR Dataset/test/X_test.txt"
  y_test_file          <- "./UCI HAR Dataset/test/y_test.txt"
  
  features_file        <- "./UCI HAR Dataset/features.txt"
  activity_labels_file <- "./UCI HAR Dataset/activity_labels.txt"
  
  #  Load all data
  subject_test    <- read.table(subject_test_file)
  x_test          <- read.table(x_test_file)
  y_test          <- read.table(y_test_file)
  
  subject_train   <- read.table(subject_train_file)
  x_train         <- read.table(x_train_file)
  y_train         <- read.table(y_train_file)
  
  features        <- read.table(features_file,        stringsAsFactors=F)
  activity_labels <- read.table(activity_labels_file, stringsAsFactors=F)  
  
  # Merge data of same type
  subject <- rbind(subject_train,subject_test)
  x       <- rbind(x_train,x_test)
  y       <- rbind(y_train,y_test)
  
  #  free unmerged data
  rm(subject_test,subject_train)
  rm(x_test,x_train)
  rm(y_test,y_train)
  
  
  # Task 2: subset mean and std features
  mean_std_feature_cols <- grep("-mean\\(|-std\\(", features[,2])
  x <- x[,mean_std_feature_cols]
  
  
  # Task 3: user descriptive activity labels
  activity_labels[,2] <- gsub("_","",tolower(activity_labels[,2]))
  y[,1] <- activity_labels[y[,1],2]
  y[,1] <- factor(y[,1])
  names(y) <- "activity"
  
  
  # Task 4: set properly identify the data:
  # Identify subject & activity
  # Set column names
  names(subject) <- "subject"
  
  feature_labels <- features[mean_std_feature_cols,2]
  feature_labels <- gsub("\\(|\\)","",tolower(feature_labels))
  names(x) <- feature_labels
  
  data <- cbind(subject, y, x)
  
  rm(subject,x,y)
  
  data <- data[order(data$subject,data$activity),]
  rownames(data) <- NULL
  
  write.csv(data,"tidy_data.csv", row.names=F)
  
  print("Cleaning done -- data written.")
  
  # Task 5: create 2nd table with average data
  # for each subject and activity pair
  subjects   <- unique(data$subject)
  activities <- levels(data$activity)
  
  num_rows    <- length(subjects) * length(activities)
  num_columns <- ncol(data)
  
  means <- data.frame(matrix(nrow = num_rows, ncol = num_columns))
  names(means) <- names(data)
  
  count = 0
  for (i in seq_along(subjects)) {
    for (j in seq_along(activities)) {
      count = count + 1
      current_subject  <- subjects[i]
      current_activity <- activities[j]
      means[count,1:2] <- c(current_subject,current_activity)
      tmp <- data[data$subject == current_subject & 
                    data$activity == current_activity,3:num_columns]
      means[count,3:num_columns] = colMeans(tmp)
    }
  }
  
  write.csv(means,"tidy_data_means.csv", row.names=F)
  
  
  print("Averaging done -- data written.")
  print("Finished processing.")
  invisible(data)
}