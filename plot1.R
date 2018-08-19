electricity <-read.table("household_power_consumption.txt", 
            header = TRUE, sep = ";",na.strings="?",
            colClasses = c(c("date","date"),rep("numeric",7)) )

t <- subset(electricity, Date %in% c("1/2/2007","2/2/2007"))
t$Date <- as.Date(t$Date, format="%d/%m/%Y")

par(mfrow = c(1, 1))
png("plot1.png", width=480, height=480)
with(t, hist(Global_active_power, 
             main="Global Active Power",
             xlab="Global Active Power (kilowatts)", 
             ylab="Frequency", col="Red"))
dev.off()
