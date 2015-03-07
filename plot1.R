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

# date format
dateFormat <-'%d/%m/%Y'

# dates are converted to POSIX
data$Date <- strptime(data$Date,dateFormat)

# we are only interested in the data between...
startDate <- strptime("01/02/2007",dateFormat)

# ...and...
endDate <- strptime("02/02/2007",dateFormat)

# the data between the above dates
dataOfInterest <- data[(data$Date >= startDate) & (data$Date <= endDate),]

# plot
hist(dataOfInterest$Global_active_power,xlab='Global Active Power (kilowatts)',main='Global Active Power',col='red')

# the plot on the screen is saved to png
dev.copy(png,file='plot1.png',width=480,height=480)

# the device is closed
dev.off()