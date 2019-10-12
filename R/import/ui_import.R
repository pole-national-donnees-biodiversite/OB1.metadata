#' @import shiny
ui_import <- function(import_id) {
  #tagList(
  # Leave this function for adding external resources
  # golem_add_external_resources(),
  # List the first level UI elements here 
  
  # basic look since ui.R is creating dashboard 
  fluidPage(
    fileInput(
      inputId = "file1", 
      label = "Choose CSV File",
      multiple = FALSE,
      accept = c(
                "text/csv",
                "text/comma-separated-values,text/plain",
                ".csv")
      ),
    tableOutput("contents")
  )
}

#' @import shiny
#golem_add_external_resources <- function(){

#addResourcePath(
#  'www', system.file('app/www', package = 'OB1.metadata')
#  )

# tags$head(
#  golem::activate_js(),
# golem::favicon()
# Add here all the external resources
# If you have a custom.css in the inst/app/www
# Or for example, you can add shinyalert::useShinyalert() here
#tags$link(rel="stylesheet", type="text/css", href="www/custom.css")
#  )
#}
