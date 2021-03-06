# Plotting several line-diagrams on same panel (using lines()) 
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
         & Sub_metering_1 != "?"
         & Sub_metering_2 != "?"
         & Sub_metering_3 != "?"
)

# Transform column necessary variables to Double
my_sdata$Sub_metering_1 <- as.numeric(as.character(my_sdata$Sub_metering_1))
my_sdata$Sub_metering_2 <- as.numeric(as.character(my_sdata$Sub_metering_2))
my_sdata$Sub_metering_3 <- as.numeric(as.character(my_sdata$Sub_metering_3))

# Plotting the empty diagram
plot(my_sdata$Date_Time,
     my_sdata$Sub_metering_1,
     type = "n",
     xlab = "",
     ylab = "Energy sub metering"
)

# Adding 1st line
lines(my_sdata$Date_Time,
     my_sdata$Sub_metering_1)

# Adding 2nd line
lines(my_sdata$Date_Time,
       my_sdata$Sub_metering_2,
       col="red")

# Adding 3rd line
lines(my_sdata$Date_Time,
      my_sdata$Sub_metering_3,
      col="blue")

# Adding legend
legend('topright', lty=1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),  col=c("black", 'red', 'blue'))

# Saving to File
dev.print(
      png, 
      "plot3.png",
      width = 480,
      height = 480)

