#' @title Get R code for workshop in year 2023
#' @description This function creates a new folder "R_example_code" at root of project and create an R script file.
#'
#' Author: Xin Xia (loop) and Bolin Wu (tidyverse)
#'
#' @param session Either 'loop' or 'tidyverse'.
#' @param open should the file be opened after being created
#' @param ... arguments to be passed to \link[usethis]{use_template}
#' @importFrom usethis use_template
#' @examples
#' \dontrun{
#' workshopr::get_code_2023(session = "loop")
#' workshopr::get_code_2023(session = "tidyverse")
#' }
#'
#' @export
get_code_2023 <-
  function(session = NULL,
           open = interactive(),
           ...) {
    if (is.null(session)) {
      stop("Select a session: 'loop' or 'tidyverse'.")
    }

    # create a folder for Rmd
    subDir <- "R_example_code"
    if (dir.exists(subDir)) {
      message("'R_example_code' folder already exists.")
    } else {
      message("Create folder 'R_example_code'.")
      dir.create(subDir, showWarnings = FALSE)
    }


    # usethis::use_package("usethis")
    if (session == "loop") {
      usethis::use_template("rscript/workshop_xinxia2023.R",
        save_as = paste0(subDir, "/workshop_xinxia2023.R"),
        data = list(),
        package = "workshopr", ..., open = open
      )
    } else if (session == "tidyverse") {
      usethis::use_template("rscript/tidyverse_2023.R",
        save_as = paste0(subDir, "/tidyverse_2023.R"),
        data = list(),
        package = "workshopr", ..., open = open
      )
    } else {
      stop("The 'session' should be 'loop' or 'tidyverse'")
    }
  }
