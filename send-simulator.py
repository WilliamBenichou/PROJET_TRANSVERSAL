
import sys
import serial
import urllib.request, json
import time

# send serial message 
# Don't forget to establish the right serial port ******** ATTENTION
# SERIALPORT = "/dev/ttyUSB0"
SERIALPORT = "/dev/tty.usbserial-DA00G4XZ"
BAUDRATE = 115200
ser = serial.Serial()
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
       

def sendUARTMessage(msg):
    #ser.write(msg.encode())
    print("Message <" + msg + "> sent to micro-controller." )
if len(sys.argv) > 1:
        SERIALPORT = "/dev/" + sys.argv[1]
else:
        SERIALPORT = "/dev/ttyS5"
#initUART()

while(True):
        time.sleep(5)
        actualTime = int(time.time()) 
        print(last_timestamp)
        with urllib.request.urlopen("http://localhost:3000/fire/"+str(last_timestamp)) as url:
        #with urllib.request.urlopen("localhost:3000/fire/"+str(int(time.time()))) as url:
                last_timestamp = actualTime
                data = json.loads(url.read().decode())
                for i in range(0,len(data)):
                        sendUARTMessage(json.dumps(data[i]))

     
