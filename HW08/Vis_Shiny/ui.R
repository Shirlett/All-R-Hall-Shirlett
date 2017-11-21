
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


