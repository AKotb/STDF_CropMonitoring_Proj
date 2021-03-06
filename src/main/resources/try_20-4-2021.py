import ee
import numpy as np
import time
import sys
import json
#from osgeo import gdal
#from osgeo import osr


# init the ee object
# ee.Initialize()

# Parse the arguments sent from request
args = (sys.argv)
polygonCoordinates = args[1]
polygonCoordinates = eval(polygonCoordinates)

# init the ee object
ee.Initialize()

# Define the roi
'''
area = ee.Geometry.Polygon([[105.4084512289977, 12.960956032145036], \
                            [105.46544280614614, 12.960956032145036], \
                            [105.46544280614614, 13.006454200439705], \
                            [105.4084512289977, 13.006454200439705], \
                            [105.4084512289977, 12.960956032145036]])
'''

area = ee.Geometry.Polygon(polygonCoordinates)

# define the image
collection = ee.ImageCollection("COPERNICUS/S2").filterBounds(area) \
    .filterDate("2018-01-01", "2019-01-10") \
    .filterMetadata("CLOUDY_PIXEL_PERCENTAGE", "less_than", 10) \
    .select(['B8', 'B4'])

print(" number of image: ", collection.size().getInfo())


# perform any calculation on the image collection here
def anyFunction(img):
    ndvi = ee.Image(img.normalizedDifference(['B8', 'B4'])).rename(["ndvi"])
    return ndvi


# export the latitude, longitude and array
def LatLonImg(img):
    img = img.addBands(ee.Image.pixelLonLat())

    img = img.reduceRegion(reducer=ee.Reducer.toList(), \
                           geometry=area, \
                           maxPixels=1e13, \
                           scale=10);

    data = np.array((ee.Array(img.get("result")).getInfo()))
    lats = np.array((ee.Array(img.get("latitude")).getInfo()))
    lons = np.array((ee.Array(img.get("longitude")).getInfo()))
    return lats, lons, data

# export ndvi statistics( as min, max, & avg)
def get_ndvi_stats(img):
    img = img.addBands(ee.Image.pixelLonLat())

    img = img.reduceRegion(reducer=ee.Reducer.toList(), \
                           geometry=area, \
                           maxPixels=1e13, \
                           scale=10);

    data = np.array((ee.Array(img.get("result")).getInfo()))
    return np.min(data), np.max(data), np.mean(data)


# covert the lat, lon and array into an image
def toImage(lats, lons, data):
    # get the unique coordinates
    uniqueLats = np.unique(lats)
    uniqueLons = np.unique(lons)

    # get number of columns and rows from coordinates
    ncols = len(uniqueLons)
    nrows = len(uniqueLats)

    # determine pixelsizes
    ys = uniqueLats[1] - uniqueLats[0]
    xs = uniqueLons[1] - uniqueLons[0]

    # create an array with dimensions of image
    arr = np.zeros([nrows, ncols], np.float32)  # -9999

    # fill the array with values
    counter = 0
    for y in range(0, len(arr), 1):
        for x in range(0, len(arr[0]), 1):
            if lats[counter] == uniqueLats[y] and lons[counter] == uniqueLons[x] and counter < len(lats) - 1:
                counter += 1
                arr[len(uniqueLats) - 1 - y, x] = data[counter]  # we start from lower left corner
    return arr


# map over the image collection
myCollection = collection.map(anyFunction)

abc = myCollection.toList(collection.size().getInfo(), 0)
print("------------", type(abc.get(5)))
# get the median
result = ee.Image(myCollection.median()).rename(['result'])

# get the lon, lat and result as 1d array
lat, lon, data = LatLonImg(result)

# 1d to 2d array
image = toImage(lat, lon, data)
print('type:::: ', image.shape)
# in case you want to plot the image
import matplotlib.pyplot as plt

plt.imshow(image)
plt.show()
#plt.plot()
#plt.savefig('C:/Program Files/apache-tomcat-8.5.64/stdf_generated_output_files/saved_figure.png')
print('NDVI Image Generated!')
