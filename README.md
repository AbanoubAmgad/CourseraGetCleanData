# Coursera's Getting and Cleaning Data Course Project

##Notes
* I Used "Type" Column to make sure i merged both data well
* Am assuming that u unzipped all data in the working directory
* The output file will be in the working directory called dataset.txt
* Used "reshape2" "plyr" packages
* Remember to read comments in run_analysis.r

##Workflow
* It is a ONE script that get the data out and transform it into a tidy nice version
1- Reads all the required data into r
2- Binds a column called "Type" (used for ensuring that everything is ok, u can actually ignore it) 
3- Merges both data "Train" & "Test"
4- Changes the Variables' names to features' names in features.txt
5- Uses "grep" function to disregard variables that don't get mean or std
6- Sets Activities' names instead of just numbers by making a vector of names and the "mutate" function
7- Construct a "tidy" data set with all of the above
8- Using more descriptive names for variables using "gsub" function
9- Melts the datafrae .. reshapes it then uses "dcast" to get the mean of each variable
10- Outputs the data to a text file using "write.table"
