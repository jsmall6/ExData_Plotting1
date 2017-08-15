#Plot 2 - Global Active Power by Time
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

#Recode the values as appropriate data types.
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))


#check the summary results of each column.
summary(df$Global_active_power)

summary(df$sDateTime)
df$sDateTime<-as.POSIXct(df$sDateTime)
summary(df$sDateTime)

png(file="plot2.png",width=480,height=480)

#generate a basic plot.
plot(
      df$sDateTime
     ,df$Global_active_power
     ,ylab="Global Active Power (kilowatts)"
     ,type = "n"
     ,xlab = ""
)
#Add lines to the graph
lines(df$sDateTime, df$Global_active_power)

dev.off()

