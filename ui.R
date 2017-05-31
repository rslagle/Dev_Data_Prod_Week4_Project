library(shiny)
# Define UI for application
shinyUI(
  fluidPage(
    # Application title
    titlePanel("European Stock Indexes"),
    # Sidebar with a input for dates
    sidebarLayout(  
      sidebarPanel(
        tags$u(strong(p("Enter Start and End Dates"))),
        dateInput("startDateIn", "Start Date (YYYY-MM-DD):", value=as.Date("1991-07-01")),
        tags$br(),
        dateInput("endDateIn", "End Date (YYYY-MM-DD):",     value=as.Date("1998-08-25")),
        tags$br(),
        submitButton("Submit", width="100%"),
        p("-------------------------------------------------"),
        tags$u(strong(p("Application Documentation"))),
        strong(p("How to use this Application")),
        p("1-Select a Start Date >= '1991-07-01'"),
        p("2-Select an End Date <= '1998-08-25'"),
        p("3-Press the Submit Button"),
        p("4-Observe changes to Graph and Correlations"),
        p("Note: Start Date should be at least 5 days before the End Date."),
        strong(p("Application Error")),
        p("If you get an error, check your date range values.")
      ),
      # Show Plots
      mainPanel(
        plotOutput("tsPlot"),
        h4("Correlations between Indexes for above Date Range"),
        verbatimTextOutput("corr1"),
        verbatimTextOutput("corr2"),
        verbatimTextOutput("corr3"),
        verbatimTextOutput("corr4"),
        verbatimTextOutput("corr5"),
        verbatimTextOutput("corr6")
      )
    )
  )
)
