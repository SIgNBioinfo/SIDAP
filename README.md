sidap_0.99.3
=================

###An Integrated Mass Cytometry Data Analysis Pipeline
-----------------------------------------
This is a BETA release of SIDAP, Analyse the CYTOF data by simultaneous illustration of diversity and progression.
To use this package, you will need the R statistical computing environment (R (>= 2.7.0)) and several dependent 
packages (tcltk, flowCore, mclust, gplots, igraph, reshape, graphics, ggplot2, e1071, lle, vegan) available through Bioconductor.

------------------------------------------------
### sidap Package Installation and Running
1.Download this package to your local directory, then start the R session, and change the working directory to where the "sidap_0.99.3.tar.gz" is, then
type the following commands:
```
install.packages("SIDAP_1.0.tar.gz", repos = NULL, type = "source")
```  
2.Running this package is depended on several other R packages(listed above) which available through Bioconductor. You need to run the `SIDAP_firstRun' 
function first before use. 
```
library(sidap)
SIDAP_firstRun()
```
Otherwise, if you don't want to bother with that, **sidap** provides a user friendly GUI for the workhorse function `cytof_tsne_densvm` in this package.
```
library(sidap)
cytof_tsne_densvm_GUI()
```

3.Check the help pages for more information about this package and the using of the workhorse function.
              
**NOTE**: This package is in the BETA stage of development, new features will continue to be added, please take note for changes in this package. Also this version is tested on windows only.

 
 