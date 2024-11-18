# JDRnet
This is a repository for reproducing the analysis in the paper: ***Gene regulatory network integration with multi-omics data enhances survival predictions in cancer*** *citation*

## Data availability and reproducibility
All data used can be found on Zenodo at *link + doi*. We also provide a container with the environment used for this analysis for reproducibility, which can be downloaded from *link*.

The code used to download the data can be found in the `download_data` subdirectory along with a more detailed `README`.

## Downloading and setting up the container


## PANDA-LIONESS network inference
The PANDA-LIIONESS networks can be reproduced using the workflow found in the `single_sample_networks.ipynb` jupyter notebbok. See the `README` in the `notebooks` subdirectory of this repository.

## Analysis of TCGA data with JDR tools
The remainder of the analysis is documented in the notebook `JDR_net.ipynb` found in the `notebooks` subdirectory. Some intermediate files are provided on Zenodo to reduce run-time. These are:
* the factorisations
* the indegrees & outdegrees of the single sample networks.
  
## MARMOT tool
Most of the analysis detailed in `JDR_net.ipynb` was performed with the MARMOT tool, which can be found in the repository below:
https://github.com/rtpop/MARMOT