SIDAP_firstRun <-
function() {
    
    if (!require(tcltk, quietly = TRUE)) {
        install.packages("tcltk")
    }
    if (!require(flowCore)) {
        source("http://bioconductor.org/biocLite.R")
        biocLite("flowCore", ask = FALSE)
    }
    if (!require(mclust)) {
        source("http://bioconductor.org/biocLite.R")
        biocLite("mclust", ask = FALSE)
    }
    if (!require(gplots)) {
        source("http://bioconductor.org/biocLite.R")
        biocLite("gplots", ask = FALSE)
    }
    if (!require(reshape)) {
        source("http://bioconductor.org/biocLite.R")
        biocLite("reshape", ask = FALSE)
    }
    if (!require(graphics)) {
        source("http://bioconductor.org/biocLite.R")
        biocLite("graphics", ask = FALSE)
    }
    if (!require(ggplot2)) {
        source("http://bioconductor.org/biocLite.R")
        biocLite("ggplot2", ask = FALSE)
    }
    if (!require(e1071)) {
        source("http://bioconductor.org/biocLite.R")
        biocLite("e1071", ask = FALSE)
    }
    if (!require(lle)) {
        source("http://bioconductor.org/biocLite.R")
        biocLite("lle", ask = FALSE)
    }
    if (!require(vegan)) {
        source("http://bioconductor.org/biocLite.R")
        biocLite("vegan", ask = FALSE)
    }
}
