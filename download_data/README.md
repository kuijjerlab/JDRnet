# Downloading data
The scripts in this directory document how the data was downloaded from external sources. The data currently stored at these sources may have changed in the interim. For the exact data used in this analysis, please see the Zenodo repository. 

## TCGA data
The TCGA data was downloaded from [MOMIX](https://github.com/cantinilab/momix-notebook?tab=readme-ov-file) using their `download-data.sh`. This script is reproduced here in full and was modified only to reflect the directory structure we used.

## GEPliver data
Data was also downloaded from GEP-liver^1^ using the `get_gep_liver.sh` script. The `gep_data_process.r` script concatenates all the files. This dataset was used to validate the findings in the liver cancer dataset from MOMIX. Part of the data in GEP liver originates from TCGA, as does the MOMIX data. Therefore, the `gep_data_process.r` script also ensures that any TCGA samples found in the MOMIX dataset are excluded from this one. 

## References
1. Li, Z., Zhang, H., Li, Q. et al. GepLiver: an integrative liver expression atlas spanning developmental stages and liver disease phases. Sci Data 10, 376 (2023). https://doi.org/10.1038/s41597-023-02257-1