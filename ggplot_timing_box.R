## first
library(ggplot2)
library(tidyverse)
library(showtext)

font_add("modern", "/usr/share/fonts/OTF/lmroman10-regular.otf")

showtext_auto()

theme_set(
  theme_light() + theme(legend.position = "bottom")
)

data <- read.csv("timings.csv")
data$nodes <- as.numeric(data$nodes)

## g1 <- ggplot(data, aes(x = nodes, y = time.max, colour = type, linetype = op)) +
##     geom_line() +
##     geom_point() +
##     scale_x_log10(breaks = c(128, 256, 512, 1024)) +
##     scale_y_log10() +
##     labs(linetype = "operation") +
##     labs(colour = "config") +
##     labs(y = "time [s]") +
##     labs(x = "#nodes") + theme(text = element_text(size=10, family="modern"))


## ggsave("loglog.pdf", g1, width=6, height=6)

## sub
library(ggplot2)
library(dplyr)

data <- read.csv("timings.csv")
data$nodes <- as.numeric(data$nodes)
data$type <- factor(data$type, levels = c("cosma-gpu", "cosma-mkl", "libsci_acc", "cray-libsci", "mkl"))
g1 <- ggplot(data, aes(x = nodes, y = time.max, colour = type)) +
  geom_line() +
  geom_point() +
  scale_x_log10(breaks = c(128, 256, 512, 1024), minor_breaks = c()) +
  scale_y_log10(
    breaks = c(100, 300, 1000, 3000),
    minor_breaks = c(70, 80, 90, 100, 200, 300, 400, 500, 600, 700, 800, 900, 2000, 3000, 4000, 5000, 6000, 7000)
  ) +
  annotation_logticks(size = 0.2, sides = "l", alpha = 0.5) +
  labs(linetype = "operation") +
  labs(colour = "config") +
  labs(y = "time [s]") +
  labs(x = "#nodes") +
  scale_colour_discrete(labels = c("COSMA GPU+COSTA", "COSMA CPU+COSTA", "Cray LibSci GPU", "Cray LibSci CPU", "Intel MKL")) +
  facet_wrap(~op, labeller = labeller(op = c(cp_gemm = "matrix-matrix multiplication", CP2K = "total time"))) +
  theme(
    text = element_text(size = 12, family = "modern"),
    legend.title = element_blank(),
    legend.position = c(0.32, 0.83),
    ## legend.background=element_rect(fill=alpha("white",  0)),
    legend.key=element_rect(fill=alpha("white",  0)),
    legend.text = element_text(size = 7.5),
    legend.key.size = unit(12, "pt"),
    legend.spacing.y = unit(0, "pt"),
    axis.title.y = element_text(margin = margin(r = 6, unit = "pt")),
    axis.title.x = element_text(margin = margin(t = 6, unit = "pt")),
    panel.grid.minor = element_line(linetype = "dashed"),
    legend.margin = margin(r = 3, unit = "pt"),
    legend.background = element_rect(fill = alpha("white", 0.6)),
    legend.box.background = element_rect(colour = "black"),
    strip.background = element_rect(fill = "#474747"),
    strip.text = element_text(colour = "white")
  )

## axis.label.y = element_text(vjust = 2))
## legend.key=element_rect(colour=NA, fill=NA))
## +
## theme(
##     panel.background = element_rect(fill = "white", colour = "black"),
##     panel.grid.major = element_line(
##         size = 0.3, linetype = "dashed",
##         colour = "gray"
##     ), panel.grid.minor = element_line(
##         size = 0.1, linetype = "dashed",
##         colour = "gray"
##     ),
##   strip.background = element_rect(fill = "white"), # title background,
##   legend.key = element_rect(fill = "white")
## )

ggsave("cp2k-timings_box.pdf", g1, width = 5, height = 3.5, units = "in")
## ggsave("loglog-facets.pdf", g1, width=8/1.5, height=6/1.5,  units="in")
