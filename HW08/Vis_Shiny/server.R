
library(shiny)
library(ggmap) #For interaction and extraction with Google API maps
library(dplyr)
library(leaflet)
library(htmlwidgets)
library(ggplot2)
library (readr)
library(RColorBrewer) #has a set of colors for print and graphics
library(DT)
library(stringr)
library(shinycssloaders) #to add spinner to plot during processing of updates

server <- function(input, output, session) {
  #uses the continuous coloring from Color Brewer for leaflet map
  greens = colorNumeric("Greens", domain = NULL)

  #imports the data file and creates an identifier for each geocode
  Internet_Use <- read_csv("All_Data.csv") %>%
                          mutate(id=str_replace(paste0(longitude, latitude), "-", "")) %>%
                          mutate(Years=(round(Year,0))) 
                          
                          
  #generates the average internet use for all countries                
  world_Avg <- Internet_Use %>%
    group_by(Years) %>%
    summarize(Internet_Users_per_100=mean(Internet_Users_per_100)) %>%
    mutate(Country="World") %>%
    dplyr::select(Country, Years, Internet_Users_per_100)
  
  #creates the data to be used for the leaflet map only
  Internet_map <- Internet_Use %>%
                  filter(Year == 2015) %>%
                  mutate(Internet_User_per_100 = as.character(round(Internet_Users_per_100, 2)))  %>%
                  mutate(Size_user = (round(Internet_Users_per_100, 2))/10)
  
  
  
  #Instructions to user
  output$mytext <- renderText({
    paste("Click on a Circle Marker on the map below to see more details")
  })

    #set a variable to capture the id associated with each marker from leaflet's layerid function
    p <- reactiveValues(clickedMarker=NULL)

    # produce the basic leaflet map with single marker
    output$mymap <- renderLeaflet(
      leaflet() %>%
        addProviderTiles(providers$Stamen.TonerLite, options = providerTileOptions(noWrap = TRUE)) %>%
        setView(-3.435973, 55.378051, zoom = 2) %>%
        addCircleMarkers(lat=Internet_map$latitude, lng=Internet_map$longitude, radius= Internet_map$Size_user, color = greens(Internet_map$Size_user), popup=paste("Internet Users per 100 = ", Internet_map$Internet_User_per_100), layerId=Internet_map$id) %>%
        addLegend("bottomright", pal = greens, values = Internet_map$Size_user,
                title = "Users per 100",
                labFormat = labelFormat(suffix = "0"),
                opacity = 0.6)
    )
      
    #observe the marker click info and transfer it to the tables and scatterplot when it is changed.
    observeEvent(input$mymap_marker_click,{
     p$clickedMarker <- input$mymap_marker_click
     print(p$clickedMarker$id)
     
     output$myTable <- DT::renderDataTable({
       return(
         filter(Internet_Use,id == p$clickedMarker$id) %>%
         mutate(Internet_Users_per_100=round(Internet_Users_per_100,2)) %>%
         mutate(Population=prettyNum(Tot_pop, big.mark=",")) %>%
         mutate(Percent_in_urban=round(Percent_urban,2)) %>%
         mutate(National_Income_Per_Cap=prettyNum(GNI_per_cap, big.mark=",")) %>%
         mutate(Percent_with_Electricity=round(Per_Access_Electricity,2)) %>%
         mutate(Median_Life_Exp=round(Median_Life_Exp,2)) %>%
         dplyr::select(Country, Years, Internet_Users_per_100, Population, Percent_in_urban, National_Income_Per_Cap, Percent_with_Electricity, Median_Life_Exp)
        )
       
 })   

     # Downloadable csv of resulting dataset
     output$downloadData <- downloadHandler(
       filename = function() {
         paste("mySave", ".csv", sep = "")
       },
       content = function(file) {
         filter(Internet_Use,id == p$clickedMarker$id) %>%
           mutate(Internet_Users_per_100=round(Internet_Users_per_100,2)) %>%
           mutate(Population=prettyNum(Tot_pop, big.mark=",")) %>%
           mutate(Percent_in_urban=round(Percent_urban,2)) %>%
           mutate(National_Income_Per_Cap=prettyNum(GNI_per_cap, big.mark=",")) %>%
           mutate(Percent_with_Electricity=round(Per_Access_Electricity,2)) %>%
           mutate(Median_Life_Exp=round(Median_Life_Exp,2)) %>%
           dplyr::select(Country, Years, Internet_Users_per_100, Population, Percent_in_urban, National_Income_Per_Cap, Percent_with_Electricity, Median_Life_Exp) %>%
           write.csv(file, row.names = FALSE)
       }
     ) 
     
     output$Internet_Trend <- renderPlot({ 
       Internet_Use %>% 
         filter(id == p$clickedMarker$id) %>% 
         dplyr::select(Country, Years, Internet_Users_per_100) %>%
         rbind(world_Avg) %>%
         ggplot(aes(x=Years, y=Internet_Users_per_100, color=Country)) +
         geom_line() +
         geom_point() +
         labs(y = "Number of Internet Users per 100 inhabitants") +
         ggtitle("Internet Usage Trend against the World Average") 
        })

   })

  
}


