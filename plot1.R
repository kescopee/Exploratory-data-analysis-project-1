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

# Open a device and save plot
dev.copy(png, 'plot1.png')

# Plot histogram of the retrieved data
hist(
    as.numeric(
        as.character(
            sub_power_data$Global_active_power
        )
    ),
    col="red",
    main="Global Active Power",
    xlab="Global Active Power (kilowatts)"
)

# Set plot title
title(main="Global Active Power")
# Close the device after saving
dev.off()