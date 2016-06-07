
library(gsubfn)
library(data.table)
library(lubridate)

if (!exists("dt")) {
  dt <- fread("household_power_consumption.txt",  sep=";", header = TRUE);
}

dt2 <- transform(dt, Date2=as.Date(Date, "%d/%m/%Y") );
dt3 <- dt2[Date2>=as.Date(as.character("2007-02-01"), "%Y-%m-%d") & Date2<=as.Date(as.character("2007-02-02"), "%Y-%m-%d")]
dt3 <- transform(dt3, Global_active_power=as.numeric(Global_active_power) );

# plot 1
png(filename="plot1.png", width=480, height=480)
hist(dt3$Global_active_power, xlab="Global active power (kilowatts)", col="red", main="Global Active Power")
dev.off();
