# Load and Clean the Data
house <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Format date to Type Date
house$Date <- as.Date(house$Date, "%d/%m/%Y")

## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
house <- subset(house,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Remove incomplete observation
house <- house[complete.cases(house),]

## Combine Date and Time column
dateTime <- paste(house$Date, house$Time)

## Name the vector
dateTime <- setNames(dateTime, "DateTime")

## Remove Date and Time column
house <- house[ ,!(names(house) %in% c("Date","Time"))]

## Add DateTime column
house <- cbind(dateTime, house)

## Format dateTime Column
house$dateTime <- as.POSIXct(dateTime)

## Create Plot 
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(house, {
        plot(Global_active_power~dateTime, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")
        plot(Voltage~dateTime, type="l", 
             ylab="Voltage (volt)", xlab="")
        plot(Sub_metering_1~dateTime, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")
        lines(Sub_metering_2~dateTime,col='Red')
        lines(Sub_metering_3~dateTime,col='Blue')
        legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power~dateTime, type="l", 
             ylab="Global Rective Power (kilowatts)",xlab="")
})

## Save file, create plot4.png, and close the device
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
