

#' Extract data on the quantity of protein interactions given by STRING.
#'
#' Extract data on the quantity of protein interactions given by STRING
#' (https://string-db.org/) with the minimum number of interactions at
#' medium (0.4), high (0.7), and highest (0.9) confidence.
#'
#' @param direct A character string describing the path to a Directory where
#' all the text files are located. Note, the function will attempt to read every
#' file in the directory so it should contain only the files you wish to be read.
#' @param output A character string describing the path to write the output
#'  matrix. If `NULL`, an output file will not be written.
#'
#' @return A matrix containing the network stats at each of the three confidence
#' levels for every protein.
#' @export
#'
#' @examples
#' extract_string("data/string/")
extract_string <- function(direct, output = NULL) {
    # create vector of even numbers between 2 and 12
    evens <- seq(from = 2, to = 12, by = 2)

    # create column names
    ## first make individual vectors
    confidence <- c("0.4", "0.7", "0.9")
    names <- c(
        "num_nodes",
        "num_edges",
        "avg_node_degree",
        "avg_local_clustering_coef",
        "expected_num_edges",
        "PPI_enrichment_p-value")

    ## combine each value of confidence and names with "." between them
    varnames <- as.vector(outer(names, confidence, paste, sep = "."))


    # create a vector of file names in listed directory
    # direct <- "Data/string/"  # made a parameter of the function
    files <- list.files(direct)

    ## for each file in folder
    for (f in seq_along(files)) {

        # read data from sheet1-3
        sheet1 <- readxl::read_xlsx(paste0(direct, files[f]), sheet = "Sheet1", col_names = "mix")
        sheet2 <- readxl::read_xlsx(paste0(direct, files[f]), sheet = "Sheet2", col_names = "mix")
        sheet3 <- readxl::read_xlsx(paste0(direct, files[f]), sheet = "Sheet3", col_names = "mix")

        # extract data for columns from even cells of each sheet
        m1 <- matrix(as.numeric(sheet1$mix[evens]), nrow = 1, ncol = 6, byrow = TRUE)
        m2 <- matrix(as.numeric(sheet2$mix[evens]), nrow = 1, ncol = 6, byrow = TRUE)
        m3 <- matrix(as.numeric(sheet3$mix[evens]), nrow = 1, ncol = 6, byrow = TRUE)

        # combine into one matrix with one row per protein
        my_matrix <- cbind(m1,m2,m3)
        row.names(my_matrix) <- toupper(paste0(sub("_string.xlsx", "",  files[f])))
        colnames(my_matrix) <- varnames

        # compile all proteins into one matrix
        ## check if results matrix exists, if not make it, else add row to it
        if (!exists("results")) {
            results <- my_matrix
        } else {
            results <- rbind(results, my_matrix)
        }

    }
    # End loop

    # option to write results matrix to csv
    # output must be a character vector of the PATH desired for output file
    if (!is.null(output)) {
        utils::write.csv(results, file = output)
    }


    # end with the final results matrix so it will be what is returned by function
    results
}
