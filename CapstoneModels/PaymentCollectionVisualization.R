library(ggplot2)
library(plotly)
library(rgl)
library(plot3D)
#agency
x = sample(1:5,100, replace= TRUE)
#type of collection
y = sample(1:7, 100, replace = TRUE)
#amount of $$
z = sample(200:500,100,replace = TRUE)

df2 <- data.frame(x,y,z)


p <- ggplot(df2, aes(x=x, y=z)) +
  geom_tile(aes(fill = x)) +
  scale_fill_distiller(palette = "YlGnBu") +
  labs(title = "Agency vs Collection amount",
       y = "Collection amount")

ggplotly(p)