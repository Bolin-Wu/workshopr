#' @title Loop session code
#' @description Load the R code for loop session at R workshop. Author: Xin Xia.
#' @param open should the file be opened after being created
#' @param ... arguments to be passed to \link[usethis]{use_template}
#' @importFrom usethis use_template
#' @examples
#' \dontrun{
#' workshopr::loop_session_2023()
#' }
#'
#' @export
loop_session_2023 <-
  function(
           open = interactive(),
           ...) {
      name <- "workshop_xinxia2023.R"

    # create a folder for Rmd
    message("Create folder 'R_example_code'")
    dir.create("R_example_code", showWarnings = FALSE)

    # usethis::use_package("usethis")
      usethis::use_template("workshop_xinxia2023.R",
                            save_as = paste0("R_example_code/", name),
                            data = list(),
                            package = "workshopr", ..., open = open
      )
}
