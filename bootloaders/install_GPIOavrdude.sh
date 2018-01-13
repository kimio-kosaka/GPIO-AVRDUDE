#!/bin/sh
echo "Install GPIO AVRDUDE"
echo ""

avrdude_path=~/Applications/arduino/hardware/tools/avr/bin

if [ -e $avrdude_path/avrdude.org ]; then
  echo "found: $avrdude_path/avrdude.org"
  echo "Already GPIO-AVRDUDE is installed."
  exit 0
fi

if [ ! -e $avrdude_path/avrdude ]; then
  echo "not found: $avrdude_path/avrdude"
  echo "Abort install"
  exit 1
fi

  echo "sudo apt-get -y install avrdude"
  sudo apt-get -y install avrdude
  sudo chown root:root /usr/bin/avrdude
  sudo chmod +s /usr/bin/avrdude

  sudo chmod 666 /etc/avrdude.conf
  echo 'programmer' >> /etc/avrdude.conf
  echo '  id    = "linuxgpio";' >> /etc/avrdude.conf
  echo '  desc  = "Use the Linux sysfs interface to bitbang GPIO lines";' >> /etc/avrdude.conf
  echo '  type  = "linuxgpio";' >> /etc/avrdude.conf
  echo '  mosi  = 18;' >> /etc/avrdude.conf
  echo '  miso  = 23;' >> /etc/avrdude.conf
  echo '  sck   = 24;' >> /etc/avrdude.conf
  echo '  reset = 25;' >> /etc/avrdude.conf
  echo ';' >> /etc/avrdude.conf
  sudo chmod 644 /etc/avrdude.conf

  cd ~/Applications/arduino/hardware/tools/avr/bin/
  sudo mv avrdude avrdude.org
  sudo ln -s /usr/bin/avrdude ./avrdude
  cd ../etc/
  sudo mv avrdude.conf avrdude.conf.org
  sudo ln -s /etc/avrdude.conf ./avrdude.conf
  cd ~/Applications/arduino/hardware/arduino/avr/
  sed -e 's/bootloader.unlock_bits=0x3F/bootloader.unlock_bits=0xFF/g' boards.txt |\
  sed 's/bootloader.lock_bits=0x0F/bootloader.lock_bits=0xCF/g' |\
  sed 's/bootloader.lock_bits=0x2F/bootloader.lock_bits=0xEF/g' >boards.txt.new
  mv boards.txt boards.txt.org
  mv boards.txt.new boards.txt 
  cd
  echo "done"
