library(ggplot2)
library(dplyr)
data <- read.csv("timings.csv")
data$nodes  <- as.numeric(data$nodes)
g1 <- ggplot(data, aes(x = nodes, y = time.max, colour = type, linetype = op)) +
    geom_line() + geom_point() +
    scale_x_log10() +
    scale_y_log10()
ggsave("loglog.pdf",  g1)
