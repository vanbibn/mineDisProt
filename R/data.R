#' Data on disordered regions in proteins from several predictors on PONDR.
#'
#' An example dataset produced by the extract_pondr() function containing the
#' attributes on disorder in proteins calculated by several prodein disorder
#' predictors on PONDR /url{http://www.pondr.com/}.
#'
#' \itemize{
#'   \item VLXT, VL3, VSL2. protein disorder predictors on PONDR
#'   \item resid. Predicted residues (total number)
#'   \item dis_rgns. Number Disordered Regions
#'   \item n_dis. Number residues disordered
#'   \item lg_rgn. Longest Disordered Region
#'   \item pct. Overall percent disordered
#'   \item avg. Average Prediction Score
#'}
#'
#' @docType data
#' @keywords datasets
#' @name pondr_data
#' @usage data(pondr_data)
#' @format A matrix with 10 rows and 18 variables
NULL



#' Data on disordered regions in proteins from PONDR-FIT meta-predictor.
#'
#' An example dataset produced by the extract_pondrFIT() function containing the
#' attributes on disorder in proteins calculated by the PONDR-FIT disorder
#' meta-predictors on DisPort /url{http://original.disprot.org/pondr-fit.php}.
#'
#' \itemize{
#'   \item UniprotID. Unique identifier of the protein in Uniprot database /url{https://www.uniprot.org/}
#'   \item url. temporaty URL of the raw data produced by analyzing a protein sequence with PONDR-FIT
#'   \item meanDisorder. The average (mean) of the per-residue disorder scores
#'   \item percentDisorder. The proportion of the per-residue scores that are greater than 0.5
#'   \item lenngth. A count of the number of residues in the protein sequence
#'}
#'
#' @docType data
#' @keywords datasets
#' @name pondrFIT_data
#' @usage data(pondrFIT_data)
#' @format A data frame with 10 rows and 5 variables
NULL



#' Data on protein interaction networks.
#'
#' An example dataset produced by the extract_string() function containing the
#' attributes on protein interactions calculated by several confidence levels
#' on STRING /url{https://string-db.org/}.
#'
#' \itemize{
#'   \item 0.4, 0.7, 0.9. confidence levels
#'   \item nodes. Number of nodes (proteins) in network
#'   \item edges. Number of edges (interactions) in network
#'   \item node_deg. Average node degree
#'   \item lc_coef. Avgerage local clustering coeffficient
#'   \item edges_Exp. Expected number of edges
#'   \item p_PPI. PPI enrichment p-value
#'}
#'
#' @docType data
#' @keywords datasets
#' @name string_data
#' @usage data(string_data)
#' @format A matrix with 10 rows and 18 variables
NULL

