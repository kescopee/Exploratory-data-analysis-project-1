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
dev.copy(png, 'plot2.png')
# Plot the retrieved data
plot(
    sub_power_data$Time,
    as.numeric(
        as.character(
            sub_power_data$Global_active_power
        )
    ),
    type="l",
    ylab="Global Active Power (kilowatts)",
    xlab="Day"
)
# Set plot title
title(main="Global Active Power Vs Time")
# Close the device after saving
dev.off()