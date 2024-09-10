import numpy as np
import netCDF4 as nc

dir = '/directory/path/'

ds = nc.Dataset(dir + 'clip_sigma0.nc')
clip_sigma0 = ds.variables['clip_sigma0']

# Calculate the previous winter (Jun 1 - Aug 31) mean - for melt binary variable
winter_mean = np.mean(clip_sigma0[:91], axis=0) # Define index range of winter dates

#%%
# Apply NaN mask to melt_binary values before writing to netCDF variable
# Otherwise, NaN values will be assigned a fill value of -2147483648 which must be removed before plotting

melt_binary = np.where(np.isnan(clip_sigma0), np.nan, np.where(clip_sigma0 < winter_mean - 2.7, 1, 0))

data['melt_binary'] = (('time', 'y', 'x'), melt_binary)
data['melt_binary'].attrs['long_name'] = 'Melt binary'
data['melt_binary'].attrs['units'] = 'boolean'

#%%
# Export file as netCDF
melt = data.melt_binary
output_file = dir + 'melt_binary.nc'
melt.to_netcdf(output_file)
