#-----------------------reads through all csv files to apply functions -----------------------#
#analyzes all with the specific pattern of .csv according to function()
analyze_all <- function(pattern) {
  #list files in path 
  filenamee <- list.files(path = "~/Documents/combinedOzoneTemp/", pattern = ".CSV", full.names = TRUE)
  #iterates through file to do both anaylze functions
  for (f in filenamee) {
    analyze(f)
    analyze3(f)
    analyze4(f)
  }
}

#--------------------------------------------------graphical analyis-----------------------------------------------#
#analyze the filenamee
analyze <- function(filenamee) {
  #read each csv file
  tempoz <- read.csv(file = filenamee, header = TRUE)
  # ----scatterplot----#
  scatt <-scatter.smooth(x=tempoz$Temperature.Mean.by.Month, y=tempoz$ Ozone.Mean.by.Month, main="Ozone(ppm) ~Temperature (degrees cel) ") 
  print(scatt)
  # ----box plot---- #
  # divide graph area in 2 columns
  par(mfrow=c(1, 2)) 
  # box plot for 'temp'
  box1 <- boxplot(tempoz$Temperature.Mean.by.Month, main="Temperature", sub=paste("Outlier rows: ", boxplot.stats(tempoz$Temperature.Mean.by.Month)$out))
  print(box1)
  # box plot for 'ozone'
  box2 <-boxplot(tempoz$ Ozone.Mean.by.Month, main="Ozone", sub=paste("Outlier rows: ", boxplot.stats(tempoz$ Ozone.Mean.by.Month)$out))
  print(box2)
  # ----density plot---- #
  # for skewness function
  library(e1071) 
  # divide graph area in 2 columns
  par(mfrow=c(1, 2)) 
  # density plot for 'temp'
  poly1 <- plot(density(tempoz$Temperature.Mean.by.Month), main="Density Plot: Temperature", ylab="Frequency", sub=paste("Skewness:", round(e1071::skewness(tempoz$Temperature.Mean.by.Month), 2)))
  print(poly1)
  # density plot for 'ozone'
  poly2 <-plot(density(tempoz$ Ozone.Mean.by.Month), main="Density Plot: Ozone", ylab="Frequency", sub=paste("Skewness:", round(e1071::skewness(tempoz$ Ozone.Mean.by.Month), 2))) 
  print(poly2)

}


#--------------------------------------------------summarystats/correlation text files-----------------------------------------------#
analyze3 <- function(filenamee){
  tempoz <- read.csv(file = filenamee, header = TRUE)
  #----correlation analysis----#
  print("#---------------Correlation Analysis---------------------#")
  c <- cor(tempoz$Temperature.Mean.by.Month, tempoz$ Ozone.Mean.by.Month)
  print(c)
  
  #print title
  print("#----------------Building the Linear Regression Model---------------------#")
  #-----linear regression model----#
  linearMod <- lm(Ozone.Mean.by.Month ~ Temperature.Mean.by.Month , data=tempoz)  # build linear regression model on full data
  #print title
  print("Linear Regression model: ")
  print(linearMod)
  #------summary ----------# 
  print("This is summary statistics of the linear Regression Model: ")
  summary(linearMod)
}

#--------------------------------------------------training and test data-----------------------------------------------#
analyze4 <-function(filenamee){
  tempoz2 <- read.csv(file = filenamee, header = TRUE)
  # ----Create Training and Test data----#
  print("#-----------------------Create Training and Test data------------------------------#")
  # setting seed to reproduce results of random sampling
  set.seed(100) 
  
  #print title 
  print("trainingRowIndex:")
  # row indices for training data and predict on test data
  trainingRowIndex <- sample(1:nrow(tempoz2), 0.8*nrow(tempoz2)) 
  #print trainingRowIndex results
  print(trainingRowIndex)
  
  #print title
  print("Model Training data:")
  # model training data
  trainingData <- tempoz2[trainingRowIndex, ]  
  #print trainingData results 
  print(trainingData)
  
  #print title
  print("Test Data:")
  # test data
  testData  <- tempoz2[-trainingRowIndex, ]   
  #print testdata results
  print(testData)
  
  
  # ----Fit the model on training data and predict dist on test data----#
  print("#-----------Fit the model on training data and predict dist on test data---------#")
  # print title 
  print("Model based on Training Data:")
  # Build the model on training data
  lmMod <- lm(Ozone.Mean.by.Month ~ Temperature.Mean.by.Month, data=trainingData)
  # print lmMod results
  print("lmMod results: ")
  print(lmMod)
  print("Summary staistics of lmMod: ")
  #summary
  summary(lmMod)
  
  #print title
  print("Predict Ozone:")
  # predict ozone
  ozonePred <- predict(lmMod, testData)  
  # print ozone predictions
  print(ozonePred)
  
  
  # ----Calculate prediction accuracy and error rates----#
  print("#-----------------------Calculate prediction accuracy and error rates-----------------------------#")
  # make actuals_predicteds dataframe.
  actuals_preds <- data.frame(cbind(actuals=testData$Ozone.Mean.by.Month, predicteds=ozonePred))
  #print title 
  print("Actual vs predictions: ")
  #print the start values of actuals_preds
  head(actuals_preds)
  
  #print title
  print("Correlation Accuracy for actual and predictions: ")
  correlation_accuracy <- cor(actuals_preds) 
  #print results
  print(correlation_accuracy)
  
  
  # ----------------Min Max accuracy and MAPE------------------#
  print("#-----------------------Min Max accuracy and MAPE-----------------------------#")
  #print title 
  print("Min-Max Accuracy: ")
  # Min-Max Accuracy Calculation
  min_max_accuracy <- mean(apply(actuals_preds, 1, min) / apply(actuals_preds, 1, max))  
  #print results
  print(min_max_accuracy)
  
  #print title
  print("MAPE(mean absolute percentage deviation) Calculation: ")
  # MAPE (mean absolute percentage deviation) Calculation
  mape <- mean(abs((actuals_preds$predicteds - actuals_preds$actuals))/actuals_preds$actuals)  
  #print results
  print(mape)
}

