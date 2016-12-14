#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
prem <- read.csv('premiership93.csv', sep=';')

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("1992-1993 Premiership table, by week"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
      sidebarPanel(width=2,
        
       sliderInput("week",
                   "Week:",
                   min = 1,
                   max = 42,
                   value = 42),
       
       radioButtons(
         inputId="radio",
         label="Team selection help:",
         choices=list("Show all teams", "Select teams manually"),
         selected="Select teams manually"),       
       
       conditionalPanel(
         condition = "input.radio != 'Show all teams'",
         checkboxGroupInput("team_box", "Teams to show:",
                          unique(prem$Team), selected = c("Arsenal", "Blackburn", "Chelsea", "Liverpool", "Everton", "Man United"))
       )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotlyOutput("premPlot", width = "100%", height = "600px")

    )
  )
))
