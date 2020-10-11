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

## Create the histogram
hist(house$Global_active_power, main="Global Active Power", 
     xlab = "Global Active Power (kilowatts)", col="red")

## Save file, create plot1.png, and close the device
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()