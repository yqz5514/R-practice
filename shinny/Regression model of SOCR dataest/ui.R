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
    headerPanel("Interactive Regression between age and weight of SOCR"),
    
    # Sidebar with a ranged slider input for min and max limit of data set
    sidebarPanel(
        # Specification of range within an interval
        sliderInput("slider1", label = h3("Height(Inches)"), 
                    min =62.01666,
                    max = 73.90107,
                    value = c(62.01666, 73.90107)),
        sliderInput("slider2", label = h3("Weight(Pounds)"), 
                    min = 84.3598,
                    max = 168.229,
                    value = c(84.3598, 168.229)),
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

