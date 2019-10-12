setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
#' Run the Shiny Application
#'
#' @export
library(shinydashboard)
source("Semantics/semanticsUI.R")
#set working directory from actual file path

#run shiny app
runApp(".")