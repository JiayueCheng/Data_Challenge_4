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
library(markdown)
library(tidyverse)

group_names <- c("Patients", "Volunteers")

## Define UI for application that draws a histogram'
shinyUI(
  navbarPage(
    
    ## Application title
    titlePanel("Study of patients with critically ill trauma"),
    
    ## Sidebar with a slider input
    sidebarLayout(
      sidebarPanel(
        checkboxGroupInput(inputId = "Group", label = "Study Group",
                           sort(group_names),
                           selected = c("Patients","Volunteers"))
      ),
      
      ## Show a plot of the generated distribution
      mainPanel(
        textOutput("description"),  ## add dataset description
        tabsetPanel(
          tabPanel(title = "Histograms of WG Time by Diagnosis",
                   plotlyOutput("plot1"),
                   textOutput("text1")),
          tabPanel(title = "Boxplot of GE Time by Diagnosis",
                   plotlyOutput("plot2"),
                   textOutput("text2")), 
          tabPanel(title = "Scatterplot of SB Time by Age in different study groups",
                   plotlyOutput("plot3"),
                   textOutput("text3"))
        )
        
      ) 
    )
  )
)