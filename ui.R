

ui <- fluidPage( theme = shinytheme("united"),
    titlePanel(tags$h2(tags$b("Games Sales 2000 - 2016"))),
    tabsetPanel(
        tabPanel(tags$h4("Overview of the market"),
                 tags$br(),
                 fluidRow(
                     column(2,
                            checkboxGroupInput("year",
                                               label = tags$h4("Year"), 
                                               choices = unique(games_sales_added_company$year_of_release),
                                               selected = c(2000:2016),inline = TRUE),
                            tags$br(),
                            actionButton("year_button", label = "Display Plots")   
                    ),
                    column(10,
                           plotOutput("plot_1")
                           
                     )
                ),
                 tags$br(),
                 
                 
                 fluidRow(
                     
                    column(6,
                           plotOutput("plot_3")
                           

                           ),
                    column(6,
                           plotOutput("plot_2")
                           )
                 ),
                 tags$br(),
                
        ),
        tabPanel(tags$h4("Most profitable games"),
                 tags$br(),
                 fluidRow(
                     column(2,
                            checkboxGroupInput("year_tab_2",
                                               label = tags$h4("Year"), 
                                               choices = unique(games_sales_added_company$year_of_release),
                                               selected = c(2000:2016),inline = TRUE
                            ),
                            tags$br(),
                            checkboxGroupInput("company",
                                               label = tags$h4("Company box"), 
                                        choices = unique(games_sales_added_company$company), 
                                        selected = unique(games_sales_added_company$company)),
                            actionButton("tab_2_button", label = "Display Plots")   
                     ),
                     column(10,
                            plotOutput("plot_1_tab_2")
                            
                     )
                 ),
                 
        ),
       
        tabPanel(tags$h4("Ratings critics vs users"),
                 tags$br(),
                 fluidRow(
                     column(2,
                            sliderInput("slider_ratings",
                                        label = tags$h4("Slider Range"),
                                        min = 2000, 
                                        max = 2016,
                                        value = c(2010, 2016)),
                            tags$br(),
                            checkboxGroupInput("company_ratings",
                                               label = tags$h4("Company
"), 
                                               choices = unique(games_sales_added_company$company), 
                                               selected = unique(games_sales_added_company$company)),
                            actionButton("ratings_button",
                                         label = "Display Plots")   
                            
                         
                     ),
                     column(10,
                            plotOutput("plot_1_ratings")
                            )
                 )
        ),
        tabPanel(tags$h4("Used dataset"),
                 tags$br(),
                 fluidPage(
                     DT::dataTableOutput("data")
                 )
        )
    )
    
) 



