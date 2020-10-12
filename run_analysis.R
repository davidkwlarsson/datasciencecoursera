
x_train <- read.table('UCI_HAR_Dataset/train/X_train.txt')
y_train <- read.table('UCI_HAR_Dataset/train/y_train.txt')
s_train <- read.table("UCI_HAR_Dataset/train/subject_train.txt")
x_test <- read.table('UCI_HAR_Dataset/test/X_test.txt')
y_test <- read.table('UCI_HAR_Dataset/test/Y_test.txt')
s_test <- read.table('UCI_HAR_Dataset/test/subject_test.txt')

features <- read.table('UCI_HAR_Dataset/features.txt')
actLabels = read.table('UCI_HAR_Dataset/activity_labels.txt')


# Descriptive variable names:
colnames(x_train) <- features[, 2]
colnames(x_test) <- features[, 2]

colnames(y_train) <-"activityId"
colnames(s_train) <- "subjectId"
colnames(y_test) <-"activityId"
colnames(s_test) <- "subjectId"
colnames(actLabels) <- c('activityId','activityType')

train <- cbind(y_train,s_train, x_train)
test <- cbind(y_test, s_test, x_test)
fullset <- rbind(train, test)

colN <- colnames(fullset)

# Find the mean and std columns.
mean_and_std_cols <- (grepl("activityId", colN) |
                          grepl("subjectId", colN) |
                          grepl("mean..", colN) | grepl("std..", colN))

# 2. extract only the mean and std cols and create a new set with those.
mean_std <- fullset[ , mean_and_std_cols == TRUE]

# 3. Descriptive names for activities
descriptive <- merge(mean_std, actLabels, by = 'activityId', all.x = TRUE)

# 4 was done above, in the beginning.

# 5
# formula, set to aggregate and then function
tidy <- aggregate(. ~subjectId + activityId, mean_std ,mean)
ord_tidy <- tidy[order(tidy$subjectId, tidy$activityId),]

write.table(ord_tidy, "Tidy.txt", row.name=FALSE)
