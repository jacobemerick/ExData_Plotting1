## This script will create a png of a histogram as per plot1 specs
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

data$Date <- strptime(data$Date, "%d/%m/%Y")
data$Date <- as.Date(data$Date)

# get the subset of the data we are interested in
subset <- data[
    data$Date >= "2007-02-01" &
    data$Date <= "2007-02-02",]

# output the histogram
png("plot1.png", height = 480, width = 480)
hist(
    subset$Global_active_power,
    main = "Global Active Power",
    xlab = "Global Active Power (kilowatts)",
    ylab = "Frequency",
    col = "red"
)
dev.off()
