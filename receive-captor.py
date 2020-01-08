from urllib import request
import sys
import serial
import requests as rq
import time, io, json,datetime
import multiprocessing as mp
import paho.mqtt.client as mqtt

from influxdb import InfluxDBClient

# send serial message 
# Don't forget to establish the right serial port ******** ATTENTION
# SERIALPORT = "/dev/ttyUSB0"
SERIALPORT = "/dev/tty.usbserial-DA00G4XZ"
BAUDRATE = 9600
ser = serial.Serial()

last_timestamp=0

        

if len(sys.argv) > 1:
        SERIALPORT = "/dev/" + sys.argv[1]
else:
        SERIALPORT = "/dev/ttyS5"
ser=serial.Serial(SERIALPORT, 9600)

client = mqtt.Client()
client.connect("localhost",1883,60)
print("OK")

def send_server(queue):
        while True:
                val = queue.get()
                print(val)
                try:
                        d = json.loads(val)
                        
                        headers = {'Content-type': 'application/json', 'Accept': 'text/plain'}
                        r = rq.post("http://localhost:3001/fireInformation", val,headers=headers)
                        client.publish("topic/test", val)
                        print(r.text)
                except:
                        print("nok")


queue = mp.Queue()
p = mp.Process(target=send_server,args=(queue,))
p.start()

while(True):
        #time.sleep(1)
        #sio.flush() # it is buffering. required to get the data out *now*
        text = ser.readline()
        if(text):
                queue.put(text)


