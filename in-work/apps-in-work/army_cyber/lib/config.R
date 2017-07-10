################  ANALYTIC CONFIGURATION ####################
config <- {}
# Analytic name. This should automatically be replaced by the app name when creating a new app.
config$analyticName <- "~~analyticName~~"
config$title <- "Your Title Here"
config$analyticVersion <- "1.0.0"

# List all data fields that this analytic requires. These will be used to pull back relavant data sets and filter out the returned values.
# Example:
config$dataFields <- c("sulfate",
                       "nitrate",
                       "ID")

# List of optional data fields to include in this analytic. If they are not in the data set, a blank value for each field will be added to all of your data.
config$optionalDataFields <- c("phosphate")

# List specific data types if needed. For all data types not use {}.
# This will enforce that ONLY data from that source will be included.
config$dataTypes <- c()
# Example:
#config$dataTypes <- c('ARCYBER-CEF-MCAFEE-INTRUSHIELD')

# Optional tag to returned AFDs to only AFDs with the specified tag added to them.
# This is intended to be used in conjunction external analytics which generate data for this R application.
config$tags <- c()
#config$tags <- c(config$analyticName)


# boolean value used to limit what code should run in dev vs prod
# DO NOT EDIT, the build process will switch this value to TRUE
# at build time.
config$isRunningInProduction <- FALSE
