#' @title get_solution_2023
#' @description Get the solution of final practice.
#'
#' Author: Xin Xia
#'
#'
#' @param name Name of rmd file. Please do not use '/' in the the file name (no need to add suffix ".Rmd").
#' @param subDir Name of the folder where rmd file will be created. Remember to connect sub-dir names with '/'. By default it is 'rmd'.
#' @param open Should the file be opened after being created.
#' @param ... Arguments to be passed to \link[usethis]{use_template}
#' @importFrom usethis use_template
#' @examples
#' \dontrun{
#' workshopr::get_solution_2023(name = "practice_solution")
#' }
#'
#'
#' @export
#'
get_solution_2023 <-
  function(name = NULL,
           subDir = "rmd",
           open = interactive(),
           ...) {
    if (is.null(name)) {
      name <- "Solution.Rmd"
    } else {
      name <- paste0(name, ".Rmd")
    }

    # create a folder for Rmd
    if (dir.exists(subDir)) {
      message("folder:", subDir, " already exists.")
    } else {
      message("Create folder: ", subDir, ".")
      dir.create(subDir, showWarnings = TRUE, recursive = TRUE)
    }
    usethis::use_template("rmarkdown/practice-solution.Rmd",
                          save_as = paste0(subDir, "/", name),
                          data = list(),
                          package = "workshopr", ..., open = open
    )
  }
