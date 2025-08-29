# AnyKernel3 Ramdisk Mod Script
properties() { '
kernel.string=ZFold3 SukiSU Ultra + SUSFS
do.devicecheck=1
device.name1=f926b
device.name2=SM-F926B
'; }
block=auto
is_slot_device=auto
do.systemless=1
do.modules=0
do.cleanup=1
do.cleanuponabort=1

# Kernel image path
kernel=Image.gz-dtb
