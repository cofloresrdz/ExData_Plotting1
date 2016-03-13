#the file is in the wd

#nombre del archivo
archivo <- 'household_power_consumption.txt'

#nombre y clases de las columnas
colNames <- c("date", "time", "globalActivePower", "globalReactivePower", "voltage", "globalIntensity", "subMetering1", "subMetering2", "subMetering3")
colClasses <- c("character", "character", rep("numeric",7) )

#leer el archivo 
datos <- read.table(archivo, header=TRUE, sep=";", col.names=colNames, colClasses=colClasses, na.strings="?")

#convertir a data type y subsetting
datos$date <- as.Date(datos$date, format="%d/%m/%Y")
datos <- datos[datos$date >= as.Date("2007-02-01") & datos$date<=as.Date("2007-02-02"),]

#graficar y guardar el png
png(filename="plot4.png", width=480, height=480, units="px")

par(mfrow=c(2,2))

#Global Active Power Graph 
plot(datos$globalActivePower, type="l",xaxt="n",xlab="", ylab="Global Active Power")
axis(1, at=c(1, as.integer(nrow(datos)/2), nrow(datos)), labels=c("Thu", "Fri", "Sat"))

#Voltage Graph
plot(datos$voltage, type="l",xaxt="n",xlab="datetime", ylab="Voltage")
axis(1, at=c(1, as.integer(nrow(datos)/2), nrow(datos)), labels=c("Thu", "Fri", "Sat"))


#subMetering1 Graph
with(datos, {
  plot(subMetering1,type="l", xaxt="n", xlab="", ylab="Energy sub metering")
  lines(x=subMetering2, col="red")
  lines(x=subMetering3, col="blue")
})
axis(1, at=c(1, as.integer(nrow(datos)/2), nrow(datos)), labels=c("Thu", "Fri", "Sat"))
legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), box.lwd = 0,box.col = "transparent", bg="transparent")

#Global Reactive Power Graph
plot(datos$globalReactivePower, type="l",xaxt="n",xlab="datetime", ylab="Global Reactive Power")
axis(1, at=c(1, as.integer(nrow(datos)/2), nrow(datos)), labels=c("Thu", "Fri", "Sat"))

dev.off()