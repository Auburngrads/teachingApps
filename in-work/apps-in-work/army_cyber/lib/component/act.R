########################################################
#
########################################################
uiActTabItem <- function() {
  actTabItemResult <- tabItem(
    tabName = "ACT",
    fluidRow(
      tabBox(
        width=12,
        tabPanel(
          "Action",
          fluidRow(
            box(
              width=4,
              selectInput('ActionReq','Action Required',choices=c('Investigate','Block','Nothing','Not Assigned')),
              selectInput('Type','Behavior Type',choices=c('Action Type 1','Action Type 2','Not Assigned'))
            )
          ),
          fluidRow(
            box(
              width=4,
              actionButton("Update","Update Action",icon=icon("thumbs-up")),
              bsTooltip('Update','This will update the selected rows with the values defined above')
            )
          ),
          fluidRow(
            box(
              width=12,
              actionButton("selectAll","Select All",icon=icon("list")),
              bsTooltip('selectAll','This will select all rows currently filtered on the table below'),
              actionButton("clear","Clear Selected Rows"),
              DT::dataTableOutput('actionTable')
            )
          )
        ),
        tabPanel(
          'Report',
          fluidRow(
            box(
              width=8,
              selectInput("Org","Organization",choices=c('ACOIC','2RCC','RCC-E','RCC-K','RCC-P','RCC-SWA','CPB')),
              textInput('ReportNum','Report Number',value=paste('NAR-ARCYBER-',(1900+(as.POSIXlt(Sys.time()))$year),'-',sep='')),
              bsTooltip('ReportNum','Enter the current number at the end')
            )
          ),
          h3(strong('ACTIVITY')),
          fluidRow(
            box(
              width=8,
              tags$textarea(id="summary", rows=5, cols=80, "Enter your summary here!")
            )
          ),
          h3(strong('TECHNICAL DATA')),
          fluidRow(
            box(
              width=8,
              tags$textarea(id="tech", rows=5, cols=80, "None")
            )
          ),
          fluidRow(
            box(
              width=8,
              textInput('AFDid','Reference AFD Name',value='AFD Name')
            )
          ),
          h3(strong('THREAT')),
          fluidRow(
            box(
              width=8,
              selectInput(
                'ThreatCat',
                "Threat Category",
                choices=c(
                  '1 - Root Level Intrusion',
                  '2 - User Level Intrusion',
                  '3 - Unsuccessful Activity Attempt',
                  '4 - Denial of Service',
                  '5 - Non-compliance Activity/No Compromise',
                  '6 - Reconnaissance/Scan/Probe',
                  '7 - Malicious Logic',
                  '8 - Investigating',
                  '9 - Explained Anomaly/False Positive'
                ),
                selected='8 - Investigating'
              ),
              selectInput(
                'PIR',
                'PIR OR CCIR',
                choices=c(
                  '1. Adversary actions directed against critical infrastructure, data, and capabilities of U.S. Army networks or networks tied to the DoDIN.',
                  '2. Significant change(s) in an adversary\'s cyberspace capacity or strategy that will impact U.S. Army and DoDIN networks.',
                  '3. Adversarial information operations that are targeting U.S.Army through the cyberspace domain',
                  '4. Unauthorized network activities by authorized accounts directed against U.S. Army networks or networks tied to the DoDIN that will critically compromise or degrade our cyber security posture',
                  '5. Adversarial network changes made to their defensive posture that will affect our ability to conduct Offensive Cyber Operations',
                  'None'
                ),
                selected='None'
              ),
              tags$textarea(id="Threatsummary", rows=5, cols=80,"No additional threat information")
            )
          ),
          h3(strong('ADMIN')),
          fluidRow(
            box(
              width=8,
              textInput('POC','Point of Contact'),
              textInput('email','Contact E-mail',value='usarmy.belvoir.arcyber.list.g33-dco-attack-sensing-and-warning[AT SIGN]mail.mil'),
              textInput('phone','Contact Phone',value='703-706-2532')
            )
          ),
          h3(strong('REFERENCES')),
          fluidRow(
            box(
              width=8,
              tags$textarea(id="ref", rows=5, cols=80, "No more references")
            )
          ),
          fluidRow(
            box(
              width=4,
              downloadButton('downloadReport','Generate Report')
            )
          )
        )
      )
    )
  )
  return (actTabItemResult)
}


