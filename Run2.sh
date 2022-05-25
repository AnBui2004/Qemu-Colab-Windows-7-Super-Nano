sudo apt-get update && apt-get install qemu -y
sudo apt install qemu-utils -y
sudo apt install qemu-system-x86-xen -y
sudo apt install qemu-system-x86 -y
qemu-img create -f raw windows7nano.img 64G
wget -O RTL8139F.iso 'https://zoydyw.bn.files.1drv.com/y4mQQI3UjoImJ_tKf4sMyOzxK84q-gSggnjanUix8yyKEm8i8o7olu8_Pa0ErbpE_U29DvLyMiuvRx1zWAxdbWlGQP11_hQdTYuXnRZjq8O29Jx_OeVvvn_TneuwXREVJRGF5vxmGRP6OMHcaHu1MM8_PURTgIRd_9IQnOudymE5us0rK6zKa6bz6Q2O35QnV_ItSajaGUvu_sCu2OBIAKsbw'
wget -O windows7_super-nano_lite.iso 'https://afuqbq.bn.files.1drv.com/y4myuZ3xUSxcdP1JCTnDlbtjdxk6LXtD7UKbYtTXq5JD3zmv7zP5a9sLbpVv7tb0qV2j5iFbHULsSQDbWWsYtIw2y-2sb_P_tfiCP6T0D7_Si-c0bT9Dza-9GJ_o-OnK-sYZIhE_X83w09gOBTiVqnX6xitny_r6nJ27SqDVGh1-8QhLL9-HCKQVJKuHf3lPIfrjiort_xkjzeJQIHPfN1-oQ'

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
