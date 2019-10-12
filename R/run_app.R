setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
#' Run the Shiny Application
#'
#' @export
library(shinydashboard)
source("import/ui_import.R")
source("semantics/semanticsUI.R")

#run shiny app
runApp(".")