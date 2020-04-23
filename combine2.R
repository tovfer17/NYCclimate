
#---------------------This will read ozone and temp of each year to combine it into one dataframe----------#
# path to send out csv files to 
path_out = "~/Documents/combinedOzoneTemp"

#-----------------------------------------  2013------------------------------------------------#
# reads temperature csv for 2013
temperatureReading <-read.csv("~/Documents/meansofozonetemps/temp_mean_by_month_ 1 .CSV",header=TRUE)
# reads ozone csv for 2013
ozoneReading <-read.csv("~/Documents/meansofozonetemps/ozone_mean_by_month_ 1 .CSV",header=TRUE)
# combines two csv files into one 
combined_2013 <-cbind(temperatureReading, ozoneReading)
#view the new dataframe for testing purposes
View(combined_2013)
#create a csv file to save this
write.csv(combined_2013,paste(path_out,"Ozone_vs_Temperature_2013.CSV"), row.names = F)
#-----------------------------------------------2014------------------------------------------------#
temperatureReading2 <-read.csv("~/Documents/meansofozonetemps/temp_mean_by_month_ 2 .CSV",header=TRUE)
ozoneReading2 <-read.csv("~/Documents/meansofozonetemps/ozone_mean_by_month_ 2 .CSV",header=TRUE)

combined_2014 <-cbind(temperatureReading2, ozoneReading2)
#View(combined_2014)
write.csv(combined_2014,paste(path_out,"Ozone_vs_Temperature_2014.CSV"), row.names = F)
#-----------------------------------------------2015------------------------------------------------#
temperatureReading3 <-read.csv("~/Documents/meansofozonetemps/temp_mean_by_month_ 3 .CSV",header=TRUE)
ozoneReading3 <-read.csv("~/Documents/meansofozonetemps/ozone_mean_by_month_ 3 .CSV",header=TRUE)

combined_2015 <-cbind(temperatureReading3, ozoneReading3)
#View(combined_2015)
write.csv(combined_2015,paste(path_out,"Ozone_vs_Temperature_2015.CSV"), row.names = F)
#-----------------------------------------------2016------------------------------------------------#
temperatureReading4 <-read.csv("~/Documents/meansofozonetemps/temp_mean_by_month_ 4 .CSV",header=TRUE)
ozoneReading4 <-read.csv("~/Documents/meansofozonetemps/ozone_mean_by_month_ 4 .CSV",header=TRUE)

combined_2016 <-cbind(temperatureReading4, ozoneReading4)
#View(combined_2016)
write.csv(combined_2016,paste(path_out,"Ozone_vs_Temperature_2016.CSV"), row.names = F)
#-----------------------------------------------2017------------------------------------------------#
temperatureReading5 <-read.csv("~/Documents/meansofozonetemps/temp_mean_by_month_ 5 .CSV",header=TRUE)
ozoneReading5 <-read.csv("~/Documents/meansofozonetemps/ozone_mean_by_month_ 5 .CSV",header=TRUE)

combined_2017 <-cbind(temperatureReading, ozoneReading)
#View(combined_2017)
write.csv(combined_2017,paste(path_out,"Ozone_vs_Temperature_2017.CSV"), row.names = F)
#-----------------------------------------------2018------------------------------------------------#
temperatureReading6 <-read.csv("~/Documents/meansofozonetemps/temp_mean_by_month_ 6 .CSV",header=TRUE)
ozoneReading6 <-read.csv("~/Documents/meansofozonetemps/ozone_mean_by_month_ 6 .CSV",header=TRUE)

combined_2018 <-cbind(temperatureReading6, ozoneReading6)
#View(combined_2018)
write.csv(combined_2018,paste(path_out,"Ozone_vs_Temperature_2018.CSV"), row.names = F)