# ======================================
# Predicting LOS using Random Forrest Regression Model
# ======================================
# Install and load RF package
#install.packages("randomForest")
library(randomForest)
# load data with numeric values only
data <- read.csv("/Users/Chetan/Desktop/NIS_Core_2017_Model_LOS.csv")
# Omit null values from dataset so random forrest will execute
# Replace NA values with column medians to maintain data integrity
data <- na.roughfix(data)
#Remove data columns that do not affect LOS
data <- subset(data, select = -c(I10_DX1,I10_DX2,I10_DX3,I10_DX4,I10_DX5,I10_DX6,I10_DX7,I10_DX8,I10_DX9,I10_DX10,I10_DX11,I10_DX12,I10_DX13,I10_DX14,I10_DX15,I10_DX16,I10_DX17,I10_DX18,I10_DX19,I10_DX20,I10_DX21,I10_DX22,I10_DX23,I10_DX24,I10_DX25,I10_DX26,I10_DX27,I10_DX28,I10_DX29,I10_DX30,I10_DX31,I10_DX32,I10_DX33,I10_DX34,I10_DX35,I10_DX36,I10_DX37,I10_DX38,I10_DX39,I10_DX40) )
data <- subset(data, select = -c(I10_PR1,I10_PR2,I10_PR3,I10_PR4,I10_PR5,I10_PR6,I10_PR7,I10_PR8,I10_PR9,I10_PR10,I10_PR11,I10_PR12,I10_PR13,I10_PR14,I10_PR15,I10_PR16,I10_PR17,I10_PR18,I10_PR19,I10_PR20,I10_PR21,I10_PR22,I10_PR23,I10_PR24,I10_PR25) )
data <- subset(data, select = -c(PRDAY1,PRDAY2,PRDAY3,PRDAY4,PRDAY5,PRDAY6,PRDAY7,PRDAY8,PRDAY9,PRDAY10,PRDAY11,PRDAY12,PRDAY13,PRDAY14,PRDAY15,PRDAY16,PRDAY17,PRDAY18,PRDAY19,PRDAY20,PRDAY21,PRDAY22,PRDAY23,PRDAY24,PRDAY25))
data <- subset(data, select = -c(KEY_NIS,DISCWT,DQTR,DRG,DRGVER,DRG_NoPOA,DXVER,HOSP_DIVISION,KEY_NIS,MDC,NIS_STRATUM,PRVER,YEAR))
#For Model testing only
#data <- subset(data, select = -c(HOSP_NIS))
# Divide up data into training (.008%) and testing (.002%) data 
set.seed(1)
train_size <- as.integer(0.008 * dim(data)[1])
train_ind <- sample(seq_len(dim(data)[1]), size = train_size)
train_data <- data[train_ind, ]
test_size <- as.integer(0.002 * dim(data)[1])
test_ind <- sample(seq_len(dim(data)[1]), size = test_size)
test_data <- data[test_ind, ]
#Confirm that data was divided up properly based on row count
dim(train_data)
dim(test_data)
# --------------------------------------
# train data and label variables
y <- train_data$LOS
X <- train_data[-which(names(train_data) == "LOS")]
# Run model with 100 decision trees
set.seed(1)
model <- randomForest(x = X, y = y, ntree = 1000, importance = TRUE)
model
# Show importance for each factor based on training model
importance(model)
# ---------------------------------------
# Plot correlation graph between highest importance variables
# install.packages("corrplot")
library(corrplot)
dataCorrelation <- data[, c(1,6,9,10,11,13,14,15,16,17,20)]
dataCorrelation <- cor(dataCorrelation)
corrplot(as.matrix(dataCorrelation), method="circle", type = "upper")
# Get more information about overall model
summary(model)
# Run Model and try to predict from data set
y_true <- test_data$LOS
X_test <- test_data[-which(names(test_data) == "LOS")]
y_pred <- predict(model, X_test)
y_pred
# Visualize true values vs predicted values to show model accuracy
#plot(y_true, type="l", col="blue")
#points(y_pred,type="l", pch=22, col="red")
plot(y_true, y_pred)
qqplot(y_true, y_pred)
# install.packages("ggplot2")
library("ggplot2")
#ggplot(y_true, y_pred)
# Calculate total Mean-Squared Error (MSE)
MSE <- mean((y_pred - y_true) ** 2)
MSE









