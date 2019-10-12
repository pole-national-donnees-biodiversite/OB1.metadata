#' Run the Shiny Application
#'
#' @export
library(shinydashboard)

source("import/ui_import.R")

#set working directory from actual file path
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#run shiny app
runApp(".")
