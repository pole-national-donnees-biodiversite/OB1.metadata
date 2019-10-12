#' Run the Shiny Application
#'
#' @export
library(shinydashboard)
#set working directory from actual file path
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#run shiny app
runApp(".")
