#' @import shiny
app_server <- function(input, output,session) {
  session$onSessionEnded(stopApp)
  
  # List the first level callModules here
  callModule(semantics, "semantics", NULL)
}
