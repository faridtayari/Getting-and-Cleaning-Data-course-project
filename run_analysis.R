library(dplyr)
library(plyr)
library(reshape)

############################## Reading and cleaning the data:
xtrain<-read.table("./UCI HAR Dataset/train/x_train.txt", header=TRUE)
xtest<-read.table("./UCI HAR Dataset/test/x_test.txt", header=TRUE)

#Activity code
ytrain<-read.table("./UCI HAR Dataset/train/y_train.txt", header=TRUE)
ytest<-read.table("./UCI HAR Dataset/test/y_test.txt", header=TRUE)
names(ytrain)<-"Activity_code"
names(ytest)<-"Activity_code"

#Activity names 6x2
activity_name<-read.table("./UCI HAR Dataset/activity_labels.txt")

#variable names 561x2
featurse<-read.table("./UCI HAR Dataset/features.txt")
var_name<-as.character(featurse$V2)
var_name<-gsub("\\()","",var_name)
var_name<-gsub("\\(","_",var_name)
var_name<-gsub("\\)","",var_name)
var_name<-gsub(",","_",var_name)
var_name<-gsub("`","_",var_name)

names(xtrain)<-var_name
names(xtest)<-var_name

#Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
#people who performed the test
sub_train<-read.table("./UCI HAR Dataset/train/subject_train.txt", header=TRUE)
sub_test<-read.table("./UCI HAR Dataset/test//subject_test.txt", header=TRUE)
names(sub_train)<-"subject"
names(sub_test)<-"subject"


##############################Part 1:
#cbiding subject, ytrain, and xtrain

subyxtrain<-cbind(sub_train,ytrain,xtrain)
subyxtest<-cbind(sub_test,ytest,xtest)

#rbiding test and train data
train_test_merged<-rbind(subyxtrain,subyxtest)


##############################Part 2 and part 4:

#Extracting only the measurements on the mean and standard deviation for each measurement. 

## removing columns with duplicated names
train_test_merged2<-train_test_merged[names(train_test_merged[duplicated(names(train_test_merged))==FALSE])]

## selecting data with "mean" or "std" in the column name. 
selected_var<-c(1,2,grep(c("mean"),names(train_test_merged2)),grep(c("std"),names(train_test_merged2)))
selected_data<-select(train_test_merged2, selected_var)



#########################part 3

selected_data$Activity_code <- factor(selected_data$Activity_code, 
                                      label = c("Walking", "Walking Upstairs", 
                                                "Walking Downstairs", "Sitting", "Standing", "Laying"))
selected_data<-rename(selected_data,c(Activity_code="activity_name"))

#########################part 4: 
#part 4 and part 2 are coded together 

#########################part 5

grouped_selected_data <- group_by(selected_data,subject,activity_name)
tidy_data <- summarize_each(grouped_selected_data,funs(mean))
write.csv(file="tidy_data.csv",tidy_data,row.names = FALSE)
