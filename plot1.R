# Plotting Histogram of global active Power
#
# Reading data
my_data <- read.csv(
      "household_power_consumption.txt", 
#      colClasses = c(NA, NA, "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"),
      sep =";", 
      dec=".")

# Transform column 'Date' to Date
my_data$Date <- as.Date(my_data$Date, format="%d/%m/%Y")

# Subsetting the data
my_sdata <- subset(
      my_data, 
      Date >= as.Date("01/02/2007", format="%d/%m/%Y") 
         & Date <= as.Date("02/02/2007", format="%d/%m/%Y") 
         & Global_active_power != "?"
)

# Transform column 'Global_active_power' to Double
my_sdata$Global_active_power <- as.numeric(as.character(my_sdata$Global_active_power))

# Plotting the histogram
hist(
      my_sdata$Global_active_power,
      main = "Global Active Power",
      xlab = "Global Active Power (kilowatts)",
      col="red")

# Saving to File
dev.print(
      png, 
      "plot1.png",
      width = 480,
      height = 480)

