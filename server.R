#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(plotly)
library(ggplot2)
source('all_sessions_udfs.R', local = T)

# Define server logic required to draw a power curve
function(input, output, session) {

    output$pwr_plot <- renderPlotly({
        #simulate calculation to get required number of responses to reach 80% 
        #statistical power for target difference to detect. 
        sim_result <- eventReactive(input$submit, {power_sim(p1 = input$p1, min_diff = input$min_diff, 
                             max_diff = input$max_diff, inc = input$inc,
                             n1 = input$n1, p_val = input$p_val, 
                             response_rate = input$response_rate, 
                             power = input$power, alternative = input$alternative
                             )})
        #Plotting the curve.
        p <- ggplot(sim_result(), aes(x = DIFF, y = N, 
                                      text = paste('Difference:', round(DIFF, 4), 
                                                   '<br>N:', round(N, 0), 
                                                   '<br># of Invites:', round(INVITEE, 0)),
                                      group = 1)) + 
          geom_line(color = "#FF0000", linewidth = 1.5) 
        #Convert to plotly. 
        ggplotly(p, tooltip = "text")
    })

}
