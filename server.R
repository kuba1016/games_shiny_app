server <- function(input, output) {
  
 #Tab 1 Market Overview
  
  
  
    
  #Filtering
   filtered_data <- eventReactive(input$year_button,{
     games_sales_added_company %>% 
       filter(year_of_release %in% input$year)
   })
   # Plot one  creating event reactive
   
   output$plot_1 <- renderPlot({
     filtered_data() %>% 
     group_by(year_of_release) %>% 
       summarise(total_sales = sum(sales)) %>% 
       ggplot() +
       aes(year_of_release ,total_sales,label = total_sales) +
       geom_col(fill = "black")+
      geom_text(position = position_stack(vjust = 0.5),color = "white",size = 4) +
      
       labs(
         title = "Change in Sales by Year",
         x = "Years",
         y = "Total Sales")+ 
       geom_smooth(alpha = 0.1,color = "orange") +
       theme_classic() +
         theme(axis.title = element_text(size = 20)) +
         theme(plot.title = element_text(size = 20))
      
   })
   
   # PLOT 2  TAB 1
   output$plot_2 <- renderPlot({
     filtered_data() %>% 
       group_by(year_of_release) %>% 
       summarise(number_of_platforms = n_distinct(platform,na.rm = TRUE)) %>% 
       ggplot() +
       aes(year_of_release,number_of_platforms,label = number_of_platforms)+
       geom_col(fill = "black",size = 2)+
      geom_text(position = position_stack(vjust = 0.5),color = "white",size = 4)+
         
       labs(
         title = "Change in Number of Platforms",
         x = "Years",
         y = "Number of Platforms")+ 
       theme_classic()+
         theme(axis.title = element_text(size = 20)) +
         theme(plot.title = element_text(size = 20))
   })
   
   #PLOT 3 TAB 1
   
   output$plot_3 <-  renderPlot({
     filtered_data() %>% 
       group_by(year_of_release,genre) %>% 
       summarise(number_of_games = n_distinct(name)) %>% 
       ggplot() +
       aes(year_of_release,number_of_games,fill = genre) +
       geom_col() +
       theme_classic()+

         
      labs(
         title = "Games Realeses Per Year",
         
         x = "Years",
            y = "Number of Games/Genre")+ 
       scale_fill_brewer(palette = "Set3") +
         theme(axis.title = element_text(size = 20)) +
         theme(plot.title = element_text(size = 20))
   })
   
   #DATA SUMMARY FiRST TAB
   
   output$data_summary <- DT::renderDataTable({
     filtered_data() %>% 
       group_by(year_of_release) %>% 
       summarise(total_sales = sum(sales),
                 total_companys = n_distinct(company),
                 total_platforms = n_distinct(platform),
                 total_developer = n_distinct(developer),
                 total_new_games = n_distinct(name))
     
   })
   
   # TAB 2 Best games
   
   #FIltering
   filtered_data_tab2 <- eventReactive(input$tab_2_button,{
      games_sales_added_company %>% 
         filter(year_of_release %in% input$year_tab_2, company == input$company)
   })
   
   # plot 1 tab 2 
  
      output$plot_1_tab_2 <- renderPlot({
         filtered_data_tab2() %>% 
            arrange(desc(sales)) %>% 
            head(10) %>% 
            ggplot() +
            aes(name,sales,fill = genre, label = sales) +
            geom_col() +
            coord_flip() +
            theme_classic() +
            geom_text(position = position_stack(vjust = 0.5),color = "black",size = 5) +
            
            scale_fill_brewer(palette = "Set3") + 
            labs(
               title = "Best Selling Games",
               y = "Sales",
               x = "Game Title"
            ) +
            theme(axis.title = element_text(size = 20)) +
            theme(plot.title = element_text(size = 20))
         
            
         
      })
   #RATINGS TAB
   
   #Filtering
      filtered_ratings <- eventReactive(input$ratings_button,{
         games_sales_added_company %>%
            filter(between(year_of_release, input$slider_ratings[1], input$slider_ratings[2]))%>% 
                   filter(company %in% input$company_ratings)
      })
   #PLot 1 ratings tab
      
      output$plot_1_ratings <- renderPlot({
         filtered_ratings() %>% 
            ggplot() +
            aes(critic_score,user_score, color = company,size = sales ) +
            geom_point()+
            scale_color_brewer(palette = "Set2") +
            scale_size_continuous(range = c(3,17))+
            scale_x_continuous(limits = c(0,100))+
            scale_y_continuous(limits = c(0,10))+
            labs(
               x = "Critic Scores",
               y = "Users Scores",
               title = "Comparison of Critics and User Game Scores with Amount of Sales"
            )+
         theme_classic() +
            theme(axis.title = element_text(size = 20)) +
            theme(plot.title = element_text(size = 20))
      })
        
   #DATA SOURCE LAST TAB 
   output$data <- DT::renderDataTable({
     games_sales_added_company
   })
   
   
        
     
}

