import xarray as xr
import os
import geopandas as gpd
import rasterio
from shapely.geometry import mapping

dir = '/directory/path/'

data = xr.open_dataset(dir + 'filename.nc')

#%%
# Clip merged ASCAT files by shapefile
sigma0 = data.Sigma0

shapefile = dir + 'shapefile.shp'
shape = gpd.read_file(shapefile)

sigma0.rio.set_spatial_dims(x_dim='x', y_dim='y', inplace=True)
sigma0.rio.write_crs('epsg:3031', inplace=True) # Define CRS to write sigma0 to

vars_list = list(data)   
del sigma0.attrs['grid_mapping'] # Delete grid_mapping variable - not sure why this is an issue

clip_sigma0 = sigma0.rio.clip(shape.geometry.apply(mapping), shape.crs, drop=False) # Clip

# Export file as netCDF
filename = dir + 'clip_sigma0.nc'
if os.path.exists(filename):
    os.remove(filename) # Delete the file if it exists
clip_sigma0.to_netcdf(path=filename)
