# 1 Loading the data:

setwd("~/Desktop/Coursera")
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
File <- "./household_power_consumption.zip"
householdFile <- "./household_power_consumption.txt"

if (!file.exists(householdFile)) {
  download.file(URL, File, method = "curl")
  unzip(File, overwrite = T, exdir = "./")
}

# 2 Data Frame conversion:

data <- read.table("household_power_consumption.txt", header= TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
summary(data)

# 3 Subsetting the data (dates 2007-02-01 and 2007-02-02):

data2 <- data[data$Date %in% c("1/2/2007","2/2/2007"),]
GlobalActivePower <- as.numeric(data2$Global_active_power)

# 4 Time Series:
DateTime <- strptime(paste(data2$Date, data2$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
plot(DateTime, GlobalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
## Saving to file
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()

