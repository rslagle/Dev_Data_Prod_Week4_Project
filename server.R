library(shiny)
library(lubridate)

# Define server logic
shinyServer(function(input, output) {
#   if ((input$endtDateIn - input$startDateIn) < 90  ) {}
   output$tsPlot <- renderPlot({
      # Convert Time Series to Data Frame
      df <- as.data.frame(EuStockMarkets)
      # Extract Date and Time
      dateTime <- as.POSIXct(date_decimal(as.numeric(time(EuStockMarkets))))
      # Combine DateTime to Data Frame
      EuStocksDF <- cbind(dateTime, df)
      # Subset data for input dates
      sub1 <- subset(EuStocksDF, EuStocksDF$dateTime > input$startDateIn & EuStocksDF$dateTime < input$endDateIn)
      minValue <- min(sub1[2:5])
      maxValue <- max(sub1[2:5])
      # Plot Data
      plot(x=sub1$dateTime, y=sub1$DAX, type="l", col="red", xlab="", ylab="",
           ylim=c(minValue, maxValue))
      title(main="Stock Index Plot", 
            xlab=paste("Date Range -","From:", input$startDateIn, " To:", input$endDateIn),
            ylab="Stock Index Value")
      lines(x=sub1$dateTime, y=sub1$SMI, type="l", col="black")
      lines(x=sub1$dateTime, y=sub1$CAC, type="l", col="blue")
      lines(x=sub1$dateTime, y=sub1$FTSE, type="l", col="green")
      legend("topleft",legend=colnames(sub1[2:5]),lty=c(1,2,3,4),col=c("red","black","blue","green"),bg="white",lwd=2)
     # Print Correlations
     output$corr1 <- renderText({ paste("DAX - SMI  = ", round(cor(sub1$DAX, sub1$SMI),4)) })
     output$corr2 <- renderText({ paste("DAX - CAC  = ", round(cor(sub1$DAX, sub1$CAC),4)) })
     output$corr3 <- renderText({ paste("DAX - FTSE = ", round(cor(sub1$DAX, sub1$FTSE),4)) })
     output$corr4 <- renderText({ paste("SMI - CAC  = ", round(cor(sub1$SMI, sub1$CAC),4)) })
     output$corr5 <- renderText({ paste("SMI - FTSE = ", round(cor(sub1$SMI, sub1$FTSE),4)) })
     output$corr6 <- renderText({ paste("CAC - FTSE = ", round(cor(sub1$CAC, sub1$FTSE),4)) })
     
  })

})
