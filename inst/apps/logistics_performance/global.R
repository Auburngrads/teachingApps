pacman::p_load(readr,plotly,dplyr,tidyr,DT,radarchart,magrittr)
lpi <- read_csv("www/lpi.csv")
colnames(lpi)[1] <- 'Country'