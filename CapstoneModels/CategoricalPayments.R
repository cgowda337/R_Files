
library(plotly)
library(ggplot2)
adf <- Sample_TEAMHealth_Data
adf1 <- subset(adf,`Transaction Category` == "Credits")
adf2 <- subset(adf,`Transaction Category` == "Charges")
adf3 <- subset(adf,`Transaction Category` == "Form")
adf4 <- subset(adf,`Transaction Category` == "Payments")
adf5 <- subset(adf,`Transaction Category` == "Refunds")
adf6 <- subset(adf,`Transaction Category` == "Transfers")
adf7 <- subset(adf,`Transaction Category` == "Write Off")

fig <- plot_ly(type = 'box')
fig <- fig %>% add_boxplot(y = adf1$`Payment Amount`, jitter = 0.3, pointpos = -1.8, boxpoints = 'Credits',
                           marker = list(color = 'rgb(7,40,89)'),
                           line = list(color = 'rgb(7,40,89)'),
                           name = "Credits")
fig <- fig %>% add_boxplot(y = adf2$`Payment Amount`, name = "Charges", boxpoints = FALSE,
                           marker = list(color = 'rgb(9,56,125)'),
                           line = list(color = 'rgb(9,56,125)'))
fig <- fig %>% add_boxplot(y = adf3$`Payment Amount`, name = "Form", boxpoints = 'suspectedoutliers',
                           marker = list(color = 'rgb(8,81,156)',
                                         outliercolor = 'rgba(219, 64, 82, 0.6)',
                                         line = list(outliercolor = 'rgba(219, 64, 82, 1.0)',
                                                     outlierwidth = 2)),
                           line = list(color = 'rgb(8,81,156)'))
fig <- fig %>% add_boxplot(y = adf4$`Payment Amount`, name = "Payments", boxpoints = 'outliers',
                           marker = list(color = 'rgb(107,174,214)'),
                           line = list(color = 'rgb(107,174,214)'))
fig <- fig %>% layout(title = "Box Plot Styling Outliers")

fig