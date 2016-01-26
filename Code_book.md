# Code book
FTayari  
January 25, 2016  

Data is downloaded and unzipped in the "UCI HAR Dataset" folder. 
I used following files from test and train folder.
I also used features.txt and activity_labels.txt files from the main directory.

```{}
subject_train.txt
X_train.txt
y_train.txt

subject_test.txt
X_test.txt
y_test.txt
```

y_train.txt and y_test.txt include activity codes and the lables are stored in activity_labels.txt.

features.txt is a 561x2 data frame that includes the name of the varibales such as: 
```{}
tBodyAcc-mean()-X 
tBodyAcc-mean()-Y 
tBodyAcc-mean()-Z 
tBodyAcc-std()-X 
tBodyAcc-std()-Y  
tBodyAcc-std()-Z
```

Then I cleaned the names:
```{}
"tBodyAcc-mean-X" 
"tBodyAcc-mean-Y" 
"tBodyAcc-mean-Z" 
"tBodyAcc-std-X" 
"tBodyAcc-std-Y"  
"tBodyAcc-std-Z" 
```

Then:

* cbiding subject, ytrain, and xtrain
* rbiding test and train data
* removing columns with duplicated names
* selecting data with "mean" or "std" in the column name 
* replacing the factored activities by their descriptive names
* grouping the data set by activity and subject
* taking average of each variable for each activity and each subject
* saving the results
