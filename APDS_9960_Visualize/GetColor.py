from apds9960.const import *
from apds9960 import APDS9960
import RPi.GPIO as GPIO
import smbus
from time import sleep
from socket import socket, AF_INET, SOCK_DGRAM

PORT = 5000
ADDRESS = "MainPC.local" # please input your targetIP
s = socket(AF_INET, SOCK_DGRAM)

port = 1
bus = smbus.SMBus(port)

apds = APDS9960(bus)

try:
    apds.enableLightSensor()
    oval = -1
    print("LoggingStart")
    while True:
        sleep(0.1)
        print("RedLight={}".format(apds.readRedLight()))
        print("GreenLight={}".format(apds.readGreenLight()))
        print("BlueLight={}".format(apds.readBlueLight()))
        data = str(apds.readRedLight())+','+str(apds.readGreenLight())+','+str(apds.readBlueLight())
        #print(data)
        s.sendto(data.encode(), (ADDRESS, PORT))

finally:
    GPIO.cleanup()
    print ("Bye") 