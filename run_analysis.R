# 1. Downloading and Unzipping the file
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = "./Dataset.zip", method = "curl")

unzip("Dataset.zip")


# 2. Loading dplyr package to merge the files 
library(dplyr)


## 3A. Reading Features and Activity Labels
features <- read.table("./UCI HAR Dataset/features.txt",
                       col.names = c("id", "features"))
View(features)

activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt",
                              col.names = c("id", "activity"))
View(activity_labels)


## 3B. Reading Test data
test_x <- read.table("./UCI HAR Dataset/test/X_test.txt",
                     col.names = features$features)
View(test_x)

test_y <- read.table("./UCI HAR Dataset/test/Y_test.txt",
                     col.names = "activity_id")
View(test_y)

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt",
                           col.names = "subject")
View(subject_test)


## 3C. Reading Train data
train_x <- read.table("./UCI HAR Dataset/train/X_train.txt",
                      col.names = features$features)
View(train_x)

train_y <- read.table("./UCI HAR Dataset/train/y_train.txt",
                      col.names = "activity_id")
View(train_y)

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt",
                            col.names = "subject")
View(subject_train)


# 4. Merging the Test and Train data 
merged_x <- rbind(train_x, test_x)
merged_y <- rbind(train_y, test_y)
merged_subjects <- rbind(subject_train, subject_test)
View(merged_x)
View(merged_y)
View(merged_subjects)


# 5. Extracting data on Mean and Standard Deviation
mean_and_std <- grep("mean\\(\\)|std\\(\\)",
                     features$features,
                     value = T)
mean_and_std

final_data <- merged_x %>% 
  select(matches("mean\\(\\)|std\\(||)"))
final_data


# 6. Adding Descriptive activity names
merged_y$activity <- activity_labels$activity[match(merged_y$activity_id, activity_labels$id)]
merged_y$activity

final_data <- cbind(merged_subjects, merged_y, final_data1)
View(final_data)


# 7. Cleaning up Variable Names
names(final_data) <- gsub("\\.", "", names(final_data))
names(final_data) <- gsub("mean", "Mean", names(final_data))
names(final_data) <- gsub("std", "Std", names(final_data))
View(final_data)


# 8. Creating tidy data set with averages
tidy_set <- final_data %>% 
  group_by(subject, activity) %>% 
  summarise(across(everything(), mean, na.rm = T))
View(tidy_set)

write.table(tidy_set, "tidy_data.txt", row.names = F)
