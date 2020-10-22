library(shiny)
library(shinythemes)

shinyUI(fluidPage(theme = shinytheme("cerulean"),           
  headerPanel("My app"),
  sidebarPanel(
    HTML('<b>Instructions:</b><br/>'),
    HTML("<br/>"),
    HTML("Slide the bar to match your current age. Select male/female if you wish."),
    sliderInput('age', 'Age', 25, min = 0, max = 99, step = 1)
  ),
  mainPanel(uiOutput('myoutput'))
))