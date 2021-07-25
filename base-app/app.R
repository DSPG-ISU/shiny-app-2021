library(shiny)
library(shinydashboard)
library(shinyjs)
library(leaflet)
library(sf)
library(tidyverse)

# use the theme
source("theme.R")

jscode <- "var referer = document.referrer;
           var n = referer.includes('economic');
           var x = document.getElementsByClassName('logo');
           if (n != true) {
             x[0].innerHTML = '<a href=\"https://datascienceforthepublicgood.org/events/symposium2021/poster-sessions\">' +
                              '<img src=\"DSPG_white-01.png\", alt=\"DSPG 2021 Symposium Proceedings\", style=\"height:42px;\">' +
                              '</a>';
           } else {
             x[0].innerHTML = '<a href=\"https://datascienceforthepublicgood.org/economic-mobility/community-insights\">' +
                              '<img src=\"AEMLogoGatesColors-11.png\", alt=\"Gates Economic Mobility Case Studies\", style=\"height:42px;\">' +
                              '</a>';
           }
           "

# load data
population <- read.csv("data/population.csv")


ui <- dashboardPage(
  header = dashboardHeader(),
  sidebar = dashboardSidebar(
    sidebarMenu(
      id = "tabs",
      menuItem(
        tabName = "overview",
        text = "Project Overview",
        icon = icon("info circle")
      ),
      menuItem(
        tabName = "map",
        text = "Interactive Map",
        icon = icon("map-marked-alt")
      ),
      menuItem(
        tabName = "graph",
        text = "Interactive Graph",
        icon = icon("map-marked-alt")
      ),
      menuItem(
        tabName = "both",
        text = "Mutiple Interactive",
        icon = icon("map-marked-alt")
      ),
      menuItem(
        tabName = "data",
        text = "Data & Methodology",
        icon = icon("database")
      ),
      menuItem(
        tabName = "findings",
        text = "Findings",
        icon = icon("chart-pie")
      ),
      menuItem(
        tabName = "team",
        text = "Team",
        icon = icon("user-friends")
      )
    )
  ),
  body = dashboardBody(
    useShinyjs(),
    use_theme(mytheme), # <-- use the theme
    
    theme = use_theme(mytheme),
    fluidPage(
      tabItems(
        tabItem(tabName = "overview",
                fluidRow(
                  box(
                    title = "Project Overview",
                    closable = FALSE,
                    width = NULL,
                    status = "primary",
                    solidHeader = TRUE,
                    collapsible = TRUE,
                    h1("2021 DSPG Project Name"),
                    h2("Project Description"),
                    p("Example text: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam in varius purus. Nullam ut sodales ante. Fusee justo nisi, suscipit a lacus et, posuere sagittis ex."),
                    h2("Project Goals"),
                    p("Example text: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam in varius purus. Nullam ut sodales ante. Fusee justo nisi, suscipit a lacus et, posuere sagittis ex."),
                    h2("Our Approach"),
                    p("Example text: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam in varius purus. Nullam ut sodales ante. Fusee justo nisi, suscipit a lacus et, posuere sagittis ex."),
                    h2("Ethical Considerations"),
                    p("Example text: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam in varius purus. Nullam ut sodales ante. Fusee justo nisi, suscipit a lacus et, posuere sagittis ex.")
                  )
                )),
        tabItem(tabName = "map",
                fluidRow(
                  box(
                    title = "Interactive Map",
                    closable = FALSE,
                    status = "primary",
                    solidHeader = TRUE,
                    collapsible = TRUE,
                    width = NULL,
                    enable_sidebar = TRUE,
                    sidebar_width = 25,
                    sidebar_start_open = TRUE,
                    sidebar_content = tagList(p(),
                                              actionButton("recalc", "Click Me!")),
                    leafletOutput("mymap")
                  ),
                  p("Explanatory text: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam in varius purus. Nullam ut sodales ante."),
                  br()
                )),
        tabItem(tabName = "graph",
                fluidRow(
                  box(
                    title = "Interactive Graph",
                    closable = FALSE,
                    status = "primary",
                    solidHeader = TRUE,
                    collapsible = TRUE,
                    width = NULL,
                    enable_sidebar = TRUE,
                    sidebar_width = 25,
                    sidebar_start_open = TRUE,
                    sidebar_content = sliderInput(
                      "obs",
                      "Number of observations:",
                      min = 0,
                      max = 1000,
                      value = 500
                    ),
                    plotOutput("distPlot")
                  ),
                  p("Explanatory text: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam in varius purus. Nullam ut sodales ante."),
                  br()
                )),
        tabItem(tabName = "both",
                fluidRow(
                  box(
                    title = "Interactive Graph",
                    closable = FALSE,
                    status = "primary",
                    solidHeader = TRUE,
                    collapsible = TRUE,
                    width = 6,
                    enable_sidebar = TRUE,
                    sidebar_width = 25,
                    sidebar_start_open = TRUE,
                    sidebar_content = tagList(sliderInput(
                      "obs2",
                      "Number of observations:",
                      min = 0,
                      max = 1000,
                      value = 500
                    )
                    ),
                    plotOutput("distPlot2"),
                    footer = "Explanatory text: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam in varius purus. Nullam ut sodales ante."
                  ),
                  box(
                    title = "Interactive Map",
                    closable = FALSE,
                    status = "primary",
                    solidHeader = TRUE,
                    collapsible = TRUE,
                    width = 6,
                    enable_sidebar = TRUE,
                    sidebar_width = 25,
                    sidebar_start_open = TRUE,
                    sidebar_content = tagList(
                      p(),
                      actionButton("recalc2", "Click Me!")
                    ),
                    leafletOutput("mymap2"),
                    footer = "Explanatory text: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam in varius purus. Nullam ut sodales ante."
                  )
                )),
        tabItem(tabName = "data",
                fluidRow(
                  box(
                    title = "Data & Methodology",
                    closable = FALSE,
                    width = NULL,
                    status = "primary",
                    solidHeader = TRUE,
                    collapsible = TRUE,
                    h2("Data Sources"),
                    img(src = "data_sets.png", width = "450px", align = "right"),
                    h3("Data Source 1"),
                    p("Example text: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam in varius purus. Nullam ut sodales ante. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam in varius purus. Nullam ut sodales ante."),
                    h3("Data Source 2"),
                    p("Example text: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam in varius purus. Nullam ut sodales ante. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam in varius purus. Nullam ut sodales ante."),
                    h3("Data Source 3"),
                    p("Example text: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam in varius purus. Nullam ut sodales ante. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam in varius purus. Nullam ut sodales ante."),
                    h2("Methodology"),
                    h3("Data Preparation"),
                    p("Example text: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam in varius purus. Nullam ut sodales ante. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam in varius purus. Nullam ut sodales ante."),
                    h3("Data Modeling"),
                    p("Example text: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam in varius purus. Nullam ut sodales ante. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam in varius purus. Nullam ut sodales ante.")
                  )
                )),
        tabItem(tabName = "findings",
                fluidRow(
                  box(
                    title = "Findings",
                    closable = FALSE,
                    width = NULL,
                    status = "primary",
                    solidHeader = TRUE,
                    collapsible = TRUE,
                    h2("Summary of Findings"),
                    p("Example text: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam in varius purus. Nullam ut sodales ante. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam in varius purus. Nullam ut sodales ante. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam in varius purus. Nullam ut sodales ante."),
                    h3("Results Section One"),
                    img(src = "irrational_venn_diagram.png", width = "360px", align = "right"),
                    p("Example text: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam in varius purus. Nullam ut sodales ante. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam in varius purus. Nullam ut sodales ante. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam in varius purus. Nullam ut sodales ante. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam in varius purus. Nullam ut sodales ante. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam in varius purus. Nullam ut sodales ante."),
                    h3("Results Section Two"),
                    p("Example text: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam in varius purus. Nullam ut sodales ante. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam in varius purus. Nullam ut sodales ante. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam in varius purus. Nullam ut sodales ante. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam in varius purus. Nullam ut sodales ante."),
                    h3("Results Section Three"),
                    img(src = "food_reality_chart.png", width = "400px", align = "right"),
                    p("Example text: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam in varius purus. Nullam ut sodales ante. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam in varius purus. Nullam ut sodales ante. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam in varius purus. Nullam ut sodales ante. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam in varius purus. Nullam ut sodales ante. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam in varius purus. Nullam ut sodales ante.")
                  )
                )),
        tabItem(tabName = "team",
                fluidRow(
                  box(
                    title = "Our Team",
                    closable = FALSE,
                    width = NULL,
                    status = "primary",
                    solidHeader = TRUE,
                    collapsible = TRUE,
                    h2("DSPG Team Members"),
                    p("[Photos go about here.]"),
                    h2("ISU Extension Team Members"),
                    p("[Photos go about here.]"),
                    h2("Project Sponsors"),
                    p("[Photos, information, and/or links about your sponsor go about here. You may want to use materials that your sponsors have already shared with you about their institution or coordinate with your stakeholders to include pertinent information here.]"),
                    h2("Acknowledgements"),
                    p("[Optional: You can also include external collaborators in this section or a separate section.]")
                  )
                )
        )
      )
    )
  )
)

