

#' Extract data from URLs produced by PONDR-FIT meta-predictor
#'
#' This function extracts the relevant data from the temporaty URL produced by
#' analyzing a protein sequence in the PONDR-FIT protein disorder meta-predictor
#' (http://original.disprot.org/pondr-fit.php). It then calculates  average and
#' percent disorder scores from the per-residue scores.  Before using this
#' function, URLs should be collected and put in a `.csv` file with the
#' UniProt ID in the first column and URL in the second.
#'
#' @param path A character string desctibing the path to the csv file containing
#'  URLs to be read.
#' @param save_raw A character string describing the path to a *Directory* where
#'  intermediate files for each protein should be saved. If `NULL`, the
#'  intermediate files will not be written to csv.
#' @param output A character string describing the path to write the output
#'  data frame. If `NULL`, an output file will not be written.
#'
#' @return A data frame containing the average disorder scores, percent disorder
#'  scores, and length (in addition to the UniProt ID and URL that were input).
#' @export
#'
#' @examples
#' # extract_pondrFIT("inst/extdata/pondrfit-url.csv")
#' # extract_pondrFIT("data/pondrfit-url.csv", save_raw = NULL, output = "data/PONDR-FIT.csv")
extract_pondrFIT <- function(path, save_raw = NULL, output = NULL) {

    # read data from file
    my_urls <- readr::read_csv(path)

    # create 3 empty columns for avg disorder scores, % disorder scores, and length
    my_urls <- dplyr::mutate(my_urls, meanDisorder = NA, percentDisorder = NA, length = NA)



    # Write a for loop to do them all iteratively #################################

    for (u in 1:length(my_urls$url)) {
        # read data from temporary url for PONDR-FIT data
        # start reading from line 2 (skip first line)
        fit1 <- readr::read_table2(my_urls$url[u], col_names = FALSE, skip = 1)

        # add column names and write out to text file
        colnames(fit1) <- c("position", "residue", "score", "error")

        # MAKE OPTIONAL
        if (!is.null(save_raw)) {
            utils::write.csv(fit1, file = paste0(save_raw, my_urls$UniprotID[u],"_pondrFIT.csv"))
        }
        #

        #calculate the mean disorder score
        my_urls$meanDisorder[u] <- mean(fit1$score)

        ## Percent disorder: count # resid score>0.5 and divid by total # residues
        ## Taking mean of a logical vector (ie. 1's and 0's) will give same result
        my_urls$percentDisorder[u] <- mean(fit1$score > 0.5)

        my_urls$length[u] <- length(fit1$score)
    }


    # option to write results matrix to csv
    # output must be a character vector of the PATH desired for output file
    if (!is.null(output)) {
        utils::write.csv(my_urls, file = output)
    }

    # end with the final matrix so it will be what is returned by function
    my_urls
}
