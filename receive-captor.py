from urllib import request
import sys
import serial
import requests as rq
import time, io, json

# send serial message 
# Don't forget to establish the right serial port ******** ATTENTION
# SERIALPORT = "/dev/ttyUSB0"
SERIALPORT = "/dev/tty.usbserial-DA00G4XZ"
BAUDRATE = 9600
ser = serial.Serial()
sio = io.TextIOWrapper(io.BufferedRWPair(ser, ser))
last_timestamp=0
def initUART():       
    # ser = serial.Serial(SERIALPORT, BAUDRATE)
    ser.port=SERIALPORT
    ser.baudrate=BAUDRATE
    ser.bytesize = serial.EIGHTBITS #number of bits per bytes
    ser.parity = serial.PARITY_NONE #set parity check: no parity
    ser.stopbits = serial.STOPBITS_ONE #number of stop bits
    ser.timeout = None          #block read

    # ser.timeout = 0             #non-block read
    # ser.timeout = 2              #timeout block read
    ser.xonxoff = False     #disable software flow control
    ser.rtscts = False     #disable hardware (RTS/CTS) flow control
    ser.dsrdtr = False       #disable hardware (DSR/DTR) flow control
    #ser.writeTimeout = 0     #timeout for write
    
    print ("Starting Up Serial Monitor")
    try:
            ser.open()
    except serial.SerialException:
            print("Serial {} port not available".format(SERIALPORT))
            exit()
if len(sys.argv) > 1:
        SERIALPORT = "/dev/" + sys.argv[1]
else:
        SERIALPORT = "/dev/ttyS5"
#initUART()


r = rq.post("http://localhost:3000/fireInformation", json={"x": 0,"y":0,"i":0})
print(r.text)

