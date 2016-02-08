# kxcjk_1013
fork of kernel module kxcjk_1013 with 1 device id added specially for Cube i7 Stylus, prepared for dkms build

## Installation
- install packages: `dkms` and `linux-headers-generic` (or one for your kernel)
- clone this repository somewhere or download its contents as archive and unpack it
- copy code to `/usr/src/kxcjk-1013-0.1`: `sudo cp -r kxcjk-1013 /usr/src/kxcjk-1013-0.1`
- add, build and install module using dkms:
 - `sudo dkms add -m kxcjk-1013 -v 0.1`
 - `sudo dkms install -m kxcjk-1013 -v 0.1`
- from now you should have working accelerometer, avaliable at `/sys/bus/iio/devices/iio\:device*` (e.g. `/sys/bus/iio/devices/iio\:device0`)