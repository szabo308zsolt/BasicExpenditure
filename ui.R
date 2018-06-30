library(shiny)
shinyUI(fluidPage(
  titlePanel("Basic Expenditure"),
  sidebarLayout(
    sidebarPanel(
      h3("Submit Item"),
      dateInput("date", "Date", value=Sys.Date()),
      selectInput("category", "Category", choices=c("Eating out"="eatout", "Groceries"="groceries", "Entertainment"="entert", "Medical"="medic")),
      textInput("description", "Add description", placeholder="e.g. groceries for bbq party"),
      #textInput("description", "Add description", value="Date with gf"),
      numericInput("value", "Cost",0, min=0,step=0.01),
      submitButton( text = "Submit")
      ),
    mainPanel(
      h3("Total Expenditure"),
      textOutput("totalOutput"),
      plotOutput("piechart")
      )
    )
))
