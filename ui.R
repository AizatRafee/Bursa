#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Bursa Malaysia"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput("company", "Company:",
                  list("HUP SENG INDUSTRIES BERHAD",
                       "GUAN CHONG BERHAD",
                       "AJINAMOTO(MALAYSIA) BERHAD",
                       "PPB GROUP BERHAD",
                       "HEINEKEN MALAYSIA BERHAD",
                       "CARLSBERG BREWERY MALAYSIA BERHAD",
                       "ASIA FILE CORPORATION BHD",
                       "MAGNI-TECH INDUSTRIES BERHAD",
                       "CCM DUOPHARMA BIOTECH BERHAD"
                       )
      ),
      selectInput("years","Years:",
                  list("2017",
                       "2018"
                       )
      ),
      selectInput("quartile","Quartile",
                  list("Quartile 1",
                       "Quartile 2"
                       )
      )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(type="tab",
                  tabPanel("Plot",
                                  fluidRow(
                                    splitLayout(cellWidths = c("50%", "50%"), plotOutput("Plot"), plotOutput("Plot2"))
                                    )),
                  tabPanel("Data", tableOutput("data")),
                  tabPanel("Summary", verbatimTextOutput("sum")),
                  tabPanel("Normality", plotOutput("dis"))
                  )
    )
  )
))
