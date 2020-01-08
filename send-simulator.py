
import sys
import serial
import urllib.request, json
import time

# send serial message 
# Don't forget to establish the right serial port ******** ATTENTION
# SERIALPORT = "/dev/ttyUSB0"

last_timestamp=0
       

def sendUARTMessage(msg):
    print("Message <" + msg + "> sent to micro-controller." )
    ser.write(msg.encode())
    ser.flush()

if len(sys.argv) > 1:
        SERIALPORT = "/dev/" + sys.argv[1]
else:
        SERIALPORT = "/dev/ttyS5"
BAUDRATE = 9600
ser = serial.Serial(SERIALPORT,BAUDRATE)
while(True):
        actualTime = int(time.time()) 
        print(last_timestamp)
        with urllib.request.urlopen("http://localhost:3000/fire/"+str(last_timestamp)) as url:
        #with urllib.request.urlopen("localhost:3000/fire/"+str(int(time.time()))) as url:
                
                last_timestamp = actualTime
                data = json.loads(url.read().decode())
                print(data)
                for i in range(0,len(data)):
                        time.sleep(0.5)
                        sendUARTMessage(json.dumps(data[i])+"\n\r")
        time.sleep(5)

     