#-------------------------------create pdfs to create all plots from all csv files-----------------#
pdf("~/Documents/savedfilesforstats/plot2013.pdf")
analyze("~/Documents/combinedOzoneTemp/combinedOzoneTemp Ozone_vs_Temperature_2013.CSV")
dev.off()

pdf("~/Documents/savedfilesforstats/plot2014.pdf")
analyze("~/Documents/combinedOzoneTemp/combinedOzoneTemp Ozone_vs_Temperature_2014.CSV")
dev.off()

pdf("~/Documents/savedfilesforstats/plot2015.pdf")
analyze("~/Documents/combinedOzoneTemp/combinedOzoneTemp Ozone_vs_Temperature_2015.CSV")
dev.off()

pdf("~/Documents/savedfilesforstats/plot2016.pdf")
analyze("~/Documents/combinedOzoneTemp/combinedOzoneTemp Ozone_vs_Temperature_2016.CSV")
dev.off()

pdf("~/Documents/savedfilesforstats/plot2017.pdf")
analyze("~/Documents/combinedOzoneTemp/combinedOzoneTemp Ozone_vs_Temperature_2017.CSV")
dev.off()

pdf("~/Documents/savedfilesforstats/plot2018.pdf")
analyze("~/Documents/combinedOzoneTemp/combinedOzoneTemp Ozone_vs_Temperature_2018.CSV")
dev.off()


#-------------------------------create textfiles to create all stats from all csv files-----------------#
sink( "~/Documents/savedfilesforstats/graphicalAnalysiStats2013.txt")
analyze3("~/Documents/combinedOzoneTemp/combinedOzoneTemp Ozone_vs_Temperature_2013.CSV")
sink() 


sink( "~/Documents/savedfilesforstats/graphicalAnalysiStats2014.txt")
analyze3("~/Documents/combinedOzoneTemp/combinedOzoneTemp Ozone_vs_Temperature_2014.CSV")
sink() 

sink( "~/Documents/savedfilesforstats/graphicalAnalysiStats2015.txt")
analyze3("~/Documents/combinedOzoneTemp/combinedOzoneTemp Ozone_vs_Temperature_2015.CSV")
sink() 

sink( "~/Documents/savedfilesforstats/graphicalAnalysiStats2016.txt")
analyze3("~/Documents/combinedOzoneTemp/combinedOzoneTemp Ozone_vs_Temperature_2016.CSV")
sink() 

sink( "~/Documents/savedfilesforstats/graphicalAnalysiStats2017.txt")
analyze3("~/Documents/combinedOzoneTemp/combinedOzoneTemp Ozone_vs_Temperature_2017.CSV")
sink() 

sink( "~/Documents/savedfilesforstats/graphicalAnalysiStats2018.txt")
analyze3("~/Documents/combinedOzoneTemp/combinedOzoneTemp Ozone_vs_Temperature_2018.CSV")
sink() 

#-------------------------------create textfiles to create all stats from all csv files-----------------#
sink( "~/Documents/savedfilesforstats/linearModelStats2013.txt")
analyze4("~/Documents/combinedOzoneTemp/combinedOzoneTemp Ozone_vs_Temperature_2013.CSV")
sink() 


sink( "~/Documents/savedfilesforstats/linearModelStats2014txt")
analyze4("~/Documents/combinedOzoneTemp/combinedOzoneTemp Ozone_vs_Temperature_2014.CSV")
sink() 

sink( "~/Documents/savedfilesforstats/linearModelStats2015.txt")
analyze4("~/Documents/combinedOzoneTemp/combinedOzoneTemp Ozone_vs_Temperature_2015.CSV")
sink() 

sink( "~/Documents/savedfilesforstats/linearModelStats2016.txt")
analyze4("~/Documents/combinedOzoneTemp/combinedOzoneTemp Ozone_vs_Temperature_2016.CSV")
sink() 

sink( "~/Documents/savedfilesforstats/linearModelStats2017.txt")
analyze4("~/Documents/combinedOzoneTemp/combinedOzoneTemp Ozone_vs_Temperature_2017.CSV")
sink() 

sink( "~/Documents/savedfilesforstats/linearModelStats2018.txt")
analyze4("~/Documents/combinedOzoneTemp/combinedOzoneTemp Ozone_vs_Temperature_2018.CSV")
sink() 



