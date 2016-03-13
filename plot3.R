#the file is in the wd

#file name
archivo <- 'household_power_consumption.txt'

#column names
colNames <- c("date", "time", "globalActivePower", "globalReactivePower", "voltage", "globalIntensity", "subMetering1", "subMetering2", "subMetering3")
colClasses <- c("character", "character", rep("numeric",7) )

#read file
datos <- read.table(archivo, header=TRUE, sep=";", col.names=colNames, colClasses=colClasses, na.strings="?")

#convert to Date type, then filter
datos$date <- as.Date(datos$date, format="%d/%m/%Y")
datos <- datos[datos$date >= as.Date("2007-02-01") & datos$date<=as.Date("2007-02-02"),]

#plot and save graph
png(filename="plot3.png", width=480, height=480, units="px")
with(datos, {
  plot(subMetering1,type="l", xaxt="n", xlab="", ylab="Energy sub metering")
  lines(x=subMetering2, col="red")
  lines(x=subMetering3, col="blue")
})
axis(1, at=c(1, as.integer(nrow(datos)/2), nrow(datos)), labels=c("Thu", "Fri", "Sat"))
legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()