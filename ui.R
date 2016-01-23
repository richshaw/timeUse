library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Most Common Use of Time, By Age and Sex"),
  
  # Description
  p( "You often hear averages on how people spend or should spend their time. For example, people sleep 7 to 8 hours per day. However, some people sleep alot more others alot less."),
  
  p("The app below allows you to compare how people spend their time by age and sex.The slider at the top allows you to change the time of day buy half-hour intervals. The selection boxes underneath allow you to change the sex and age.The chart shows the the percent of people within a particular cohort who are doing that activity at that time of day."),
  
  # Change slider labels to customized 30 min segements
  tags$head(includeScript('slider.js')),
  
  # Sidebar with a slider input for the number of bins
  verticalLayout(
    wellPanel(
      sliderInput("timeOfDay",
                  "Time of day:",
                  min = 0,
                  max = 47,
                  value = 24),
      selectInput("sex",
                  "Sex:",
                  c("Males" = "male",
                    "Females" = "female"),
                  selected = "male"),
      selectInput("ageGrp", "Age:",
                  c("15 to 24" = 0,
                    "25 to 34" = 1,
                    "35 to 44" = 2,
                    "45 to 54" = 3,
                    "55 to 64" = 4,
                    "65+" = 5),
                  selected = 2)
    ),
    
    # Show a plot of the generated distribution
    fluidRow(
      column(12,
        plotOutput("barChart",width = "100%")
      )
    )
  )
))