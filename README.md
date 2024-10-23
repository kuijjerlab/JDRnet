# JDRnet
This is a repository for reproducing the analysis in the paper: *title + doi*

## Data availability and reproducibility
All data used can be found on Zenodo at *link + doi*. A small example dataset is provided here for the GRN inference. We also provide a container with the environment used for this analysis for reproducibility, which can be downloaded from *link*.

The code used to download the data can be found in the `download_data` directory.

## PANDA-LIONESS network inference
The PANDA-LIIONESS networks were generated using the workflow found in the **networks** directory in this repository. A small example dataset is also provided, along with a separate README.

## Analysis of TCGA data with JDR tools
The remainder of the analysis is documented in the notebook `JDR_net.ipynb`. The same notebook is also available as an `.Rmd`. Some intermediate files are provided on Zenodo to reduce run-time. These are:
* the factorisations probably
  
## MARMOT tool
Most of the analysis detailed in `JDR_net.ipynb` was performed with the MARMOT tool, which can be found in the repository below:
https://github.com/rtpop/MARMOT