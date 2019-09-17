from mpl_toolkits.basemap import Basemap

import numpy as np
import warnings
import matplotlib.cbook
import matplotlib.pyplot as plt
import re

def dms2dec(dms_str):
    """Return decimal representation of DMS

    >>> dms2dec(utf8(48°53'10.18"N))
    48.8866111111F
    >>> dms2dec(utf8(2°20'35.09"E))
    2.34330555556F
    >>> dms2dec(utf8(48°53'10.18"S))
    -48.8866111111F 
    >>> dms2dec(utf8(2°20'35.09"W))
    -2.34330555556F 
    """ 
    dms_str = re.sub(r'\s', '', dms_str)
    #print(dms_str) 
    sign = -1 if re.search('[swSW]', dms_str) else 1
    #print(sign) 
    numbers = list(filter(len, re.split('\D+', dms_str, maxsplit=4)))
    print(numbers)
    degree = numbers[0]
    minute = numbers[1] if len(numbers) >= 2 else '0'
    minutedecimal = numbers[2] if len(numbers) >= 3 else '0'
    return sign * (int(degree) + (float(minute) + (float(minutedecimal)/100)) / 60 + 0 / 3600)


warnings.filterwarnings("ignore",category=matplotlib.cbook.mplDeprecation)
fig = plt.figure(figsize=(8, 8))
m = Basemap(projection='gnom', resolution='h',
            width=3E5, height=3E5,
            lat_0=36.5, lon_0=-122.5,)
#m.etopo(scale=0.5, alpha=0.5)
m.fillcontinents(color="#FFDDCC", lake_color='#DDEEFF')
m.drawmapboundary(fill_color="#DDEEFF")
m.drawmapscale(lon=-121.65, lat=35.3, lon0=-121.5, lat0=35, length=100, fontsize = 14)
m.drawcoastlines()
parallels = np.arange(0.,91.,1.)
# labels = [left,right,top,bottom]
m.drawparallels(parallels,labels=[False,True,True,False])
meridians = np.arange(-360.,361,1.)
m.drawmeridians(meridians,labels=[True,False,False,True])

# Map (long, lat) to (x, y) for plotting
#Steve coords are in lat/lon. basemap needs long/lat
coords = {
"Bf201311": {"lat": 36.38472222, "lon": -122.6675},
"Bf201606": {"lat": 35.93222222, "lon": -122.9327778},
"Bf201706": {"lat": 35.93444444, "lon": -122.9269444},
"Bf201507": {"lat": 36.59888889, "lon": -122.1522222}
    }


#x, y = m(-122.3, 47.6)

for key in coords:
    lat=coords[key]["lat"]
    lon=coords[key]["lon"]
    xpt,ypt = m(lon,lat)
    print(xpt, ypt)
    m.plot(xpt, ypt, 'bo')
    xoffset = 2000
    yoffset = 2000
    if key == 'Bf201507': 
        plt.text(xpt-30000, ypt+1000, key)
    elif key == 'Bf201706':
        plt.text(xpt, ypt-10000, key)
    else:
        plt.text(xpt, ypt, key)
plt.savefig("samplemap.pdf")
