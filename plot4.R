electricity <-read.table("household_power_consumption.txt", 
                         header = TRUE, sep = ";",na.strings="?",
                         colClasses = c(c("date","date"),rep("numeric",7)) )

t <- subset(electricity, Date %in% c("1/2/2007","2/2/2007"))
t$Date <- as.Date(t$Date, format="%d/%m/%Y")

#Create a col with a timeformat using both day -date and hour  
library(dplyr) #mutate %>%
t <-  t %>%
  mutate(Datetime= as.POSIXct(strptime(paste(t$Date, t$Time, sep=" "), "%Y-%m-%d %H:%M:%S")))

#Create 2x2 PNG
par(mfrow = c(2, 2), 
    mar=c(4,4,2,1)    #number of lines in the fours sides 
    )
dev.cur() #Any open handles ? 
with(t,{
  
  plot(Global_active_power ~ Datetime, 
        ylab="Global Active Power (kilowatts)",
        type="l",xlab="")
     
  plot(Voltage ~ Datetime, ylab="Voltage",type="l")
  
  plot(Sub_metering_1 ~ Datetime, 
             ylab="Global Active Power (kilowatts)",
             type="l",xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         lwd=2,   #line tickness
         cex=0.7, #legend text size
         col=c("black", "red", "blue"))
  
  
  plot(Global_reactive_power ~ Datetime, ylab="Global_reactive_power",type="l")
 })

dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()

