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
with(house, {
        plot(Sub_metering_1~dateTime, type="l",
             ylab="Global Active Power (kilowatts)", xlab="")
        lines(Sub_metering_2~dateTime,col='Red')
        lines(Sub_metering_3~dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Save file, create plot3.png, and close the device
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()