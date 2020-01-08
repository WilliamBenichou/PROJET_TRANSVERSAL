
import paho.mqtt.client as mqtt
import datetime
import time,json
from influxdb import InfluxDBClient
# This is the Subscriber

def on_connect(client, userdata, flags, rc):
  print("Connected with result code "+str(rc))
  client.subscribe("topic/test")

def on_message(client, userdata, msg):
    receiveTime=datetime.datetime.utcnow()
    print(msg.topic,msg.payload.decode())
    j= json.loads(msg.payload.decode())
    bd_body = [
        {
            "measurement": "fire",
            "time": receiveTime,
            "fields": {
                "value": j['i'],
                "sensor":j['id']
            }
        }
    ]

    print(bd_body)
    dbclient.write_points(bd_body)
    print("Finished writing to InfluxDB")
dbclient = InfluxDBClient('localhost', 8086, 'root', 'root', 'sensordata')
client = mqtt.Client()
client.connect("localhost",1883)

client.on_connect = on_connect
client.on_message = on_message
print("fin")
client.loop_forever()