library(shiny)

shinyServer(
  function(input, output) {
    output$myoutput <- renderUI({
      tagList(
        h3('Your results'),
        tabsetPanel(
          tabPanel("Your age in one year", HTML(input$age + 1)), 
          tabPanel("Your age in ten years", HTML(input$age + 10))
        )
      )
    })
  }
)