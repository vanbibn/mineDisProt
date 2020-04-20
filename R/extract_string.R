

extract_string <- function(direct) {
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

    # write results matrix to csv

    write.csv(results, file = "Output/String.csv")

    # end with the final results matrix so it will be what is returned by function
    results
}
