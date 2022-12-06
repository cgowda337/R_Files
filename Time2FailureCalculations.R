#a
#df <- time_to_failure
#x1 <- subset(df, Machine_ID == 1) 
#x2 <- subset(df, Machine_ID == 2)
#mean(x1$Time_to_failure_hr)
#mean(x2$Time_to_failure_hr)
#sd(x1$Time_to_failure_hr)
#sd(x2$Time_to_failure_hr)

#b
s1 <- subset(df, Supplier_ID == 1)
s2 <- subset(df, Supplier_ID == 2)
s3 <- subset(df, Supplier_ID == 3)

median(s1$Time_to_failure_hr)
median(s2$Time_to_failure_hr)
median(s3$Time_to_failure_hr)