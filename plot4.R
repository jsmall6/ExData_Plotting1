#Plot 4 - Energy Sub metering
install.packages("dplyr")
library(dplyr)

setwd("C://Users//jsmall//Documents//GitHub//ExData_Plotting1")
fileHandle <- "./Data/household_power_consumption.txt"

d <- read.csv(fileHandle, sep=";", na.strings="?", header=TRUE, stringsAsFactors = TRUE)

d$Date <- as.Date(d$Date, "%d/%m/%Y")

stDate <- as.Date("2/1/2007", "%m/%d/%Y")
endDate <- as.Date("2/2/2007", "%m/%d/%Y")

#Filter the data set using dplyr between the target dates.
df <- filter(d, Date >= stDate & Date <= endDate)

df$sDateTime <- paste(df$Date, as.character(df$Time))
df$sDateTime<-as.POSIXct(df$sDateTime)

#Recode the values as appropriate data types.
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))
df$Sub_metering_1 <- as.numeric(df$Sub_metering_1)
df$Sub_metering_2 <- as.numeric(df$Sub_metering_2)
df$Sub_metering_3 <- as.numeric(df$Sub_metering_3)
df$Voltage <- as.numeric(df$Voltage)


#check the summary results of each column.
summary(df)

summary(df$Voltage)

#set par settings
par(mfrow=c(2,2))

#plot 1
plot(
  df$sDateTime
  ,df$Global_active_power
  ,ylab="Global Active Power (kilowatts)"
  ,type = "n"
  ,xlab = ""
)
#Add lines to the graph
with(df, lines(sDateTime, Global_active_power, type="l"))

#plot 2
plot(
  df$sDateTime
  ,df$Votage
  ,ylab="Voltage"
  ,type = "n"
  ,xlab = "datetime"
)
#Add lines to the graph
with(df, lines(sDateTime, Voltage, type="l"))


#plot 3
xrange <- range(df$sDateTime)
yrange <- range(c(na.omit(df$Sub_metering_1), 
                  na.omit(df$Sub_metering_2),
                  na.omit(df$Sub_metering_3)))

plot(xrange
     ,yrange
     ,xlim = xrange
     ,ylab = "Energy Sub Metering"
     ,xlab = ""
     ,type = "n"
)
with(df, lines(sDateTime, Sub_metering_1, type="l", col="black"))
with(df, lines(sDateTime, Sub_metering_2, type="l", col="red"))
with(df, lines(sDateTime, Sub_metering_3, type="l", col="blue"))
legend("topright", 
       lty = 1,
       col=c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#plot 4
plot(
  df$sDateTime
  ,df$Global_reactive_power
  ,ylab="Global_reactive_power"
  ,type = "n"
  ,xlab = "datetime"
)
#Add lines to the graph
lines(df$sDateTime, df$Global_reactive_power)










dev.off()

