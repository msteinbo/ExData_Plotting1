# Plotting Linechart of global active Power
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
)

# Transform column 'Global_active_power' to Double
my_sdata$Global_active_power <- as.numeric(as.character(my_sdata$Global_active_power))

# Plotting the chart
plot(my_sdata$Date_Time,
     my_sdata$Global_active_power,
     type="l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

# Saving to File
dev.print(
      png, 
      "plot2.png",
      width = 480,
      height = 480)

