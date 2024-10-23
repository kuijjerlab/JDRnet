#!/bin/bash
# bulk gene expression and metadata downloaded from GEPliver on 01.03.2024
# http://www.gepliver.org/#/download 
# this includes multiple kinds of carcinoma
# datasets with survival data available were downloaded, excluding TCGA data

# creating data directory
mkdir raw_data
cd raw_data

# downloading data
wget http://47.253.10.109:9003/gepLiver/tool/downloadFile?fileName=Download/Human%20Bulk/expr/Bulk15_expr.txt
wget http://47.253.10.109:9003/gepLiver/tool/downloadFile?fileName=Download/Human%20Bulk/meta/Bulk15_meta.txt
wget http://47.253.10.109:9003/gepLiver/tool/downloadFile?fileName=Download/Human%20Bulk/expr/Bulk21_expr.txt
wget http://47.253.10.109:9003/gepLiver/tool/downloadFile?fileName=Download/Human%20Bulk/meta/Bulk21_meta.txt
wget http://47.253.10.109:9003/gepLiver/tool/downloadFile?fileName=Download/Human%20Bulk/expr/Bulk23_expr.txt
wget http://47.253.10.109:9003/gepLiver/tool/downloadFile?fileName=Download/Human%20Bulk/meta/Bulk23_meta.txt
wget http://47.253.10.109:9003/gepLiver/tool/downloadFile?fileName=Download/Human%20Bulk/expr/Bulk26_expr.txt
wget http://47.253.10.109:9003/gepLiver/tool/downloadFile?fileName=Download/Human%20Bulk/meta/Bulk26_meta.txt
wget http://47.253.10.109:9003/gepLiver/tool/downloadFile?fileName=Download/Human%20Bulk/expr/Bulk19_expr.txt
wget http://47.253.10.109:9003/gepLiver/tool/downloadFile?fileName=Download/Human%20Bulk/meta/Bulk19_meta.txt