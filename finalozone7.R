#----------------------------------------------- libraries------------------------------------------------#
library(plyr)
library(dplyr)

#------------------------------------- create a list with the csv files from dir----------------------------#

# set working directory
setwd("~/Documents/airpollutants-ozone-2013-2018")

#list all csv files from the current directory
file_list <-list.files(pattern=".csv", full.names=TRUE)  

#Read all csv files 
data_list <- lapply(file_list,read.csv,header=TRUE,sep=",")
#print results for testing purposes
print(data_list)

#-------------------------------create a function to apply all changes to all csv files-----------------#
data_list <-lapply(seq_along(data_List), function(i){
  #go through each file 
  df <- data_list[[i]]
  
  #------------------------changing the Date column and does the mean in all csv files--------------------------------#
  #selects columns that include date and ozone
  my.data.new <-df[c(1,5)]
  # Conerts "Date" column to date format using as.Date function
  my.data.new $Date <-as.Date(my.data.new $Date,"%m/%d/%Y")
  # creates new col called Month and it changes the format so it just has the month using format function 
  my.data.new$Month <-format(my.data.new$Date,format ="%m")
  #print results for testing purposes
  View(my.data.new)
  # converting month values from characters to numeric 
  my.data.new$Month <- as.numeric(as.character(my.data.new$Month))
  #print the structure to see the data types to check for proper implementation
  str(my.data.new )
  # This three steps will find the mean of each month by splitting dataframe in correct areas.
  ozone_by_month <- with(my.data.new, split(Daily.Max.8.hour.Ozone.Concentration, Month))
  # apply the mean to each split area which is determine by the change in month
  ozone_mean_by_month <- lapply(ozone_by_month, mean)
  #creates a dataframe 
  ozoneNew<- data.frame(matrix(unlist(ozone_mean_by_month), nrow=length(ozone_mean_by_month), byrow=T))
  #in this dataframe, the col name was changed
  colnames(ozoneNew) <- "Ozone Mean by Month"
  #print results for testing purposes
  View(ozoneNew)
  
  # create a new csv file with mean calculations for each old file
  write.csv(ozoneNew,paste("ozone_mean_by_month_",i,".CSV"), row.names = F)
})





