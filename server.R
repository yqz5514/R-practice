#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
shinyServer(function(input, output) {
    
    
    df <- read.csv("ArgentinaCPI.csv", header = TRUE)
    # Generate plot
    output$dataPlot <- renderPlot({
        
        # Get min and max values based on input
        minval1 <- input$slider1[1]
        maxval1 <- input$slider1[2]
        
        minval2 <- input$slider2[1]
        maxval2 <- input$slider2[2]
        
        # Create a subset of data
        df_subset <- subset(df,
                            ( time >= minval1 ) &
                                ( time <= maxval1 ) &
                                ( value >= minval2 ) &
                                ( value <= maxval2 ) 
        )
        
        # Plot data, subset data, and regression line
        g <- ggplot(NULL) +
            geom_point(data=df, aes(x = time,y = value)) +
            geom_point(data=df_subset,
                       aes(x = time,y = value, color="red", size=5)) +
            xlab("time") + ylab("value")
        
        if (input$cfbandall) {
            g <- g + geom_smooth(data=df,aes(x = time, y = value),
                                 method='lm', color="blue")
        }
        else {
            g <- g + geom_smooth(data=df,aes(x = time, y = value),
                                 method='lm', se=FALSE, color="blue")
        }
        
        if (input$cfbandsub) {
            g <- g + geom_smooth(data=df_subset,aes(x = time, y = value),
                                 method='lm')
        }
        else {
            g <- g + geom_smooth(data=df_subset,aes(x = time,y = value),
                                 method='lm', se=FALSE)
        }
        print(g)
        
    }
    )
        })
    













