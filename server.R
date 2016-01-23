library(shiny)

shinyServer(function(input, output) {
  
  data = read.csv("data/halfhour-pct-2.csv", header = TRUE)
  # Convert data activity column to factor so plot displays nicely 
  activityLevels <- c("010000",
                      "010101",
                      "020000",
                      "030000",
                      "040000",
                      "050000",
                      "060000",
                      "070000",
                      "080000",
                      "090000",
                      "100000",
                      "110000",
                      "120000",
                      "130000",
                      "140000",
                      "150000",
                      "160000",
                      "180000",
                      "500000",
                      "500105",
                      "500106",
                      "other")
  
  activityLabels <- c("Personal Care",
                      "Sleeping",
                      "Household Activities",
                      "Caring for Household Members",
                      "Caring for Non-Household Members",
                      "Work and Work-Related Activities",
                      "Education",
                      "Shopping",
                      "Professional and Personal Care Services",
                      "Household Services",
                      "Government Services and Civic Obligations",
                      "Eating and Drinking",
                      "Socializing, Relaxing, or Leisure",
                      "Sports, Exercise, or Recreation",
                      "Religious and Spiritual Activities",
                      "Volunteer Activities",
                      "Phone Calls",
                      "Traveling",
                      "Data Codes",
                      "Respondent refused to provide information",
                      "Gap or Can't remember",
                      "Other Activity")
  
  data$activity <- factor(data$activity,
                       levels = activityLevels,
                       labels = activityLabels)
  
  output$barChart <- renderPlot({
    # Bin range is prefixed with 'b' in data
    bin <- paste("b", input$timeOfDay, sep="")
    
    # Select data based on use input
    selectedData <- data[data$sex == input$sex & data$agegrp == input$ageGrp, c('activity',bin)]
    
    # Order data
    selectedData <- selectedData[order(selectedData[[bin]]),]

    par(las=2) # make label text perpendicular to axis
    par(mar=c(5,20,0,5)) # increase y-axis margin.
    
    barplot(selectedData[[bin]],
            names=selectedData$activity,
            horiz=TRUE,
            xaxt="n",
            xlim=c(0,1)
            )
    # Setup custom axis
    pct <- seq(0,1,by=0.1)
    axis(1, at=pretty(pct), lab=paste0(pretty(pct) * 100, " %"), las=0)
  })
})