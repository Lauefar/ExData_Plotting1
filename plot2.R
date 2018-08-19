electricity <-read.table("household_power_consumption.txt", 
                         header = TRUE, sep = ";",na.strings="?",
                         colClasses = c(c("date","date"),rep("numeric",7)) )

t <- subset(electricity, Date %in% c("1/2/2007","2/2/2007"))
t$Date <- as.Date(t$Date, format="%d/%m/%Y")

#Create a col with a timeformat using both day -date and hour  
library(dplyr) #mutate %>%
t <-  t %>%
  mutate(Datetime= as.POSIXct(strptime(paste(t$Date, t$Time, sep=" "), "%Y-%m-%d %H:%M:%S")))

#Create PNG
par(mfrow = c(1, 1))
png("plot2.png", width=480, height=480)
with(t,plot(Global_active_power ~ Datetime, 
       ylab="Global Active Power (kilowatts)",
       type="l",xlab=""))
dev.off()

