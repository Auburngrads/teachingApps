#This is the base template for creating functions to be used in shiny apps for BDP
#created by Isaac J. Faber
#29 October 2015
#In practice add all functions for data manipulation here and all visual specific code in the app.R file
#The following are base functions that are required
require('plyr')

# quick little function to clear the data on bad queries.
# must add all data objects here
clearData <- function (values) {
  values$data<-{}
  values$new.data<-{}
  values$loadedDataSets<-{}
}

updateValues <- function(values){
  
  #create your data object here for calculations
  new.data<-values$data
  
  #create your action table for report outputhere
  #this data frame should be a logical subset
  action<-values$data
  
  #uncomment the following five lines of code once actual cyer data is being used
  #action<-as.data.frame(table(new.data$IP_DST,new.data$EXTERNALID_CUSTOMER))
  #action<-action[action$Freq!=0,]
  #action<-action[with(action,order(-Freq)),]
  #rownames(action)<-NULL
  #colnames(action)<-c('dest_ip','region','count')
  action$action_req<-'Not Assigned'
  action$behavior_type<-'Not Assigned'
  
  #do your heavy computation lifting here
  #use a loop with progress bar to show users that you are doing work
  withProgress(message = 'Doing Data Science Magic!', value = 0, {
    
#    for(i in 1:length(new.data[,1])){
#      #example#
#      #print(length(new.data))
#      # Increment the progress bar, and update the detail text.
#      incProgress(1/length(new.data[,1]), detail = paste("IP #", i))
#
#    }
  })

  values$new.data<-new.data
  values$action<-action
}