server <- function(input, output, session) {
  # Run JavaScript Code
  runjs(jscode)
  
  output$mymap <- renderLeaflet({
    states <- USAboundaries::us_boundaries(type="county")
    states <- states %>% filter(state_name == "Iowa") %>%
      mutate(
        COUNTY = as.numeric(countyfp),
        STATE = as.numeric(statefp)
      )
    plotdat <- states %>% left_join(population %>% 
                                      select(STATE, COUNTY, STNAME, CENSUS2010POP, POPESTIMATE2019), 
                                    by=c("COUNTY", "STATE"))
    # COUNTY and STATE are fips codes
    
    # range of numbers in the color palette
    scale_range <- c(0,max(plotdat$POPESTIMATE2019))
    # missing values are bright green, so we can see them and fix them :)
    pal <- colorNumeric("Reds", scale_range, na.color = "#aaff56", reverse=FALSE)
    
    
    leaflet() %>%
      addProviderTiles("CartoDB.Positron") %>%  
      addPolygons(data = plotdat,
                  color = "#000000", # outline of polygons
                  fillColor = ~pal(plotdat$POPESTIMATE2019), # color mapping
                  fillOpacity = 0.9,
                  weight = 0.2,
                  smoothFactor = 0.2,
                  # text to be shown on click is in html
                  popup = ~ paste0(name,", ", str_extract(state_name, "^([^,]*)"), "<br>", POPESTIMATE2019)) %>%
      addLegend(pal = pal,
                values = scale_range,
                position = "topright",
                title = "Population<br>Estimate 2019"
      )
  })
}

shinyApp(ui, server)