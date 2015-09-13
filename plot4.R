# 4th Plot (with 4 graphs on same page)
#
# Reading data
my_data <- read.csv(
      "household_power_consumption.txt", 
#      colClasses = c(NA, NA, "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"),
      sep =";", 
      dec=".")

# Transform input colums to Date & Date/Time
my_data$Date_Time <- with(my_data, 
                          strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"))
my_data$Date <- with(my_data, as.Date(Date, format="%d/%m/%Y"))

# Subsetting the data
my_sdata <- subset(
      my_data, 
      Date >= as.Date("01/02/2007", format="%d/%m/%Y") 
         & Date <= as.Date("02/02/2007", format="%d/%m/%Y") 
         & Global_active_power != "?"
         & Global_reactive_power != "?"
         & Voltage != "?"
         & Sub_metering_1 != "?"
         & Sub_metering_2 != "?"
         & Sub_metering_3 != "?"
)

# Transform some columns to Double
my_sdata$Global_active_power <- as.numeric(as.character(my_sdata$Global_active_power))
my_sdata$Global_reactive_power <- as.numeric(as.character(my_sdata$Global_reactive_power))
my_sdata$Voltage <- as.numeric(as.character(my_sdata$Voltage))
my_sdata$Sub_metering_1 <- as.numeric(as.character(my_sdata$Sub_metering_1))
my_sdata$Sub_metering_2 <- as.numeric(as.character(my_sdata$Sub_metering_2))
my_sdata$Sub_metering_3 <- as.numeric(as.character(my_sdata$Sub_metering_3))

# Setting Output to 2x2
par(mfrow=c(2,2))

# 1. Plot
plot(my_sdata$Date_Time,
     my_sdata$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power"
)

# 2. Plot
plot(my_sdata$Date_Time,
     my_sdata$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage"
)

# 3. Plot
plot(my_sdata$Date_Time,
     my_sdata$Sub_metering_1,
     type = "n",
     xlab = "",
     ylab = "Energy sub metering"
)

lines(my_sdata$Date_Time,
     my_sdata$Sub_metering_1)

lines(my_sdata$Date_Time,
       my_sdata$Sub_metering_2,
       col="red")

lines(my_sdata$Date_Time,
      my_sdata$Sub_metering_3,
      col="blue")

legend('topright', cex= 0.75, lty=1, bty = "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),  col=c("black", 'red', 'blue'))

# 4. Plot
plot(my_sdata$Date_Time,
     my_sdata$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power"
)

# Saving to File
dev.print(
      png, 
      "plot4.png",
      width = 480,
      height = 480)

