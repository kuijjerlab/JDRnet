# Single-sample gene regulatory network inference with PANDA and LIONESS

This workflow generates single sample PANDA-LIONESS GRNs using a matlab implementation of the two tools that can be found in the `lib` sub-directory of this repository. We provide it here for the reproducibility of the networks used in *paper*, however other newer implementations of these tools are available and can be found at [The Network Zoo](https://netzoo.github.io/). We recommend using those for any new analysis.

We also provide a small example dataset.

## Quick start
1. Edit the input file names and paths in `panda_config.m`

2. Run the `panda_run.sh` script from the command line using `nohup bash panda_run.sh &`. 
   
3. Edit the `lioness_config.m` file with the correct paths and file names.

4. Run the `lioness_run.sh` script from the command line using `nohup bash lioness_run.sh x y &`. `x` and `y` should be the first and last samples that LIONESS should be run for, respectively. To run on all samples, use `x=1 y=-1`. 

5. Run the `read_combine_degree.sh` script to combine the LIONESS networks into one file and calculate the in and out degrees.

6. after running all of these, you can delete the `.mat` files in `output` and `mat`, the `.txt` files in `txt`, and `net.RData` and `edges.RData` to save space

## Description of the workflow scripts
* **panda_config.m** and **lioness_config.m** are configuration files for the PANDA and LIONESS tools and are the only files that should be edited.
* **panda_run.sh** is a wrapper script for `panda_run.m` that can be run from the command line with `nohup bash panda_run.sh &`. It will also output a log file.
* **panda_run.m** will run PANDA on all samples and store the output in the directory `mat`.
* **liioness_run.sh** is a wrapper script for `lioness_run.m` that will run it for a specified subset of samples. It can be called from the command line with `nohup bash lioness_run.sh x y &`. `x` and `y` should be the first and last samples, respectively, of the subset on which to run LIONESS. To run on all samples, use `x=1 y=-1`. This script will also output a log file.
* **lioness_run.m** will run LIONESS on a specified subset of samples. The individual lioness runs will be numbered according to the column in the expression data and will be stored in the folder `output`.
* **read_and_print_networks.m** reads the matlab files and prints them to text files that can be read in R or other languages.
* **combine_networks.R** merges the separate LIONESS networks into one large matrix with samples as columns and edges as rows.
* **calculate_degree.R** calculates the indegree and outdegree of the LIONESS networks. 
* **read_and_print_networks.sh**, **combine_networks.sh** and **calculate_degree.sh** and wrappers for the matlb and r scripts with the same names and can be run from the command line.
* **read_combine_degree.sh** is a wrapper script that calls `read_and_print_networks.m`, `combine_networks.R` and `calculate_degree.R` in sequence.