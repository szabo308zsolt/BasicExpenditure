### server.R
### server has a function input
library(shiny)
#load("expdata.RData")
shinyServer(function(input, output) {
  
    output$totalOutput <- renderText({
      if(file.exists("expdata.RData")) load("expdata.RData")
      else{
        expData <- data.frame(date = as.Date(character()), category=character(), description = character(), value = double(),stringsAsFactors=FALSE)
      }
      if(input$description==""){ paste("Add description, total expenditure ", sum(expData$value))  }
      else{
        newItem <- data.frame(date = as.Date(input$date), category = input$category, description = input$description, value = input$value,stringsAsFactors=FALSE);
        expData <- rbind(expData, newItem);
        save(expData,file = "expdata.RData");
        paste("Your total expenditure: ", sum(expData$value),".", sep="")
      }
    })
    output$piechart <- renderPlot({
      if(file.exists("expdata.RData")) load("expdata.RData")
      else{
        expData <- data.frame(date = as.Date(character()), category=character(), description = character(), value = double(),stringsAsFactors=FALSE)
      }
      procExpData <- data.frame( category=expData$category, value=expData$value, stringsAsFactors = TRUE)
      tab <- aggregate(procExpData$value, by=list(Category=procExpData$category), FUN=sum)
      pie(tab$x,col=c("red","green","blue","yellow")[1:length(tab$Category)],labels=tab$Category)
    })  
})

