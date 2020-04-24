

#' Extract data from text files of protein disorder predictors from PONDR.
#'
#' This function extracts numerical data from text porduced by the VLXT, VL3,
#' and VSL2 disorder predictors from the Predictor of Natural Disordered Regions
#'  (PONDR) website <http://www.pondr.com/>. For each protien sequence, the data
#'  from the Raw Output of all three predictors were pasted into a .txt file.
#'
#' @param directory A character string describing the path to a Directory where
#' all the text files are located. Note, the function will attempt to read every
#' file in the directory so it should contain only the files you wish to be read.
#' @param output A character string describing the path to write the output
#'  matrix. If `NULL`, an output file will not be written.
#'
#' @return A matrix containing, for each protein, the Predicted residues ("resid"), Number
#' Disordered Regions ("dis_rgns"), Number residues disordered ("n_dis"),
#' Longest Disordered Region ("lg_rgn"), Overall percent disordered ("pct"),
#' and Average Prediction Score ("avg") for each of the three predictors.
#' @export
#'
#' @examples
#' # extract_pondr("inst/extdata/pondr_text/")
extract_pondr <- function(directory, output = NULL) {
    ## create column names
    # make vectors for predictors and variables
    predictors <- c("VLXT", "VL3", "VSL2")
    varbs <- c(
        "resid",      # Predicted residues (total number)
        "dis_rgns",   # Number Disordered Regions
        "n_dis",      # Number residues disordered
        "lg_rgn",     # Longest Disordered Region
        "pct",        # Overall percent disordered
        "avg"         # Average Prediction Score
    )
    # combine each value of predictors and varbs with "." between them
    varnames <- as.vector(outer(varbs, predictors, paste, sep = "."))

    # create a vector of file names in listed directory
    files <- list.files(directory)


    #### Loop through each file and do the following
    for (f in 1:length(files)) {
        pondr <- readLines(paste0(directory, files[f]))

        ## remove disorder segment lines:
        # 1. make logical vector for: if line contains "Predicted disorder segment"
        dis_seg <- grepl("Predicted disorder segment", pondr)

        # 2. make new vector withough disorder segement lines
        all_stats <- pondr[!dis_seg]


        # isolate lines by each predictor
        vlxt <- all_stats[2:4]
        vl3 <- all_stats[6:8]
        vsl2 <- all_stats[10:12]

        # combine all predictors into single vect again (essentially removed head line)
        preds <- c(vlxt, vl3, vsl2)


        # create an empty vector for data
        myresult <- NULL

        # replace the first tab in every line with a ";"
        # split line in substrings using the ; just inserted
        # extract number values form each substring and add to myresult vector
        for (p in preds) {
            sl <- sub("\t", ";", p)
            z <- unlist(strsplit(sl, ";")) # srtsplit returns a list, but parse_number takes a vector
            m <- readr::parse_number(z)
            myresult <- c(myresult, m)
        }

        # convert myresults vector into a matrix
        my_matrix <- rbind(matrix(myresult, byrow = TRUE, ncol = 18))
        row.names(my_matrix) <- paste0(sub(".txt", "", files[f]))
        colnames(my_matrix) <- varnames


        # check if results matrix exists, if not make it, else add row to it
        if (!exists("results")) {
            results <- my_matrix
        } else {
            results <- rbind(results, my_matrix)
        }

    }
    ### END loop


    # option to write results matrix to csv
    # output must be a character vector of the PATH desired for output file
    if (!is.null(output)) {
        utils::write.csv(results, file = output)
    }

    # end with the final results matrix so it will be what is returned by function
    results
}
