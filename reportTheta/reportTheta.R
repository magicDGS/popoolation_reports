## Needs ThetaReport.Rmd

args <- commandArgs(FALSE)

script.basename <- dirname(sub("--file=", "", args[grep("--file=", args)]))
reportRmd <- paste(script.basename, "template.Rmd", sep="/")
WD <- getwd()

usage <- function() {
    cat("Usage: Rscript thetaReport.R -i <infile> -t <threshold> [-o outprefix]
\tinfile\t\tTab delimited file from Popoolation theta calculation
\tthreshold\tMinimum proportion of the windows covered
\toutprefix\t\tPrefix to store the results (default: infile). Generates a .pdf report and .mean with the mean value\n",
    file=stderr())
}

i_pos <- grep("-i", args) + 1
t_pos <- grep("-t", args) + 1
o_pos <- grep("-o", args) + 1
if(length(i_pos) == 0 | length(t_pos) == 0) {
    usage()
    stop("Required parameters: -i, -t")
}

input <- (args[i_pos])
if(!file.exists(input)) {
    usage()
    stop("Input ile does not exists")
}

threshold <- as.numeric(args[t_pos])

if(length(args[o_pos]) == 0) {
    outprefix <- input
} else {
    outprefix <- args[o_pos]
}

WORKING_DIRECTORY <- paste(WD, dirname(outprefix), sep="/")
dir.create(WORKING_DIRECTORY, F)

cat("Checking and installing needed packages\n", file=stderr())
if(!require(rmarkdown, quietly = T, warn.conflicts = F)) {
    cat("Installing required package: rmarkdown\n", file=stderr())
    install.packages("rmarkdown")
    if(!require(rmarkdown, quietly = T, warn.conflicts = F)) {
        stop("rmarkdown package should be installed manually\n")
    }
}

if(!require(ggplot2, quietly = T, warn.conflicts = F)) {
    cat("Installing required package: ggplot2\n", file=stderr())
    install.packages("ggplot2")
    if(!require(ggplot2, quietly = T, warn.conflicts = F)) {
        stop("ggplot2 package should be installed manually\n")
    }
}

cat("rmarkdown package: OK\n", file=stderr())
cat("ggplot2 package: OK\n", file=stderr())

output <- paste(outprefix, "pdf", sep=".")
tryCatch(
    { render(input = reportRmd, output_format = "pdf_document", output_file = output, output_dir = WORKING_DIRECTORY, ) },
    error = function(e) {
        cat("Error:\t", file=stderr())
        cat(e$message, file=stderr())
        cat("\n", file=stderr())
        if(e$message == "pandoc version 1.12.3 or higher is required and was not found.") {
            cat("\tsee https://github.com/rstudio/rmarkdown/blob/master/PANDOC.md\n", file=stderr())
        }
        q("no")
    }
)
sink(paste(outprefix, "mean", sep="."))
cat(meanTheta)
cat("\n")
sink()

