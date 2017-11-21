# Introduction
The overall purpose of this assignment was to create an interactive application that allows users to explore data that is related to Internet usage across the globe. It is a compilation of datasets found on the UN website which combines internet usage per 100 inhabitants in a country, along with data related to other factors that may or may not affect the levels of internet penetration. The data covers the period from 2008 to 2015. Most of the data, including Internet Usage, life expectancy, urban population and gross national income can be found at this website from the UN - http://data.un.org/Explorer.aspx?d=SDGs&f=series%3aSL_TLF_UEM.
Supporting data for geocodes for each country can be found at this website - https://developers.google.com/public-data/docs/canonical/countries_csv. This was useful for building the leaflet map.

# Application
The shiny application has been deployed on Shiny and can be found at: https://shirlett.shinyapps.io/Vis_Shiny/

The basis of the application is a leaflet map showing the level of Internet usage across the globe. Relative use can be readily observed by the saturation and size of the circle markers. Clicking on the marker shows the actual quantity associated with Internet usage. Clicking also generates a dataframe table and connected scatterplot. Users have the option of downloading the resulting table.

# Reflection
The process of creating the leaflet for shiny was not difficult since I was introduced to it in Homework 6: 
![Part 2](https://github.com/Shirlett/STAT545-hw-Hall-Shirlett/blob/master/HW06/STAT545-HW06-Part2.md)

The most difficult aspect of the assignment was capturing the location clicked on the map and passed to the table and the scatterplot. I was able to adapt the code from ![stack overflow](https://stackoverflow.com/questions/39874318/shiny-leaflet-click-on-marker-to-open-plot-data-table) to succeed with this goal. 

I also viewed a blog from Dean Attali in which he provided some great tools to enhance shiny applications. I found a useful library called shinycssloader that shows the user that the server recognized their click on the map and a plot would be regenerated. I think it is a useful part of the feedback loop in interactive applications. The information for the library can be found here:
https://github.com/andrewsali/shinycssloaders


# Code
The shiny was built using a server side script and a user interface R script. Please see the sections below for the actual code.

## Server
```
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

```


## UI

```
library(shiny)
library(ggmap) #For interaction and extraction with Google API maps
library(dplyr)
library(leaflet)
library(htmlwidgets)
library(shinycssloaders)



ui <- fluidPage(
    titlePanel(title=div(img(src="internet_world.jpg", height = 50, width = 100), "Internet Usage Across the World, 2015")),

sidebarLayout(position="right",

                  sidebarPanel(withSpinner(plotOutput("Internet_Trend"))

                  )
,

  mainPanel(
    textOutput("mytext"),
    leafletOutput("mymap"),
    p(em("Source:"),
    a(href="http://data.un.org/Explorer.aspx?d=SDGs&f=series%3aSL_TLF_UEM", "UN dataset", target="_blank")),
    br(),
    DT::dataTableOutput("myTable"),
    downloadButton("downloadData", "Download Resulting Table")
)
)

)

```





