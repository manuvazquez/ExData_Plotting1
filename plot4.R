Sys.setlocale("LC_TIME", "en_US.UTF-8")

# URL to the "zip" file
fileURL <- 'http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'

# downloading
download.file(fileURL,destfile='household_power_consumption.zip')

# file must be unzipped
unzip('household_power_consumption.zip')

# data file name
file <- 'household_power_consumption.txt'

# data is read into a data.frame
data <- read.csv(file,sep=';',na.strings='?')

# date and time format
dateTimeFormat <-'%d/%m/%Y %H:%M:%S'

library(dplyr)

# we are only interested in the data between...
startDate <- as.POSIXct("01/02/2007 00:00:00",format=dateTimeFormat)

# ...and...
endDate <- as.POSIXct("02/02/2007 23:59:59",format=dateTimeFormat)

# "Date" and "Time" are parsed as POSIXct into a new column "DateTime", old columns removed, and only the data between
# the dates of interest is selected
dataOfInterest <- data %>% mutate(DateTime=as.POSIXct(paste(Date,Time),format=dateTimeFormat)) %>% 
	select(-Date,-Time) %>% filter(DateTime>=startDate & DateTime <=endDate)

# plotting in a 2x2 matrix
par(mfrow=c(2,2))

# (1,1)
plot(dataOfInterest$DateTime,dataOfInterest$Global_active_power,type='l',ylab='Global Active Power',
	 xlab='')

# (1,2)
plot(dataOfInterest$DateTime,dataOfInterest$Voltage,type='l',ylab='Voltage',xlab='datetime')

# (2,1)
plot(dataOfInterest$DateTime,dataOfInterest$Sub_metering_1,type='l',ylab='Energy sub metering',
	 xlab='',col='black')
lines(dataOfInterest$DateTime,dataOfInterest$Sub_metering_2,type='l',col='red')
lines(dataOfInterest$DateTime,dataOfInterest$Sub_metering_3,type='l',col='blue')
legend('topright',legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),lty=c(1,1),col=c('black','red','blue'),text.width=110000,bty='n')

# (2,2)
plot(dataOfInterest$DateTime,dataOfInterest$Global_reactive_power,type='l',ylab='Global_reactive_power',xlab='datetime')

# the plot on the screen is saved to png
dev.copy(png,file='plot4.png',width=480,height=480)

# the device is closed
dev.off()