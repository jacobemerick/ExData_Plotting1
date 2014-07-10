## This script will create a png of a line graph as per plot2 specs
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

# output the line plot
png("plot2.png", height = 480, width = 480)
plot(
    subset$DateTime,
    subset$Global_active_power,
    type = "l",
    main = "",
    xlab = "",
    ylab = "Global Active Power (kilowatts)"
)
dev.off()
