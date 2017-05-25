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

# parse data column
df.dataSub$Global_active_power <- as.numeric(df.dataSub$Global_active_power)

# open png device
png(filename = "plot2.png",
    width = 480,
    height = 480,
    bg = "transparent")

# plot global active power
plot(x = df.dataSub$DateTime,
     y = df.dataSub$Global_active_power,
     type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")

# close png device
dev.off()
