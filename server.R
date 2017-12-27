#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$sum <- renderPrint({
    file <- read.csv(paste(input$company, "-", input$years, "-" , input$quartile , ".csv", sep = ""), header = T)
    summary(file)
  })
  
  output$data <- renderTable({
    file <- read.csv(paste(input$company, "-", input$years, "-" , input$quartile , ".csv", sep = ""), header = T)
    file
  })
   
  output$Plot <- renderPlot({
    
    file <- read.csv(paste(input$company, "-", input$years, "-" , input$quartile , ".csv", sep = ""), header = T)
    details <- read.table("BURSAMALSIADATE.csv", header=T, sep=",")
    attach(details)
    attach(file)
    DATE <- as.Date(DATE, "%m/%d/%Y")
    
    plot(DATE, LACP, main = "Start date to Payment Date", las=2, xlab = "DATE", ylab = "LACP")
#    axis(1, at=DATE, labels=DATE, las=2)
#    rect(par("usr")[1], par("usr")[3], par("usr")[2], par("usr")[4])
    lines(DATE, LACP, type="o", col = "red")
    grid(nx = length(DATE), ny = NULL, col = "lightgray", lty = "dotted", lwd = par("lwd"), equilogs = TRUE)
    
  })
  output$Plot2 <- renderPlot({
    
    DATE <- as.Date(DATE, "%m/%d/%Y")

    plot(DATE, LACP, main = "Start date to EX-Date", las=2, xlab = "DATE", ylab = "LACP", xlim = c(as.Date(STARTDATE[COMPANY==input$company], "%m/%d/%Y"), as.Date(EXDATE[COMPANY==input$company], "%m/%d/%Y")))
#    axis(1, at=DATE, labels=DATE, las=2)
    #    rect(par("usr")[1], par("usr")[3], par("usr")[2], par("usr")[4])
    lines(DATE, LACP, type="o", col = "red") 
    
  })
  
  output$goodbad <- renderText({
    file <- read.csv(paste(input$company, "-", input$years, "-" , input$quartile , ".csv", sep = ""), header = T)
    details <- read.table("BURSAMALSIADATE.csv", header=T, sep=",")
    attach(details)
    attach(file)
    
    datepay <- as.numeric(PAYMENTDATE[COMPANY==input$company])
    datestart <- as.numeric(STARTDATE[COMPANY==input$company])
    
    payday <- as.numeric(LACP[as.numeric(DATE)==datepay])
    startday <- as.numeric(LACP[as.numeric(DATE)==datestart])
    goodbad <- payday - startday
    
    if (goodbad > 0) {
      paste(payday, " , ",  startday, " ' ", goodbad, "Good News")
    } else if(goodbad < 0){
      paste(payday, " , ",  startday, " ' ", goodbad, "Bad News")
    } else {
      paste(payday, " , ",  startday, " ' ", goodbad, "Moderate")
    }
  })
  
  output$dis <- renderPlot({
    file <- read.csv(paste(input$company, "-", input$years, "-" , input$quartile , ".csv", sep = ""), header = T)
    attach(file)
    
    par(mfrow=c(1,1))
    hist(LACP)
    lines(density(LACP))
    
  })
  
})
