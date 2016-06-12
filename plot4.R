
library(gsubfn)
library(data.table)
library(lubridate)

if (!exists("dt")) {
  dt <- fread("household_power_consumption.txt",  sep=";", header = TRUE);
}

if (!exists("dt2")) {
  dt2 <- transform(dt, Date2=as.Date(Date, "%d/%m/%Y"), Time2=strptime(paste(Date,Time,sep=" "), "%d/%m/%Y %H:%M:%S") );
}
if (!exists("dt3")) {
  dt3 <- dt2[Date2>=as.Date(as.character("2007-02-01"), "%Y-%m-%d") & Date2<=as.Date(as.character("2007-02-02"), "%Y-%m-%d")]
  dt3 <- transform(dt3, Global_active_power=as.numeric(Global_active_power) );
}

# plot 4 - all 4 plots
png(filename="plot4.png", width=480, height=480)
par(mfrow=c(2,2), mar=c(4,2,1,2))
# plot 1
plot(dt3$Time2, dt3$Global_active_power, ylab="Global active power (kilowatts)", xlab="", type="l")
# plot 2
plot(dt3$Time2, dt3$Voltage, ylab="Voltage", xlab="datetime", type="l")
# plot 3
plot(dt3$Sub_metering_1~dt3$Time2, ylab="Energy sub metering", xlab="", type="l")
lines(dt3$Time2, dt3$Sub_metering_2, col = "red")
lines(dt3$Time2, dt3$Sub_metering_3, col = "blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex=0.8, inset=0.09, bty="n", col=c("black", "red","blue"), lty=c(1,1,1));
# plot 4
plot(dt3$Time2, dt3$Global_reactive_power,  xlab="datetime", type="l")


dev.off();

