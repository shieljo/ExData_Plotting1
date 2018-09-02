plot1<-function()
{
  #If the files haven't been downloaded before,
  #then download them
  if(!file.exists(".\\data\\household_power_consumption.zip"))
  {
    getData()  
  }
  
  column_names=colnames(read.table(
    ".\\data\\household_power_consumption.txt",
    header=TRUE,
    sep=";",
    nrows=1 ))
  
  column_classes<-c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
  
  
  #Load the data.
  #Skip the first 60,000 rows
  #and load the next 10,000 rows.
  #The data for 1 Jan 2007 and 2 Jan 2007 are in this subset
  df<-read.table(
    ".\\data\\household_power_consumption.txt",
    header=TRUE,
    sep=";",
    na.strings = "?",
    skip=60000,
    nrows=10000,
    col.names=column_names,
    colClasses = column_classes )

  #df$Date<-as.Date(df$Date)
  
  #subset this down to the date range required
  df<-df[df$Date %in% c("1/2/2007","2/2/2007"),]

  png("plot1.png", width = 480, height = 480)
    
  #create the plot
  hist(df$Global_active_power,
       main = "Global Active Power",
       xlab = "Global Active Power (kilowatts)",
       col = "red")

  dev.off()  
}


getData<-function()
{
  if(!file.exists(".\\Data"))
  {
    dir.create(".\\Data")
  }
  
  fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  
  download.file(fileURL, destfile=".\\Data\\household_power_consumption.zip",method="curl")
  
  unzip(".\\data\\household_power_consumption.zip", exdir=".\\Data")
}
