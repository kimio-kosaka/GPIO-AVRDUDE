#!/bin/sh
echo "Restore Arduio IDE AVRDUDE"
echo ""
avrdude_path=~/Applications/arduino/hardware/tools/avr/bin

if [ ! -e $avrdude_path ]; then
 echo not found: $avrdude_path
 echo "Abort restore"
 exit 1
fi

if [ ! -e $avrdude_path/avrdude.org ]; then
 echo "GPIO-AVRDUDE is not Installed"
 echo "Already you are using Arduino IDE AVRDUDE"
 exit 0
else
 cd $avrdude_path
 sudo rm avrdude
 sudo mv avrdude.org avrdude
 cd ../etc
 sudo rm avrdude.conf
 sudo mv avrdude.conf.org avrdude.conf
 echo "sudo apt-get -y purge avrdude"
 sudo apt-get -y purge avrdude
 if [ -e /etc/avrdude.conf ]; then
   sudo rm /etc/avrdude.conf
 fi
 cd
 echo "done"
 exit 0
fi
