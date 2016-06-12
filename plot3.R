
library(gsubfn)
library(data.table)
library(lubridate)

if (!exists("dt")) {
  dt <- fread("household_power_consumption.txt",  sep=";", header = TRUE);
}

dt2 <- transform(dt, Date2=as.Date(Date, "%d/%m/%Y"), Time2=strptime(paste(Date,Time,sep=" "), "%d/%m/%Y %H:%M:%S") );
dt3 <- dt2[Date2>=as.Date(as.character("2007-02-01"), "%Y-%m-%d") & Date2<=as.Date(as.character("2007-02-02"), "%Y-%m-%d")]
dt3 <- transform(dt3, Global_active_power=as.numeric(Global_active_power) );

# plot 1
png(filename="plot3.png", width=480, height=480)
plot(dt3$Sub_metering_1~dt3$Time2, ylab="Energy sub metering", xlab="", type="l")
lines(dt3$Time2, dt3$Sub_metering_2, col = "red")
lines(dt3$Time2, dt3$Sub_metering_3, col = "blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black", "red","blue"), lty=c(1,1,1));
dev.off();

