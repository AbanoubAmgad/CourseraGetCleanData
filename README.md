# Coursera's Getting and Cleaning Data Course Project

##Notes
* I Used "Type" Column to make sure i merged both data well
* Am assuming that u unzipped all data in the working directory
* The output file will be in the working directory called dataset.txt
* Used "reshape2" "plyr" packages
* Remember to read comments in run_analysis.r

##Workflow
* It is a ONE script that get the data out and transform it into a tidy nice version
* Reads all the required data into r
* Binds a column called "Type" (used for ensuring that everything is ok, u can actually ignore it) 
* Merges both data "Train" & "Test"
* Changes the Variables' names to features' names in features.txt
* Uses "grep" function to disregard variables that don't get mean or std
* Sets Activities' names instead of just numbers by making a vector of names and the "mutate" function
* Construct a "tidy" data set with all of the above
* Using more descriptive names for variables using "gsub" function
* Melts the datafrae .. reshapes it then uses "dcast" to get the mean of each variable
* Outputs the data to a text file using "write.table" function
