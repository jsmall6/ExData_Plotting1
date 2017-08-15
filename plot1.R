#Plot 1 - Global active power Hist
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

#Recode the values as appropriate data types.
#df$df$Time <- strptime(df$Time, "%H:%M:%S")
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))


#check the summary results of each column.
summary(df$Global_active_power)


png(file="plot1.png",width=480,height=480)

#generate a basic histogram file.
hist(df$Global_active_power
     ,xlab="Global Active Power (kilowatts)"
     ,ylab="Frequency"
     ,col="red"
     ,main="Global Active Power"
     ,ylim = c(0, 1200)
     )

dev.off()
