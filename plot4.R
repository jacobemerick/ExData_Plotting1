## This script will create a png with 4 graphs as per plot4 specs
## Make sure you are in the same wd as the raw data
## File is output in the same wd
## Note: data is large (133 MB+) and will eat up computer memory like cray

# read in and format the data appropriately
data <- read.table(
    "household_power_consumption.txt",
    header = TRUE,
    sep = ";",
    na.strings = "?"
)

data$DateTime <- paste(data$Date, data$Time)
data$DateTime <- strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")

# get the subset of the data we are interested in
subset <- data[
    data$DateTime >= as.POSIXlt("2007-02-01 00:00:00") &
    data$DateTime < as.POSIXlt("2007-02-02 24:00:00"),]

# setup the multi-frame plot
png("plot4.png", height = 480, width = 480)
par(mfrow = c(2, 2))

# first line plot, from plot2 specs
plot(
    subset$DateTime,
    subset$Global_active_power,
    type = "l",
    main = "",
    xlab = "",
    ylab = "Global Active Power"
)

# second line plot, voltage over date
plot(
    subset$DateTime,
    subset$Voltage,
    type = "l",
    main = "",
    xlab = "datetime",
    ylab = "Voltage"
)

#third line plot, multi-line from plot3
plot(
    subset$DateTime,
    subset$Sub_metering_1,
    type = "l",
    col = "black",
    main = "",
    xlab = "",
    ylab = "Energy sub metering"
)
lines(
    subset$DateTime,
    subset$Sub_metering_2,
    type = "l",
    col = "red"
)
lines(
    subset$DateTime,
    subset$Sub_metering_3,
    type = "l",
    col = "blue"
)
legend(
    "topright",
    legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
    lty = 1,
    col = c("black", "red", "blue")
)

# fourth plot, reactive power over time
plot(
    subset$DateTime,
    subset$Global_reactive_power,
    type = "l",
    main = "",
    xlab = "datetime",
    ylab = "Global_reactive_power"
)
dev.off()
