
# read in data
library(data.table)
power <- fread("household_power_consumption.txt")

# convert date/time variables to class Lubridate

library(lubridate)
power$Date <- dmy(power$Date)
power$Time <- hms(power$Time)

# filter out data from dates 2007-02-01 and 2007-02-02

library(dplyr)
power <- filter(power, Date == ymd("2007:02:01") 
                 | Date == ymd("2007:02:02"))
                
# convert columns to numeric

power$Global_active_power <- as.numeric(power$Global_active_power)

# create plot

png("plot1.png", width = 480, height=480)

par(bg='transparent')

hist(power$Global_active_power, col='red', main=NA, xlab=NA, ylab=NA)
title(main="Global Active Power", xlab = "Global Active Power (kilowatts)",
      ylab="Frequency")

dev.off()




                