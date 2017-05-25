# load libs
library(lubridate)

# read data from disk
df.data <- read.csv2(file = "household_power_consumption.txt",
                     header = TRUE,
                     na.strings = c("?"),
                     stringsAsFactors = FALSE)

# parse date column
df.data$Date <- as.Date(x = df.data$Date,
                        format = "%d/%m/%Y")

# subset data
df.dataSub <-filter(df.data, df.data$Date >= '2007-02-01' &
                      df.data$Date <= '2007-02-02')

# pasrse data column
df.dataSub$Global_active_power <- as.numeric(df.dataSub$Global_active_power)

# open png device
png(filename = "plot1.png",
    width = 480,
    height = 480,
    bg = "transparent")

# plot histogram global active power
hist(x = df.dataSub$ Global_active_power,
     breaks = 15,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

# close png device
dev.off()