#' @import shiny
app_ui <- function() {
  #tagList(
  # Leave this function for adding external resources
  # golem_add_external_resources(),
  # List the first level UI elements here 
  
  # call for empty fluidPage because main is creating the dashboard look
  fluidPage(
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