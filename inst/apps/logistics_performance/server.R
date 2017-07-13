server = function(input, output) {

        # Title for map on first tab
        output$mapTitle <- renderText({
                metric <- input$metric
                heading <- paste("Global LPI Benchmarking:", input$metric)
                HTML(paste('<center>',heading,'</center>'))
        })

        # Map on first tab
        output$trendPlot <- renderPlotly({

                # filter for metric
                metric <- input$metric
                year <- input$range

                columns <- c(1, 2, which(names(lpi) == metric))

                if(year != "Average"){
                        map_df <- lpi[lpi$Year == year, columns]
                        colnames(map_df) <- c("Country", "Code", "Metric")
                } else{
                        columns <- c(columns, which(names(lpi) == "Year"))
                        map_df <- lpi[, columns]
                        colnames(map_df) <- c("Country", "Code", "Metric", "Year")

                        map_df <- map_df %>%
                                group_by(Country, Code) %>%
                                summarise(Metric = mean(Metric, na.rm=TRUE))
                }

                l <- list(color = toRGB("grey"), width = 0.5)

                # specify map projection/options
                g <- list(
                        showframe = FALSE,
                        showcoastlines = FALSE,
                        projection = list(type = 'equirectangular', scale = 1.2)
                )

                plot_ly(map_df, z = map_df$Metric, text = map_df$Country, locations = map_df$Code, type = 'choropleth',
                        color = metric, colors = 'Blues', marker = list(line = l),
                        colorbar = list(title = 'LPI Score', len = .4, thickness = 20, xpad = 0, ypad = 0, x = 1.05)) %>%
                        layout(geo = g)


        })

        # Description on first tab
        output$mapDesc <- renderText({

                metric <- input$metric
                year <- input$range

                columns <- c(1, 2, which(names(lpi) == metric))

                if(year != "Average"){
                        map_df <- lpi[lpi$Year == year, columns]
                        colnames(map_df) <- c("Country", "Code", "Metric")
                        map_df <- arrange(map_df, desc(Metric))

                        country <- map_df[[1, 1]]
                        score <- round(map_df[[1, 3]], 2)
                        number <- length(unique(map_df$Country))

                        desc <- paste("In", input$range ,paste0("<font size='3' color='blue'>","<b>",country,"</b>","</font>"), "ranked", paste0("<font size='3' color='blue'>","1", "<sup>", "st", "</sup>", "</font>"), "out of", number, "countries in", paste0("<em>", input$metric, "</em>", "."), "See how other countries have ranked below.")
                        HTML(paste(desc))


                } else{
                        columns <- c(columns, which(names(lpi) == "Year"))
                        map_df <- lpi[, columns]
                        colnames(map_df) <- c("Country", "Code", "Metric", "Year")

                        map_df <- map_df %>%
                                group_by(Country, Code) %>%
                                summarise(Metric = mean(Metric, na.rm=TRUE)) %>%
                                arrange(desc(Metric))

                        country <- map_df[[1, 1]]
                        score <- round(map_df[[1, 3]], 2)
                        number <- length(unique(map_df$Country))

                        desc <- paste("Since 2010", paste0("<font size='3' color='blue'>","<b>",country,"</b>","</font>"), "has ranked", paste0("<font size='3' color='blue'>","1", "<sup>", "st", "</sup>", "</font>"), "out of", number, "countries in", paste0("<em>", input$metric, "</em>", "."), "See how other countries have ranked below.")
                        HTML(paste(desc))
                }


        })


        # Table on first tab
        output$mapTable <- DT::renderDataTable({

                # filter for metric
                metric <- input$metric
                year <- input$range

                if(input$alldata == TRUE){
                        map_table <- lpi %>%
                        select(-Code, -`Overall LPI Rank`) %>%
                                gather(Metric, Score, -Country, -Year)

                        caption <- "All Underlying Data"

                } else if(year == "Average"){
                        map_table <- lpi %>%
                                select(-Code) %>%
                                gather(Metric, Score, -Country, -Year) %>%
                                filter(Metric == metric) %>%
                                group_by(Country, Metric) %>%
                                summarise(Score = round(mean(Score, na.rm = TRUE), 2)) %>%
                                ungroup() %>%
                                arrange(desc(Score)) %>%
                                mutate(Rank = seq(1, length(Country), by = 1))
                        caption <- paste("Average Country Rankings for the", input$metric, "Metric for 2010-2016")
                } else {
                        map_table <- lpi %>%
                                select(-Code) %>%
                                gather(Metric, Score, -Country, -Year) %>%
                                filter(Metric == metric & Year == year) %>%
                                arrange(desc(Score)) %>%
                                mutate(Score = round(Score, 2),
                                       Rank = seq(1, length(Country), by = 1)) %>%
                                select(-Year)

                        caption <- paste("Country Rankings for the", input$metric, "Metric in", input$range)
                }

                DT::datatable(map_table, rownames = FALSE,
                              caption = shiny::tags$caption(
                                      style = 'text-align: center;', caption
                              ))
        })

        output$downloadData <- downloadHandler(

                filename = function() {
                        if(input$alldata == TRUE){
                                paste('all-lpi-data-', '.csv', sep = '')
                        } else if(input$range == "Average"){
                                paste(input$metric, '-historical-average', '.csv', sep = '')
                        } else {
                                paste(input$metric, '-', input$range, '.csv', sep = '')
                        }

                },

                content = function(file) {

                        # filter for metric
                        metric <- input$metric
                        year <- input$range

                        if(input$alldata == TRUE){
                                download_table <- lpi %>%
                                        select(-Code, -`Overall LPI Rank`) %>%
                                        gather(Metric, Score, -Country, -Year)

                        } else if(year == "Average"){
                                download_table <- lpi %>%
                                        select(-Code) %>%
                                        gather(Metric, Score, -Country, -Year) %>%
                                        filter(Metric == metric) %>%
                                        group_by(Country, Metric) %>%
                                        summarise(Score = round(mean(Score, na.rm = TRUE), 2)) %>%
                                        ungroup() %>%
                                        arrange(desc(Score)) %>%
                                        mutate(Rank = seq(1, length(Country), by = 1))

                        } else {
                                download_table <- lpi %>%
                                        select(-Code) %>%
                                        gather(Metric, Score, -Country, -Year) %>%
                                        filter(Metric == metric & Year == year) %>%
                                        arrange(desc(Score)) %>%
                                        mutate(Score = round(Score, 2),
                                               Rank = seq(1, length(Country), by = 1)) %>%
                                        select(-Year)


                        }

                        write.csv(download_table, file)
                }
        )

        # Title for radar plot on second tab
        output$radarTitle <- renderText({
                heading <- paste("Country Scorecard:", input$country)
                HTML(paste('<center>',heading,'</center>'))
        })

        # Radar plot on second tab
        output$radarPlot <- renderChartJSRadar({

                # filter country & year
                country <- input$country
                year <- input$selectedYears

                df <- lpi %>%
                        filter(Country == country & Year %in% year) %>%
                        select(-Code, -`Overall LPI Rank`, -Country) %>%
                        gather(Label, Value, -Year) %>%
                        spread(Year, Value) %>%
                        mutate(Label = factor(.$Label, levels = c("Overall LPI Score", "Customs", "Infrastructure",
                                                                   "International Shipments", "Logistics Quality & Competence",
                                                                   "Tracking & Tracing", "Timeliness"))) %>%
                        arrange(Label)

                chartJSRadar(df, maxScale = 5, showToolTipLabel = TRUE, title = "test")
        })



        # Table on second tab
        output$radarDesc <- renderText({
                # create ranking
                country <- input$country

                avg <- lpi %>%
                        group_by(Country) %>%
                        summarise(Overall = mean(`Overall LPI Score`, na.rm = TRUE)) %>%
                        arrange(desc(Overall)) %>%
                        mutate(Rank = seq(1, length(Country), by =1)) %>%
                        filter(Country == country)

                rank <- avg[[1, 3]]
                score <- round(avg[[1, 2]], 2)
                number <- length(unique(lpi$Country))

                sup <- if(substr(rank, nchar(rank), nchar(rank)) == 1){
                        "st"
                } else if(substr(rank, nchar(rank), nchar(rank)) == 2){
                        "nd"
                } else if(substr(rank, nchar(rank), nchar(rank)) == 3){
                        "rd"
                } else{
                        "th"
                }

                paste0("<b>",rank,"</b>","th")

                desc <- paste("Since 2010 the average Overall LPI Score for", input$country, "has been", paste0("<font size='3' color='blue'>","<b>",score,"</b>","</font>",","), "placing them" , paste0("<font size='3' color='blue'>","<b>",rank,"<sup>",sup,"</sup>","</b>","</font>"), "out of", number, "countries. See how they have historically ranked across all metrics below.")
                HTML(paste(desc))
        })

        output$radarTable <- DT::renderDataTable({

                country <- input$country

                rank_table <- lpi %>%
                        group_by(Year) %>%
                        mutate(`Overall LPI` = `Overall LPI Rank`) %>%
                        arrange(desc(Customs)) %>%
                        mutate(Customs = seq(1, length(Country))) %>%
                        arrange(desc(Infrastructure)) %>%
                        mutate(Infrastructure = seq(1, length(Country))) %>%
                        arrange(desc(`International Shipments`)) %>%
                        mutate(`International Shipments` = seq(1, length(Country))) %>%
                        arrange(desc(`Logistics Quality & Competence`)) %>%
                        mutate(`Logistics Quality & Competence` = seq(1, length(Country))) %>%
                        arrange(desc(`Tracking & Tracing`)) %>%
                        mutate(`Tracking & Tracing` = seq(1, length(Country))) %>%
                        arrange(desc(Timeliness)) %>%
                        mutate(Timeliness = seq(1, length(Country))) %>%
                        select(-Code, -`Overall LPI Score`, -`Overall LPI Rank`) %>%
                        gather(Metric, Score, -Country, -Year) %>%
                        spread(Year, Score) %>%
                        mutate(Metric = factor(.$Metric, levels = c("Overall LPI", "Customs", "Infrastructure",
                                                                    "International Shipments", "Logistics Quality & Competence",
                                                                    "Tracking & Tracing", "Timeliness"))) %>%
                        arrange(Metric)

                country_table <- rank_table %>%
                        filter(Country == country) %>%
                        select(-Country)

                caption <- paste("Metric Rankings by Year for", input$country)

                DT::datatable(country_table, rownames = FALSE,
                              caption = shiny::tags$caption(
                                      style = 'text-align: center;', caption
                              ),
                              options = list(dom = 't'))
        })

}
