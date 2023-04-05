#' @title get_rmd_2023
#' @description Use the preset rmd template. By default, this function creates a new folder "rmd" at root of project and create an rmd file with nice-looking template there.
#' @param name Name of rmd file. Please do not use '/' in the the file name (no need to add suffix ".Rmd").
#' @param subDir Name of the folder where rmd file will be created. Remember to connect sub-dir names with '/'. By default it is 'rmd'.
#' @param open Should the file be opened after being created.
#' @param output_file "word" or "html" or "pdf", by default it is "html".
#' @param ... Arguments to be passed to \link[usethis]{use_template}
#' @importFrom usethis use_template
#' @examples
#' \dontrun{
#' workshopr::get_rmd_2023(subDir = "rmd", name = "pretty_template", output_file = "word")
#' }
#'
#' @export
#'
get_rmd_2023 <-
  function(name = NULL,
           subDir = "rmd",
           output_file = "html",
           open = interactive(),
           ...) {
    if (is.null(name)) {
      name <- "analysis.Rmd"
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

    # usethis::use_package("usethis")
    if (output_file == "html") {
      usethis::use_template("rmarkdown/skeleton_html.Rmd",
        save_as = paste0(subDir, "/", name),
        data = list(),
        package = "workshopr", ..., open = open
      )
    } else if (output_file == "word") {
      usethis::use_template("rmarkdown/skeleton_word.Rmd",
        save_as = paste0(subDir, "/", name),
        data = list(),
        package = "workshopr", ..., open = open
      )
    } else if (output_file == "pdf") {
      usethis::use_template("rmarkdown/skeleton_pdf.Rmd",
        save_as = paste0(subDir, "/", name),
        data = list(),
        package = "workshopr", ..., open = open
      )
    } else {
      stop("The 'output_file' should be 'html' or 'word' or 'pdf'.")
    }
  }
