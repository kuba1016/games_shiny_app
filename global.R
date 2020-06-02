library(shiny)
library(tidyverse)
library(ggplot2)
library(CodeClanData)
library(shinythemes)

# Adding Shiny theme
theme = shinytheme("united")

#Adding company column to the data table

games_sales_added_company <- game_sales %>% 
  mutate(company  = case_when(
    platform %in% c("PS4",  "PS3","PS2","PS","PSP","PSV") ~ "PlayStation",
    platform %in% c( "X360","XOne","XB") ~ "Microsoft",
    platform %in% c( "DS","3DS", "GBA","Wii",  "WiiU" ) ~ "Nintendo",
    TRUE ~ "Other"
    
  )) %>% 
  filter(year_of_release >=2000) 