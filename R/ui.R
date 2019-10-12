#' @import shiny
app_ui <- function() {
  #tagList(
  # Leave this function for adding external resources
  # golem_add_external_resources(),
  # List the first level UI elements here 
  fluidPage(
    dashboardPage(
      title = "OB1.metadata",
      dashboardHeader(
        title = "OB1.metadata"
      ),
      dashboardSidebar(
        sidebarMenu(
          menuItem("Welcome", tabName = "welcome", 
                   icon = icon("home")),
          menuItem("Upload File", tabName = "upload_file", 
                   icon = icon("upload")),
          menuItem("Inferences", tabName = "infer", 
                   icon = icon("beer")),
          menuItem("Semantics", tabName = "semantics", 
                   icon = icon("project-diagram"))
        )
      ),
      dashboardBody(
        # tags$head(
        #   tags$style(
        #     HTML("
        #       /* body */
        #       .content-wrapper, .right-side {
        #       background-image:url(https://live.staticflickr.com/4413/35827585043_cf308d88cc_z.jpg);
        #       background-size: cover;
        #       }
        #     ")
        #   )
        # ),
        tabItems(
          tabItem("welcome",
                  fluidPage(h1("Pitch by Yvan"))
          ),
          tabItem("upload_file",
                  ui_import("import_id")
          ),
          tabItem("infer",
                  fluidPage("infer")
          ),
          tabItem("semantics",
                  semanticsUI("semantics")
          )
        )
      )
    )
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
