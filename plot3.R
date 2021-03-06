
# read in data
library(data.table)
power <- fread("household_power_consumption.txt")

# create DateTime column

library(dplyr)
power <- mutate(power, DateTime <- paste(Date, Time))

# convert DateTime, Date to class Lubridate

library(lubridate)
power$Date <- dmy(power$Date)
power$DateTime <- dmy_hms(power$DateTime)

# filter out data from dates 2007-02-01 and 2007-02-02

power <- filter(power, Date == ymd("2007:02:01") 
                | Date == ymd("2007:02:02"))

# convert columns to numeric

power$Global_active_power <- as.numeric(power$Global_active_power)
power$Sub_metering_1 <- as.numeric(power$Sub_metering_1)
power$Sub_metering_2 <- as.numeric(power$Sub_metering_2)
power$Sub_metering_3 <- as.numeric(power$Sub_metering_3)

# create plot

png("plot3.png", width = 480, height=480)

par(bg='transparent')

plot(power$DateTime, power$Sub_metering_1, type='l', pch = 26,
     col='black', main=NA, xlab=NA, ylab=NA)
lines(power$DateTime, power$Sub_metering_2, type='l', pch=26,
      col='red')
lines(power$DateTime, power$Sub_metering_3, type='l', pch=26,
      col='blue')
title(ylab="Energy sub metering")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", 
        "Sub_metering_3"), lty = c(1,1,1), col = c("black", "red", "blue"))

dev.off()