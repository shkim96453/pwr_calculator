#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(plotly)

# Define UI for application that draws a power analysis curve
fluidPage(

    # Application title
    titlePanel("Sample Size Calculator"),

    # Sidebar with required inputs for power analysis
    sidebarLayout(
        sidebarPanel(
            #p1: result from previous survey
            numericInput("p1",
                        "P1",
                        value = 0.5,
                        step = 0.01),
            #min_diff: minimum difference that survey attempts to detect from 
            #previous survey
            numericInput("min_diff", 
                         "Minimum Difference",
                         value = 0.1, 
                         step = 0.01),
            #max_diff: maximum difference that survey would accept to detect.
            numericInput("max_diff", 
                         "Maximum Difference",
                         value = 0.3, 
                         step = 0.01),
            #p_val: testing threshold to reject or accept null hypothesis 
            numericInput("p_val", 
                         "P-value",
                         value = 0.05, 
                         step = 0.01),
            #N1: number of responses from previous survey
            numericInput("n1", 
                         "N1",
                         value = 100,
                         step = 1),
            #response_rate: historical response rate of the survey.
            numericInput("response_rate", 
                         "Historical Response Rate",
                         value = 0.3,
                         step = 0.01),
            #power: statistical power that survey attempts to achieve. 0.8 is
            #common default.
            numericInput("power", 
                         "Statistical Power",
                         value = 0.8, 
                         step = 0.01),
            #inc: increment of simulation. Default is to simulate required 
            #responses for every 0.05% of increase in target difference. 
            numericInput("inc", 
                         "Simulation Increment",
                         value = 0.0005, 
                         step = 0.0001),
            #alt: testing decision logic.  
            selectInput("alt", 
                        "A/B Testing Decision Logic",
                        list("Two Sided" = "two_sided", "Less" = "less", 
                             "Greater" = "greater"),
                        ),
            #submit button. 
            actionButton("submit", "Submit")
        ),
        

        # Show a plot of the generated power curve with tooltip
        mainPanel(
            plotlyOutput(outputId = "pwr_plot")
        )
    )
)
