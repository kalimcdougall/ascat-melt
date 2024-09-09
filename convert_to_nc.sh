#!/bin/bash

# Convert .sir files to .sir.nc files
for file in *.sir; do
    ./sir2nc "$file"
done

# Modify attributes in .sir.nc files and copy them to new files
for file in *.sir.nc; do
    output_file="${file%.sir.nc}_copy.nc"
    cp "$file" "$output_file"
    ncatted -O -a grid_mapping,Sigma0,o,c,crs "$output_file"
    ncatted -O -a long_name,Sigma0,o,c,'V-pol Sigma0' "$output_file"
done

# Merge the modified .sir.nc files
cdo mergetime *_copy.nc merged_nc_files.nc
