# ======================================
# Predicting chances of Patient Death using Classification through Random Forrest
# ======================================
# Install and load RF package
#install.packages("randomForest")
library(randomForest)
# load data with numeric values only
data <- read.csv("/Users/Craig/Desktop/NIS_Core_2017_Model_LOS.csv")
# Omit null values from dataset so random forrest will execute
# Replace NA values with column medians to maintain data integrity
data <- na.roughfix(data)
#Remove data columns that do not affect Death
data <- subset(data, select = -c(I10_DX1,I10_DX2,I10_DX3,I10_DX4,I10_DX5,I10_DX6,I10_DX7,I10_DX8,I10_DX9,I10_DX10,I10_DX11,I10_DX12,I10_DX13,I10_DX14,I10_DX15,I10_DX16,I10_DX17,I10_DX18,I10_DX19,I10_DX20,I10_DX21,I10_DX22,I10_DX23,I10_DX24,I10_DX25,I10_DX26,I10_DX27,I10_DX28,I10_DX29,I10_DX30,I10_DX31,I10_DX32,I10_DX33,I10_DX34,I10_DX35,I10_DX36,I10_DX37,I10_DX38,I10_DX39,I10_DX40) )
data <- subset(data, select = -c(I10_PR1,I10_PR2,I10_PR3,I10_PR4,I10_PR5,I10_PR6,I10_PR7,I10_PR8,I10_PR9,I10_PR10,I10_PR11,I10_PR12,I10_PR13,I10_PR14,I10_PR15,I10_PR16,I10_PR17,I10_PR18,I10_PR19,I10_PR20,I10_PR21,I10_PR22,I10_PR23,I10_PR24,I10_PR25) )
data <- subset(data, select = -c(PRDAY1,PRDAY2,PRDAY3,PRDAY4,PRDAY5,PRDAY6,PRDAY7,PRDAY8,PRDAY9,PRDAY10,PRDAY11,PRDAY12,PRDAY13,PRDAY14,PRDAY15,PRDAY16,PRDAY17,PRDAY18,PRDAY19,PRDAY20,PRDAY21,PRDAY22,PRDAY23,PRDAY24,PRDAY25))
data <- subset(data, select = -c(KEY_NIS,DISCWT,DQTR,DRG,DRGVER,DRG_NoPOA,DXVER,HOSP_DIVISION,KEY_NIS,MDC,NIS_STRATUM,PRVER,YEAR))
# Remove data that is accumulated after hospital visit has happened
# data <- subset(data, select = -c(DISCHARGE_DISPOSITION, NUMBER_DIAGNOSES, NUMBER_PROCEDURES, TOTCHG))
# train and test, even split
set.seed(1)
pos_ind <- which(data$DIED == 1)
neg_ind <- which(data$DIED == 0)
# Label train indeces and test indeces
pos_tr_ind <- sample(pos_ind, size = as.integer(0.08 * length(pos_ind)))
neg_tr_ind <- sample(neg_ind, size = as.integer(0.08 * length(neg_ind)))
train_ind <- append(pos_tr_ind, neg_tr_ind)
pos_test_ind <- sample(pos_ind, size = as.integer(0.02 * length(pos_ind)))
neg_test_ind <- sample(neg_ind, size = as.integer(0.02 * length(neg_ind)))
test_ind <- append(pos_test_ind, neg_test_ind)
# Classify data
train_data <- data[train_ind, ]
test_data <- data[test_ind, ]
# --------------------------------------
# train data
y <- as.factor(train_data$DIED)
X <- train_data[-which(names(train_data) == "DIED")]
# model
set.seed(1)
model <- randomForest(x = X, y = y, ntree = 1000, importance = TRUE)
model
# feature importance
importance(model)
importance <- importance(model)[,'MeanDecreaseAccuracy']
# ---------------------------------------
# predict
y_true <- as.factor(test_data$DIED)
X_test <- test_data[-which(names(test_data) == "DIED")]
y_pred <- predict(model, X_test)
# Plot a confusion matrix based on Model performance
ctable <- as.table(matrix(c(74476, 35, 1482, 74), nrow = 2, byrow = TRUE))
fourfoldplot(ctable, color = c("#CC6666", "#99CC99"),
             conf.level = 0, margin = 1, main = "Model Confusion Matrix")
# mse calculation
MSE <- mean((y_pred - y_true) ** 2)
# Rank importance into dataframe
impt_df <- data.frame(name=names(importance), value=importance, row.names=NULL)