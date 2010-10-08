import subprocess
import re


a = subprocess.Popen(
    ['/usr/sbin/ioreg', '-l'],
    stdout=subprocess.PIPE,
    stderr=subprocess.PIPE,
)
data = a.communicate()
data = data[0].split('\n')

datum = None
for datum in data:
    if 'BatteryPercent' in datum:
        break

if datum is not None:
    bits = datum.split(' = ')
    try:
        print bits[1]
    except IndexError:
        print 'N/A'
    