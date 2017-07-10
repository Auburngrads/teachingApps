#This is the base template for creating shiny apps for BDP
#created by Isaac J. Faber and Andrew Skene
#29 October 2015

#build list of required packages for app
#minimum both shiny, shinydashboard and lubridate are required
library('shiny')
library('shinydashboard')
library('lubridate')
library('DT')#must use git hub version!!!! must be version 0.1.45 or >
library('shinyBS')
library('htmlwidgets')
library('plotly')
library('rmarkdown')
library('lubridate')
library('plyr')
#library('c3Services')

# Source the configuration for this app.
source("lib/config.R")

#source the app specific functions script that will be in the same directory
source("lib/app/app_functions.R")

# source the various component files containing the ui definitions and
# supporting functions
source("lib/component/act.R")
source("lib/component/afd.R")
source("lib/component/data.R")
source("lib/component/menu.R")
source("lib/component/nst.R")
source("lib/component/tool.R")
