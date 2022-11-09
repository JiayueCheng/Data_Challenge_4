#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(medicaldata)
library(shiny)
library(plotly)
library(tidyverse)
library(rsconnect)

## Plot 1
## Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  ## describe the data
  output$description <- renderText({
    
    "These data were compared 8 patients who have critically ill trauma with 87 healthy volunteers from 
    a seperate trial. We are investigating the conditions of Gastric Emptying Time, Small Bowel Transit Time, 
    Whole Gut Time in different study groups."
  })
  
  ## put text for plot 1
  output$text1 <- renderText({
    "This panel is discussing the relationship of WG Time with critically ill trauma. We can check the patients 
    box if we want to study WG Time in patients group; Similarly, we can check the Volunteers box if we want to 
    see the WG Time in normal population. If we check both Patients and Volunteers boxes on the left, we will 
    know the differences of WG Time in different study groups and know whether the disease has an effect on WG 
    Time."
  })
  
  output$plot1 <- renderPlotly({
    
    ## Set new values for group variable, '0' as 'Patients', '1' as 'Volunteers'
    smartpill$Group[which(smartpill$Group == "0")] = "Patients" 
    smartpill$Group[which(smartpill$Group == "1")] = "Volunteers"
    
    ## generate plot based on input$Group from ui.R
    ds1 <- smartpill %>%
      mutate(Group=as.character(Group)) %>%
      filter(Group %in% input$Group)
    
    ## make a histogram by using ggplot
    ggplot1 <- ggplot(data = ds1,
                      aes(x = WG.Time,
                          fill = Group)) +
      geom_histogram(binwidth=50, alpha=0.7, position="identity") +
      xlim(0,900) +  ## set x-axis limits
      ylim(0,50) +   ## set y-axis limits
      labs(title = "Histograms of WG Time by Diagnosis") +  ## add a title on plot 1
      xlab("WG Time") +  ## rename x-axis
      ylab("Count") +    ## rename y-axis
      scale_fill_manual(name="Diagnosed as Trauma",  ## give a legend for plot 1
                        values=c("pink","lightblue"))
    ggplotly(ggplot1)  ## Make an interactive plot using plotly
  })
  
  ## Plot 2
  ## put text for plot 2
  output$text2 <- renderText({
    "This panel is discussing the relationship of GE Time with different study groups. We can check the patients 
    box to study GE Time in patients group; Similarly, we can check the volunteers box to study the GE Time in 
    normal population.If we check both boxes on the left side, we will compare the differences of GE Time in 
    different study groups, including the range of GE Time in different study groups, the distribution of GE 
    Time in different study groups, etc."
  })
  output$plot2 <- renderPlotly({
    
    ## Set new values for group variable, '0' as 'Patients', '1' as 'Volunteers'
    smartpill$Group[which(smartpill$Group == "0")] = "Patients" 
    smartpill$Group[which(smartpill$Group == "1")] = "Volunteers"
    
    ## generate plot based on input$Group from ui.R
    ds2 <- smartpill %>%
      mutate(Group=as.character(Group)) %>%
      filter(Group %in% input$Group)
    
    ## make a boxplot by using ggplot
    ggplot2 <- ggplot(data = ds2,
                      aes(x = Group,
                          y = GE.Time,
                          fill = Group)) +
      geom_boxplot(alpha=0.5) +
      labs(x="Diagnosis",  ## rename x-axis
           y="GE Time",    ## rename y-axis
           title="Boxplot of GE Time by Diagnosis") +   ## add a title on plot 2
      scale_fill_manual(name="Diagnosed as Trauma",    ## give a legend for plot 1
                        values=c("orange","green"))
    ggplotly(ggplot2)   ## Make an interactive plot using plotly
  })
  
  ## Plot 3
  ## put text for plot 1
  output$text3 <- renderText({
    "This panel is discussing the SB Time in different study groups and the relationship of SB Time and age. 
    We can check the patients box to study SB Time in patients group; Similarly, we can check the volunteers 
    box to study the SB Time in normal population.If we check both boxes on the left side, we will compare the 
    differences of SB Time in different study groups, including the range of GE Time in different study groups, 
    the distribution of GE Time in different study groups, etc. We can also know that there is little relationship
    between the SB time and age."
  })
  
  output$plot3 <- renderPlotly({
    
    ## Set new values for group variable, '0' as 'Patients', '1' as 'Volunteers'
    smartpill$Group[which(smartpill$Group == "0")] = "Patients" 
    smartpill$Group[which(smartpill$Group == "1")] = "Volunteers"
    
    ## generate plot based on input$Group from ui.R
    ds3 <- smartpill %>%
      mutate(Group=as.character(Group)) %>%
      filter(Group %in% input$Group)
    
    ## make a scatterplot by using ggplot
    ggplot3 <- ggplot(data = ds3,
                      aes(x = Age,
                          y = SB.Time,
                          color = Group)) +
      geom_point(size = 1.5, alpha=0.7) +
      labs(x = "Age",     ## rename x-axis
           y ="SB Time",  ## rename y-axis
           title="Scatterplot of SB Time by Age in different study groups")   ## add a title on plot 3
    ggplotly(ggplot3)    ## Make an interactive plot using plotly
  })
})
