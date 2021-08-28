#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application
shinyUI(pageWithSidebar(
    
    # Application title
    headerPanel("Interactive Regression"),
    
    # Sidebar with a ranged slider input for min and max limit of data set
    sidebarPanel(
        # Specification of range within an interval
        sliderInput("slider1", label = h3("Year Range (time)"), 
                    min = 1970,
                    max = 1989.75,
                    value = c(1970, 1989.75)),
        sliderInput("slider2", label = h3("Value Range(value)"), 
                    min = 1.01,
                    max = 6611700000,
                    value = c(1.01, 6611700000)),
        checkboxInput(inputId = "cfbandall",
                      label = strong("Show confidence band for all data"),
                      value = FALSE),
        
        checkboxInput(inputId = "cfbandsub",
                      label = strong("Show confidence band for subset"),
                      value = FALSE)
    ),
    
    # Show a plot of data and regression line
    mainPanel(
        plotOutput("dataPlot")
    )
))

