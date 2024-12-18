# Installation guide

This is a quick installation guide for the container that can be used to reproduce the analysis in Pop, et al., 2024. This is an Apptainer container (formerly singularity) and requires a Linux system to be able to install apptainer.

1. Install Apptainer https://apptainer.org/docs/user/main/quick_start.html#installation.
2. Download the container files.
3. Build the container:
    ```apptainer build apptainer_JDRnet_2024.sif apptainer_JDRnet_2024.def```
4. Run the container
   ```apptainer exec -B /folder/to/bind apptainer_JDRnet_2024.sif  jupyter notebook --NotebookApp.allow_origin='*' --NotebookApp.ip='127.0.0.1' --no-browser```

***Note: /folder/to/bind should be the path to the directory containing all the data & notebooks needed as you will only be able to access this folder from within the container.***

This should give you the option to open Jupyter Lab in your browser. Open the notebook you wish to run. You will have to set the correct kernel. To do so, from the menu bar, select ```Kernel > Change kernel``` and select the R kernel. You should now be able to run the notebook. For a quick guide to using Jupyter notebooks in Jupyter lab, see `Jupyter_notebook_guide.html`. 