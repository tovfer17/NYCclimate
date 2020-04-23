#------------------------------------------------------------ libraries-------------#
library(plyr)
library(dplyr)

#------------------------------------- create a list with the csv files from dir------------------------#
# set working directory
setwd("~/Documents/temperataures-2013-2018") # set working directory

#list all csv files from the current directory
file_list <-list.files(pattern=".csv", full.names=TRUE)   

#Read all csv files 
data_list2 <- lapply(file_list,read.csv,header=TRUE,sep=",")
#print results for testing purposes
print(data_list2)

#-------------------------------create a function to apply all changes to all csv files-----------------#
data_list2 <-lapply(seq_along(data_list2), function(i){
  #go through each file 
  df2 <- data_list2[[i]]
  
  #------------------------changing the Date column and mean in all csv files--------------------------------#
  #selects columns that include date and ozone
  my.data.new2 <-df2[c(2,5)]
  # Conerts "Date" column to date format using as.Date function
  my.data.new2 $Date <- as.Date(my.data.new2 $Date,"%m/%d/%Y")
  # creates new col called Month and it changes the format so it just has the month using format function 
  my.data.new2$Month <-format(my.data.new2$Date,format ="%m")
  #print results for testing purposes
  View(my.data.new)
  # converting month values from characters to numeric 
  my.data.new2$Month <- as.numeric(as.character(my.data.new2$Month))
  #print the structure to see the data types to check for proper implementation
  str(my.data.new2)
  # This three steps will find the mean of each month by splitting dataframe in correct areas.
  temp_by_month <- with(my.data.new2, split(Temperature, Month))
  # apply the mean to each split area which is determine by the change in month
  temp_mean_by_month <- lapply(temp_by_month, mean)
  #creates a dataframe 
  tempNew<- data.frame(matrix(unlist(  temp_mean_by_month ), nrow=length(  temp_mean_by_month ), byrow=T))
  #in this dataframe, the col name was changed
  colnames(tempNew) <- "Temperature Mean by Month"
  #print results for testing purposes
  View(tempNew)
  
  # create a new csv file with mean calculations for each old file
  write.csv(tempNew,paste("temp_mean_by_month_",i,".CSV"), row.names = F)
})





