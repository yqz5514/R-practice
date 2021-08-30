library(dplyr)
library(ggplot2)

data(Titanic)
titanic = data.frame(Titanic)

ui <- fluidPage(
    titlePanel("Survival Freq on the Titanic"),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            p("Filter by age, gender, class"),
            radioButtons("AgeInput", "Age",
                         c("Adult", "Child")),
            radioButtons("SexInput", "Sex",
                         c("Male", "Female")),
            selectInput("ClassInput", "Class",
                        c('1' = '1st',
                          '2' = '2nd', 
                          '3' = '3rd',
                          'crew' = "Crew"))
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
                      
            p("Display with barplot"),
            plotOutput("barplot"),
            br(), br(),
            tableOutput("results")
        )
    )
)


# Define server logic required to draw a histogram
server <- function(input, output) {
    
    
    filtered <- reactive({
        titanic %>%
            filter(Age == input$AgeInput,
                   Sex == input$SexInput,
                   Class == input$ClassInput
            ) 
    })
    
    
    output$barplot <- renderPlot({    # $barplot
        t = filtered() %>% group_by(Survived) %>% summarise(sum(Freq))
        colnames(t) = c('Survived', 'n')
        
        ggplot(t, aes(Survived, n)) + geom_bar(stat = 'identity')
    })
    
    output$results <- renderTable({
        filtered()
    })
}
# Run the application 
shinyApp(ui = ui, server = server)
