% Exploratory Data Analysis week 1 project

% downloading the data
fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file<- "./assignment1data/assign1.zip"

if (!file.exists("assignment1data")){
	dir.create("assignment1data")
}
download.file(fileURL, file)
unzip(file, "household_power_consumption.txt")

% creating the dataset
data<-read.table("household_power_consumption.txt", sep=";",header=TRUE)

% converting the data and time variables
names(data)<-tolower(names(data))
data$date<-as.character(data$date)
data$time<-as.character(data$time)

data$comb<-paste(data$date, data$time, sep=" ")
data$combDate<-strptime(data$comb,"%d/%m/%Y %H:%M:%S")

data$date<-as.Date(data$date, "%d/%m/%Y")



febData<-data[data$date>="2007-02-01" & data$date<="2007-02-02",]

% converting numeric variables 

febData$global_active_power<-as.numeric(as.character(febData$global_active_power))
febData$sub_metering_1<-as.numeric(as.character(febData$sub_metering_1))
febData$sub_metering_2<-as.numeric(as.character(febData$sub_metering_2))
febData$sub_metering_3<-as.numeric(as.character(febData$sub_metering_3))
febData$voltage<-as.numeric(as.character(febData$voltage))
febData$global_reactive_power<-as.numeric(as.character(global_reactive_power))


% creating multple lots

par(mfrow=c(2,2))
plot(febData$combDate,febData$global_active_power, type="l", col="black", xlab="", ylab="Global Active Power")
plot(febData$combDate,febData$voltage, type="l", col="black", xlab="datetime", ylab="Voltage")
plot(febData$combDate,febData$sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1), col=c("black","red","blue"))
points(febData$combDate,febData$sub_metering_2,col="red", type="l")
points(febData$combDate,febData$sub_metering_3,col="blue", type="l")
plot(febData$combDate,febData$global_reactive_power, type="l", col="black", xlab="", ylab="Global Reactive Power")


dev.copy(png, file="plot4.png")
dev.off()
