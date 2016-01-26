Data is downloaded and unzipped in the “UCI HAR Dataset” folder. 
I used subject_train, X_train, y_train, from train folder and subject_test, X_test, y_test from test folder.
I also used features.txt and activity_labels.txt files from the main directory.

##Reading and cleaning the data: 
After reading the data, 
I read the descriptive variable names from features.txt and store them as character vector. 
I cleaned the names of the variables and assigned the cleaned names to the columns.


##First part:  
For making a train data set, I cbind subject_train, y_train, and X_train. I do similar for test. 

Then I rbind and merged two train and test data sets.


##Second part: 
*In this part I answered the question 2 and 4.
*frist, I removed the columns with duplicated names.
*Then I used grep() function to select the variables that have “mean” or “std” in their names.

##Third  part:
I replaced the factored activities by their descriptive names.

##Fourth part:
Explained and done in part 2:

Fifth part:
In this section I grouped_by the data set by activity and subject and took average of each variable for each activity and each subject.
Finally, I wrote a code to save the results.