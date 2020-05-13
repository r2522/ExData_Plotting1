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
Voltage <- as.numeric(data2$Voltage)
SubMetering1 <- as.numeric(data2$Sub_metering_1)
SubMetering2 <- as.numeric(data2$Sub_metering_2)
SubMetering3 <- as.numeric(data2$Sub_metering_3)
GlobalReactivePower <- as.numeric(data2$Global_reactive_power)

# 4 Multiple Plot
DateTime <- strptime(paste(data2$Date, data2$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
par(mfrow = c(2, 2)) 
# 1st Plot:
plot(DateTime, GlobalActivePower, type="l", xlab="", ylab="Global Active Power", cex=0.2)
# 2nd Plot:
plot(DateTime, Voltage, type="l", xlab="Datetime", ylab="Voltage")
# 3d Plot:
plot(DateTime, SubMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(DateTime, SubMetering2, type="l", col="red")
lines(DateTime, SubMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"), xjust = 1)
# 4th Plot:
plot(DateTime, GlobalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power", cex=0.2)

## Saving to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()




