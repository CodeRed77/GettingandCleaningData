# Data Cleaning Project


setwd("C:/Users/Renkoh/Desktop/Coursera/CleaningData/Project/Data/UCI HAR Dataset/")

library("plyr")
library("dplyr")

#########################################################################
# Step1. Merges the training and the test sets to create one data set.
#########################################################################

#########################################################################

#Read features text (ie Variable Names)

features <- read.table("./features.txt")
dim(features) #561*2

#transpose data
features2<-(t(features))
dim(features2) #2*561

#create a matrix with only the 2nd row
varname<-features2[-c(1),]

#make sure variable names are unique
listofNames <- make.names(varname, unique=TRUE)
  length(listofNames)
  

#Read Training Datasets - Data file, Label file, and Subject file
trainData <- read.table("./train/X_train.txt")
  dim(trainData) # 7352*561
  head(trainData)

#add column label to train data
colnames(trainData)<-listofNames
head(trainData)

trainLabel <- read.table("./train/y_train.txt")
  dim(trainLabel) #7352*1
  colnames(trainLabel) <- c("activity")

trainSubject <- read.table("./train/subject_train.txt")
  dim(trainSubject) #7352*1
  colnames(trainSubject) <- c("subject")

#Create one Training Dataset
trainAll<-cbind(trainData,trainLabel,trainSubject)
  dim(trainAll) #7352*563
  summary(trainAll)
#########################################################################

#Read Test Datasets
testData <- read.table("./test/X_test.txt")
  dim(testData) # 2947*561

#add column label to train data
colnames(testData)<-listofNames


testLabel <- read.table("./test/y_test.txt") 
  dim(testLabel) # 2947*1
  colnames(testLabel) <- c("activity") #column label

testSubject <- read.table("./test/subject_test.txt")
  dim(testSubject)# 2947*1
  colnames(testSubject) <- c("subject") #column label

#Create one Training Dataset
testAll<-cbind(testData,testLabel,testSubject)
  dim(testAll) #2947*563

#########################################################################
#Combine Train and Test Data

TrainTestData<-rbind(trainAll,testAll)
dim(TrainTestData) # 10299*563

summary(TrainTestData)

#########################################################################
# Step2.  Extracts only the measurements on the mean and 
#         standard deviation for each measurement. 
#########################################################################

#use dplyr package to select relevant columns
MeanStd<-select(TrainTestData, contains("mean"), contains("std"), activity, subject)
colnames(MeanStd)
head(MeanStd)


#########################################################################
# Step3.  Use descriptive activity names to name the activities 
#         in the data set. 
#########################################################################
 

#Read in Activity Labels Dataset
activitydata <- read.table("./activity_labels.txt")
colnames(activitydata) <- c("activity","activity_desc")
head(activitydata)

#Append activity labels by merging based on activity
Joindata<-arrange(join(MeanStd,activitydata),activity)


#########################################################################
# Step4.  Appropriately labels the data set with descriptive 
#         variable names.  
#########################################################################

#NOTE: Variable labels have been applied throughout Steps1-3
#Check Column labels
colnames(Joindata)
 
#########################################################################
# Step5.  Creates a second, independent tidy data set with the 
#         average of each variable for each activity and each subject. 
#########################################################################

summaryData <- ddply(Joindata, c("subject", "activity"), summarise_each,
               funs(mean))
head(summaryData)

#Output dataset as txt file
write.table(summaryData, "Tidy_data.txt",row.name=FALSE)
