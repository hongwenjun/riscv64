English | [简体中文](./README_zh.md)

## Milkv-duo image contains Python 3.9.5 and pip3 nano htop vim tmux screen neofetch git gdb
### milkv-duo-20230910-0623.img.7z 37.8 MB (39,688,017 bytes)
- Download: https://github.com/hongwenjun/riscv64/tree/main/milkv-duo

## Milkv Duo installs the pinpong library and lights up the blue LED light
- Download the pinpong library for Milkv Duo pinpong.zip

- This pinpong package is extracted from the official `milkv-duo-v1.0.4-2023-0908.img.zip`. If you use the official image, you can use it directly without installation.

### Use the scp command to upload the compressed package
```
scp pinpong.zip root@192.168.42.1:~
```
### Unzip, install and test on Milkv Duo. The site-packages directory will be different in different python versions. Here is python3.9
```
unzip -q pinpong.zip
cp -r pinpong /usr/lib/python3.9/site-packages/
cp -r serial /usr/lib/python3.9/site-packages/
python -c 'import pinpong'
```

### View the duo_res resource definition, such as the pin definition of the blue LED
```
less /usr/lib/python3.9/site-packages/pinpong/extension/milkvDuo.py
```

### `vi blink.py` Add the following content and use python3 blink.py to test
```
import time
from pinpong.board import Board,Pin

# Initialize, select the board type, if you do not enter the board type, it will be automatically recognized.
Board("MILKV-DUO").begin() 

# The pin is initialized as level output
led = Pin(Pin.D0, Pin.OUT) 

while True:
   led.value(1) #Output high level
   print("1") #Terminal print information
   time.sleep(1) #Wait for 1 second to maintain the state

   led.value(0) #Output low level
   print("0") #Terminal print information
   time.sleep(1) #Wait for 1 second to maintain the state
```

## milkv-duo-tinycc.zip 8.70 MB (9,131,348 bytes)
- C language compiler that can be run on the milkv-duo development board

## `simple_http_server.py` Simple HTTP Server With Upload.
This module builds on BaseHTTPServer by implementing the standard GET and HEAD requests in a fairly straightforward manner.

## Milkv-duo compilation image adds Python Pip3 Nano vim tmux and more software animation demonstration

![](https://github.com/hongwenjun/riscv64/blob/main/img/milkv_duo_musl_riscv64_defconfig.gif)

### Refer to the picture above and use the make menuconfig command to add software packages
```
cd /root/duo-buildroot-sdk/buildroot-2021.05
make milkv_duo_musl_riscv64_defconfig
make menuconfig
```

### Save the file as `configs/milkv_duo_musl_riscv64_defconfig`
- Can be copied and pasted into the window


### Finally execute the one-click compilation script build_milkv.sh
```
./build_milkv.sh
```
