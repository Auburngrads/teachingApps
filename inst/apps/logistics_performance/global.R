lpi <- read_csv("www/lpi.csv")
colnames(lpi)[1] <- 'Country'


library(readr)
library(plotly)
library(dplyr)
library(tidyr)
library(DT)
library(radarchart)
library(magrittr)
