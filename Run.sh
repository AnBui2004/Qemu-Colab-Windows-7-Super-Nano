sudo apt-get update && apt-get install qemu -y
sudo apt install qemu-utils -y
sudo apt install qemu-system-x86-xen -y
sudo apt install qemu-system-x86 -y
qemu-img create -f raw windows7nano.img 64G
wget -O RTL8139F.iso 'https://www.dropbox.com/s/v1yyj5i1ao3rtq3/RTL8139F.iso?dl=0https://www.dropbox.com/s/v1yyj5i1ao3rtq3/RTL8139F.iso?dl=1'
wget -O windows7_super-nano_lite.iso 'https://www.dropbox.com/s/ic413pf6x8eheu6/windows7_super-nano_lite.iso?dl=1'

curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p'
sudo qemu-system-x86_64 \
  -m 8G \
  -cpu EPYC \
  -boot order=d \
  -drive file=windows7_super-nano_lite.iso,media=cdrom \
  -drive file=windows7nano.img,format=raw \
  -drive file=RTL8139F.iso,media=cdrom \
  -device usb-ehci,id=usb,bus=pci.0,addr=0x4 \
  -device usb-tablet \
  -vnc :0 \
  -cpu core2duo \
  -smp cores=2 \
  -device rtl8139,netdev=n0 -netdev user,id=n0 \
  -accel tcg,thread=multi \
