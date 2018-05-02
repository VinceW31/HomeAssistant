#!/usr/bin/python

import broadlink
import time
import re
import binascii

print('Scanning network for Broadlink devices (5s timeout) ... ')
devices = broadlink.discover(timeout=5)
print(('Found ' + str(len(devices )) + ' broadlink device(s)'))
time.sleep(1)
for index, item in enumerate(devices):
    devices[index].auth()
m = re.match(r"\('([0-9.]+)', ([0-9]+)", str(devices[index].host))
ipadd = m.group(1)
port = m.group(2)
macadd = str(''.join(format(x, '02x') for x in devices[index].mac[::-1]))
macadd = macadd[:2] + ":" + macadd[2:4] + ":" + macadd[4:6] + ":" + macadd[6:8] + ":" + macadd[8:10] + ":" + macadd[10:12]
print(('Device ' + str(index + 1) +':\nIPAddress = ' + ipadd + '\nPort = ' + port + '\nMACAddress = ' + macadd))

data = ["[General]","IPAddress = " + ipadd,"Port = " + port,"MACAddress = " + macadd,"Timeout = 30","[Commands]"]
with open("BlackBeanControl.ini", "w") as f:
    f.write('\n'.join(data))
print("BlackBean RM3 found and details stored sucessfully in BlackBeanControl.ini file")
