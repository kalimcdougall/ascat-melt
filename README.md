**ASCAT melt detection**

These scripts create a melt product from ASCAT .sir imagery. Includes the following scripts:
- Download data from BYU via ftp
- Convert .sir files to netCDFs (requires sir2nc C program from BYU)
- Clip netCDFs by study region shapefile
- Calculate melt threshold and perform melt detection