downloadActionReport <- function(input, currentValues, date1, date2) {
  downloadActionReportHandler <- downloadHandler(
    filename = function() {
      paste(input$ReportNum, sep = '.', 'txt')
    },

    content = function(file) {

      owd <- setwd(tempdir())
      on.exit(setwd(owd))
      sink(paste(input$ReportNum, 'txt',sep = '.'))
      hold<-currentValues$action[currentValues$action$action_req!='Not Assigned',]
      region<-paste(unique(hold$region),collapse=", ")
      cat("UNCLASSIFIED//FOR OFFICIAL USE ONLY\r\n\r\n")
      cat(paste0("NETWORK ACTIVITY REPORT\r\n"))
      cat(paste0("NAR: ARCYBER-",input$Org,"\r\n"))
      cat(paste0("SERIAL NUMBER: ",input$ReportNum,"\r\n\r\n"))
      cat("-----------------------------------------------------------------------------\r\n")
      cat("(U//FOUO) THIS ACTIVITY IS PRELIMINARY REPORTING CONSISTING OF UNEVALUATED\r\n")
      cat("INITIAL ATTACK SENSING AND WARNING (AS&W) OR INDICATIONS AND WARNING (I&W)\r\n")
      cat("OF POSSIBLE MALICIOUS CYBER ACTIVITY.  IAW CJCSM 6510.01B THE NETWORK ACTIVITY\r\n")
      cat("REPORT (NAR) MAY CONTAIN U.S. PERSON INFORMATION TIED TO COMPUTER NETWORK\r\n")
      cat("DEFENSE OPERATIONS AFFECTING THE DEPARTMENT OF DEFENSE INFORMATION NETWORK.\r\n")
      cat("\r\n")
      cat("(U//FOUO) ACCESSING, BLOCKING, OR ELECTRONICALLY SURVEYING THE IP ADDRESSES,\r\n")
      cat("INTERNET WEB SITE, E-MAIL ADDRESSES, OR USER NAMES IDENTIFIED IN THIS REPORT\r\n")
      cat("IS STRICTLY FORBIDDEN WITHOUT PRIOR COORDINATION AND APPROVAL.  UNAUTHORIZED\r\n")
      cat("DISCLOSURE OF THE SOURCES AND METHODS CONTAINED IN THIS REPORT COULD ENDANGER\r\n")
      cat("FUTURE CYBERSPACE MISSIONS AND INFORMATION SHARING.\r\n")
      cat("-----------------------------------------------------------------------------\r\n\r\n")
      cat("----------------ACTIVITY----------------\r\n\r\n")
      cat("MISSION: Defensive Cyber Operations\r\n")
      cat("SUBJECT: Possible Vulnerability Recon and Scan\r\n")
      cat("ORIGINAL REPORT: None\r\n")
      cat(paste0("Date of Publication: ",Sys.time()," ","GMT\r\n\r\n"))
      cat("Date Range of Event: ",as.character(date1())," to ",as.character(date2()),"\r\n\r\n")

      cat(paste0("Affected Regions: ",region,"\r\n\r\n"))
      cat(paste0("Activity Summary: \r\n",input$summary,"\r\n\r\n"))
      print(hold, row.names=FALSE)
      cat("\r\n\r\nAdditional Technical Data: ",input$tech,"\r\n\r\n")
      cat("----------------THREAT CATEGORY----------------\r\n\r\n")
      cat(paste0("INCIDENT CATEGORY:",input$ThreatCat,"\r\n"))
      cat(paste0("APPLICABLE PIR OR CCIR: ",input$PIR),"\r\n")
      cat(paste0("Threat Summary: \r\n",input$Threatsummary,"\r\n\r\n"))
      cat("----------------CONTACT AND ADMIN--------------\r\n\r\n")
      cat(paste0("References: Generated by Your APP!\r\nSee Gabriel Nimbus WatchTower AFD-",input$AFDid),"\r\n",input$ref)
      cat(paste0("\r\n\r\nContact Information: \r\nARCYBER-",input$Org,"\r\nPOC: ",input$POC,"\r\nEmail Distro: ",input$email,"\r\nPhone Number: ",input$phone,"\r\n\r\n"))
      cat("UNCLASSIFIED//FOR OFFICIAL USE ONLY")
      sink()
      out<-paste(input$ReportNum, 'txt',sep = '.')
      file.rename(out, file)

    }
  )
  return (downloadActionReportHandler)
}
