# CodeBook for Human Activity Recognition Using Smartphones Dataset

## Dataset Description
This project uses data collected from the accelerometer and gyroscope of Samsung Galaxy S II smartphones worn by 30 subjects performing 6 activities of daily living. The original dataset was provided by the UCI Machine Learning Repository.

## Source Data
- Raw data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
- Full description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Data Transformations
The run_analysis.R script performs these key transformations:

1. **Merges training and test sets**
   - Combines X_train.txt (7,352 rows) and X_test.txt (2,947 rows)
   - Combines corresponding subject and activity files

2. **Extracts mean and standard deviation measurements**
   - Selects only variables containing "mean()" or "std()" (66 of 561 features)
   - Examples: tBodyAcc-mean()-X, tBodyAcc-std()-Y

3. **Applies descriptive activity names**
   - Converts numeric activity labels to descriptive names:
     - 1 = WALKING
     - 2 = WALKING_UPSTAIRS
     - 3 = WALKING_DOWNSTAIRS
     - 4 = SITTING
     - 5 = STANDING
     - 6 = LAYING

4. **Labels variables descriptively**
   - Removes special characters and improves readability:
     - tBodyAcc-mean()-X → tBodyAccMeanX
     - fBodyGyro-std()-Z → fBodyGyroStdZ

5. **Creates independent tidy dataset**
   - Groups by subject (30) and activity (6)
   - Calculates mean for each variable (180 observations)
   - Saved as tidy_data.txt

## Variables in tidy_data.txt

### Identifiers
- `subject` - Participant ID (1-30)
- `activity` - Activity name (6 levels)

### Measurement Variables (all normalized to [-1,1])
Time-domain signals (prefix 't'):
- `tBodyAccMean[X/Y/Z]` - Mean body acceleration
- `tBodyAccStd[X/Y/Z]` - Std dev of body acceleration
- `tGravityAccMean[X/Y/Z]` - Mean gravity acceleration
- `tBodyAccJerkMean[X/Y/Z]` - Mean body linear acceleration jerk
- `tBodyGyroMean[X/Y/Z]` - Mean angular velocity
- `tBodyGyroJerkMean[X/Y/Z]` - Mean angular velocity jerk

Frequency-domain signals (prefix 'f'):
- `fBodyAccMean[X/Y/Z]` - FFT of body acceleration
- `fBodyAccJerkMean[X/Y/Z]` - FFT of body linear acceleration jerk
- `fBodyGyroMean[X/Y/Z]` - FFT of angular velocity
- `fBodyAccMagMean` - FFT of body acceleration magnitude
- `fBodyBodyGyroMagMean` - FFT of angular velocity magnitude

(Note: All variables ending with "Std" represent standard deviations)

## Units
- All features were normalized and bounded within [-1,1] in the original data
- Angular measurements are in radians
- Time measurements are in seconds

## Repository Contents
- `run_analysis.R` - Data cleaning script
- `tidy_data.txt` - Final tidy dataset
- `README.md` - Project overview
- `CodeBook.md` - This variable documentation
