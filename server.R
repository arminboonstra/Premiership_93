#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
prem <- read.csv('premiership93.csv', sep=';')


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  PlotTeams <- reactive({
    
    if(input$radio == "Show all teams"){
      prem
    } else {
      prem[prem$Team %in% input$team_box,]
    }
    
  })  
  
   
  output$premPlot <- renderPlotly({
    
    # generate bins based on input$bins from ui.R
    g <- ggplot(PlotTeams(), aes(x=Week, y=Points, colour = Team)) + geom_line()
    g <- g+scale_x_continuous(limits = c(0, input$week))+scale_y_continuous(limits = c(0, 2.5*input$week)) 
    g <- g + labs(y='Points')
    #g <- g + theme(legend.position="bottom", plot.title=element_text(size = 10, face = "bold") , legend.title=element_text(size=10) , legend.text=element_text(size=10))
    g
    
  })
   output$text1 <-  renderText({ input$team_box  })
   
   
#  output$text2 <- length(unique(prem$Team))
  
})

