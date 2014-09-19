library("plyr") #used for a simple mutate function :)
library("reshape2") #used for melt 

#reading the files now, supposing that they were unzipped
#in the working directory 

trainSubTrain <- read.table("./train/subject_train.txt")
trainXTrain <- read.table("./train/X_train.txt")
trainYTrain <- read.table("./train/y_train.txt")
testSubTest <- read.table("./test/subject_test.txt")
testXTest <- read.table("./test/X_test.txt")
testYTest <- read.table("./test/y_test.txt")
Features <- read.table("./features.txt")

#step 1
#using the "narrow" form of merging the data and adding a column named "type"
#in order to differentiate betwee Train and Test Data 

trainXTrain <- cbind(Type="Train",trainXTrain)
testXTest <- cbind(Type="Test",testXTest)
merged <- rbind(trainXTrain,testXTest)

#setting the variable names
c <- Features$V2
c <- as.character(c)
c <- c("Type",c) # setting columns (variables) ames, with "Type" as the first variable
colnames(merged) <- c

#step2
#getting the means and stds only from the variables (and the type column that i made)
means <- merged[,grep("mean()",colnames(merged),ignore.case = F,fixed = T)]
stds <- merged[,grep("std()",colnames(merged),ignore.case = F,fixed = T)]
Type <- merged[,"Type"]

#step3
#setting Activities names
Activities <- rbind(trainYTrain,testYTest)

ActivityNames <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING",
                   "STANDING","LAYING")

Activities <- mutate(Activities, ActivityName = ActivityNames[V1])

#setting the Subjects column
Subjects <- rbind(trainSubTrain,testSubTest)
colnames(Subjects) <- "Subject"

#now merging all the data i want
merged <- cbind(Subject = Subjects,Activity = Activities$ActivityName,Type,means,stds)

#step4
#renaming the columns (variables) to more descriptive names
tst <- gsub(("^t"),"time",colnames(merged))
tst <- gsub(("^f"),"frequency",tst)
tst <- gsub(("Acc"),"Acceleration",tst)
tst <- gsub(("Mag"),"Magnitude",tst)
tst <- gsub(("Gyro"),"Gyroscope",tst)
tst <- gsub(("-"),"",tst)
tst <- gsub(("mean"),"Mean",tst)
tst <- gsub(("std"),"StandardDeviation",tst)
colnames(merged) <- tst

#melting the data frame to get the average of each variable
fullmelt <- melt(merged,id=c("Subject","Activity","Type"))
subjectMeans <- dcast(fullmelt, Subject + Activity ~ variable,mean,rm.na=T)

#step5
#making the data set requested
write.table(subjectMeans,file = "./dataset.txt",row.name=FALSE)
