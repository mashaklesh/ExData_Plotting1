
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

# create plot

png("plot2.png", width = 480, height=480)

par(bg='transparent')

plot(power$DateTime, power$Global_active_power, type='l', pch = 26,
     col='black', main=NA, xlab=NA, ylab=NA)
title(ylab="Global Active Power (kilowatts)")

dev.off()