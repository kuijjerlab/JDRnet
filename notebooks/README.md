## Introduction
The notebooks in this directory can be used to reproduce the analysis presented in Pop et al. 2024. The order in which they are presented here is the order in which they should be run. 

## Necessary data and software
Before starting the analysis, make sure all the necessary data is downloaded and software is installed. For exact reproducibility of the results presented in *paper*, we provide a container with the environment used for the analysis. The data is available on Zenodo at *link*.

If not using the container provided, we recommend cloning this repository and then downloading the data from Zenodo in the cloned repository directory.

## Single sample networks
The `single_sample_networks` can be used to reproduce the single sample networks.computing these networks can be time and computationally intensive, therefore the indegrees and outdegrees of the networks which were used for analysis are available on Zenodo.

## Data pre-processing
The `process_data.ipynb` notebook performs pre-processing on the omics and survival data and prepares it for the rest of the analysis. As some steps can be time consuming, the processed data is available on Zenodo. 

## Benchmarking PCA for JDR
The `pca_vs_no_pca.ipynb` notebook benchmarks PCA as a filtering opproach for joint dimensionality reduction on four tools. This requires the data processed in `process_data.ipynb`.

