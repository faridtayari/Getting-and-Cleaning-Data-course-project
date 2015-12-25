library(dplyr)
library(plyr)
library(reshape)

xtrain<-read.table("./UCI HAR Dataset/train/x_train.txt", header=TRUE)
ytrain<-read.table("./UCI HAR Dataset/train/y_train.txt", header=TRUE)
xtest<-read.table("./UCI HAR Dataset/test/x_test.txt", header=TRUE)
ytest<-read.table("./UCI HAR Dataset/test/y_test.txt", header=TRUE)
activity<-read.table("./UCI HAR Dataset/activity_labels.txt")

#name of the 561 variables
featurse<-read.table("./UCI HAR Dataset/features.txt")

#Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
#people who performed the test
sub_train<-read.table("./UCI HAR Dataset/train/subject_train.txt", header=TRUE)


sub_test<-read.table("./UCI HAR Dataset/test//subject_test.txt", header=TRUE)
#table(sub_test)


##############################Part 1:
#cbiding subject, ytrain, and xtrain and then merging by subject

#
subyxtrain<-cbind(sub_train,ytrain,xtrain)
subyxtest<-cbind(sub_test,ytest,xtest)
subyxtest<-rename(subyxtest,c(X2="X1"))
#test_train_by_sub<-join(subxtrain,subxtest, match="first")

#the merge function is so slow but join() function works well
#test_train_by_lable<-merge(yxtrain,yxtest, by="X1", all=TRUE)

train_test_merged<-join(subyxtrain,subyxtest)


##############################Part 2 and part 4:


#changing the names of the variables
var_name<-as.character(featurse$V2)
xtrain2<-xtrain
colnames(xtrain2)<-var_name
xtest2<-xtest
colnames(xtest2)<-var_name

subyxtrain2<-cbind(sub_train, ytrain,xtrain2)
subyxtest2<-cbind(sub_test,ytest,xtest2)
subyxtest2<-rename(subyxtest2,c(X2="X1"))
train_test_merged2<-join(subyxtrain2,subyxtest2)

var_name_merged<-names(train_test_merged2)
#Extracts only the measurements on the mean and standard deviation for each measurement. 

selected_var_merged<-c(grep(c("mean"),var_name_merged),grep(c("std"),var_name_merged))
selected_data<-select(xtrain, selected_var_merged)
selected_var_name<-(var_name_merged[grepl("mean",var_name_merged) | grepl("std",var_name_merged)])
colnames(selected_data)<-selected_var_name


#########################part 3
train_test_merged2<-rename(train_test_merged2,c(X5="activity"))
train_test_merged2$activity<-as.factor(train_test_merged2$activity)
replc<-c("1"="WALKING", "2"="WALKING_UPSTAIRS", "3"="WALKING_DOWNSTAIRS", "4"="SITTING", "5"="STANDING","6"="LAYING")
train_test_merged2$activity<-revalue(train_test_merged2$activity, replc)

#########################part 4: 
#part 4 and part 2 are coded together 


#########################part 5
