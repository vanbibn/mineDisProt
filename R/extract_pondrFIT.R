

extract_pondrFIT <- function(path, save_raw = NULL, output = NULL) {

    # read data from file
    my_urls <- read_csv(path)

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
            write.csv(fit1, file = paste0(save_raw, my_urls$UniprotID[u],"_pondrFIT.csv"))
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
        write.csv(my_urls, file = output)
    }


}
