# Read power data from the 'txt' file
power_data <- read.table("household_power_consumption.txt", sep=";", skip=1)
# Retrieve names of power consumption data
names(power_data) <- c(
    "Date", "Time", "Global_active_power",
    "Global_reactive_power", "Voltage",
    "Global_intensity", "Sub_metering_1",
    "sub_metering_2", "Sub_metering_3"
)
# Subset the retrieved power consumption data
sub_power_data <- subset(
    power_data,
    power_data$Date == "1/2/2007" | power_data$Date == "2/2/2007"
)
# Change class of columns (Date and Time)
sub_power_data$Time <- strptime(sub_power_data$Time, format="%H:%M:%S")
sub_power_data$Date <- as.Date(sub_power_data$Date, format="%d/%m/%Y")
sub_power_data[1:1440,"Time"] <- format(sub_power_data[1:1440,"Time"],"2007-02-01 %H:%M:%S")
sub_power_data[1441:2880,"Time"] <- format(sub_power_data[1441:2880,"Time"],"2007-02-02 %H:%M:%S")
# Open a device and save plot
dev.copy(png, 'plot4.png')
# initiate multiple plot on a single page (i.e. composite plot with sub plots)
par(mfrow=c(2,2))
# Plot the retrieved data
plot(
    sub_power_data$Time, 
    as.numeric(
        sub_power_data$Global_active_power
    ),
    type="l",
    xlab="",
    ylab="Global Active Power"
)
plot(
    sub_power_data$Time,
    as.numeric(
        sub_power_data$Voltage
    ),
    type="l",
    xlab="datetime",
    ylab="Voltage"
)
plot(
    sub_power_data$Time,
    sub_power_data$Sub_metering_1,
    type="n",
    xlab="",
    ylab="Energy sub metering"
)
with(
    sub_power_data,
    lines(
        sub_power_data$Time, 
        as.numeric(as.character(sub_power_data$Sub_metering_1))
    )
)
with(
    sub_power_data,
    lines(
        sub_power_data$Time, 
        as.numeric(as.character(sub_power_data$sub_metering_2)),
        col="red"
    )
)
with(
    sub_power_data,
    lines(
        sub_power_data$Time, 
        as.numeric(as.character(sub_power_data$Sub_metering_3)),
        col="blue"
    )
)
legend(
    "topright", 
    col=c("black", "red", "blue"), 
    legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
    lty=, 
    lwd=2.5,
    bty="o"
)
plot(
    sub_power_data$Time,
    as.numeric(
        sub_power_data$Global_active_power
    ),
    type="l",
    xlab="datetime",
    ylab="Global_reactive_power"
)
# Close the device after saving
dev.off()