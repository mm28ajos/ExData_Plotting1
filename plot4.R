# load libs
library(lubridate)

# read data from disk
df.data <- read.csv2(file = "household_power_consumption.txt",
                     header = TRUE,
                     na.strings = c("?"),
                     stringsAsFactors = FALSE)

# concate date and time column and parse
df.data$DateTime <- dmy_hms(paste(df.data$Date,
                                  df.data$Time))

# parse date column
df.data$Date <- as.Date(x = df.data$Date,
                        format = "%d/%m/%Y")

# subset data
df.dataSub <-filter(df.data, df.data$Date >= '2007-02-01' &
                      df.data$Date <= '2007-02-02')

# parse data column to integer
df.dataSub$Sub_metering_1 <- as.numeric(df.dataSub$Sub_metering_1)
df.dataSub$Sub_metering_2 <- as.numeric(df.dataSub$Sub_metering_2)
df.dataSub$Sub_metering_3 <- as.numeric(df.dataSub$Sub_metering_3)
df.dataSub$Global_active_power <- as.numeric(df.dataSub$Global_active_power)
df.dataSub$Voltage <- as.numeric(df.dataSub$Voltage)
df.dataSub$Global_reactive_power <- as.numeric(df.dataSub$Global_reactive_power)

# open png device
png(filename = "plot4.png",
    width = 480,
    height = 480,
    bg = "transparent")

# set mfrow
par(mfrow = c(2,2),
    mar = c(4,4,1,1))

# plot global active power
plot(x = df.dataSub$DateTime,
     y = df.dataSub$Global_active_power,
     type = "l",
     ylab = "Global Active Power",
     xlab = "")

# plot voltage
plot(x = df.dataSub$DateTime,
     y = df.dataSub$Voltage,
     type = "l",
     ylab = "Voltage",
     xlab = "datetime")

# plot sub meterings
plot(x = df.dataSub$DateTime,
     y = df.dataSub$Sub_metering_1,
     type = "l",
     ylab = "Energy sub metering",
     xlab = "",
     col = "black")

points(x = df.dataSub$DateTime,
       y = df.dataSub$Sub_metering_2,
       type = "l",
       ylab = "Energy sub metering",
       xlab = "",
       col = "red")

points(x = df.dataSub$DateTime,
       y = df.dataSub$ Sub_metering_3,
       type = "l",
       ylab = "Energy sub metering",
       col = "blue",
       xlab = "")

# add legend
legend(x = "topright",
       legend = c("Sub_metering_1",
                  "Sub_metering_2",
                  "Sub_metering_3"),
       col = c("black",
               "red",
               "blue"),
       bty = "n",
       lty = 1)

# plot global reactive power
plot(x = df.dataSub$DateTime,
     y = df.dataSub$Global_reactive_power,
     type = "l",
     ylab = "Global_reavtive_power",
     xlab = "datetime")

# close png device
dev.off()
