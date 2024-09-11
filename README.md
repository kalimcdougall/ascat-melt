# ascat-melt

## ASCAT melt detection

This collection of Python and bash scripts was used to create a binary melt product from ASCAT .sir imagery. This product is being created for major ice shelves around Antarctica and will be submitted to Scientific Data for publication later this year. 

The scripts use the Advanced Scatterometer (ASCAT) Enhanced Resolution products available from the [Scatterometer Climate Record Pathfinder](https://www.scp.byu.edu/).

Scripts are provided for the following procedures:
- Download data from BYU via ftp
- Convert .sir files to netCDFs (requires sir2nc C program from BYU)
- Clip netCDFs by study region shapefile
- Calculate melt threshold and perform melt detection

<img src="./melt_gif.gif" width="70%" height="70%"/>

### References
Ashcroft, I. & Long, D. (2006). Comparison of methods for melt detection over Greenland using active and passive microwave measurements. *International Journal of Remote Sensing, 27*(12), 2469-2488. doi:[10.1080/01431160500534465](https://doi.org/10.1080/01431160500534465)
