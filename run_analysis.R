if(!file.exists("./data")){     dir.create("./data") }
##### unzip files into data folder

x_train <- read.table("./data/train/X_train.txt")
y_train <- read.table("./data/train/y_train.txt")
subject_train <- read.table("./data/train/subject_train.txt")

x_test <- read.table("./data/test/X_test.txt")
y_test <- read.table("./data/test/y_test.txt")
subject_test <- read.table("./data/test/subject_test.txt")

data_X <- rbind(x_train, x_test)
data_Y <- rbind(y_train, y_test)
data_subject <- rbind(subject_train, subject_test)


features <- read.table("./data/features.txt")
m_and_std <- grep("-(mean|std)\\(\\)", features[, 2])
data_X <- data_X[, m_and_std]
names(data_X) <- features[m_and_std, 2]



activity_labl <- read.table("./data/activity_labels.txt")
data_Y[, 1] <- activity_labl[data_Y[, 1], 2]

names(data_Y) <- "activity"
names(data_subject) <- "subject"
mergeData <- cbind(data_X, data_Y, data_subject)



data_averages <- ddply(mergeData, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(data_averages, "./data/data_averages.txt", row.name=FALSE)

