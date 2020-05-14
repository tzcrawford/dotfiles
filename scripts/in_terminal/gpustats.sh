#!/bin/sh
#Prints information about GPU usage
#VLOAD is the percent of cores being utilized (I think)
#VRAMRAT is the percent of VRAM being utilized
#VLOAD=$(sudo cat /sys/kernel/debug/dri/0/amdgpu_pm_info | grep "GPU Load:" | sed -e 's/GPU Load: //' | sed -e 's/ //')
USEDVRAM=$(sudo cat /sys/kernel/debug/dri/0/amdgpu_vram_mm | grep "total:" | sed -e 's/,//' | cut -d ' ' -f 4)
TOTALVRAM=$(sudo cat /sys/kernel/debug/dri/0/amdgpu_vram_mm | grep "total:" | sed -e 's/,//' | cut -d ' ' -f 2)
#echo $VLOAD
#echo $USEDVRAM
#echo $TOTALVRAM
VRAMRAT=$(bc -l <<< "scale=1;100*$USEDVRAM/$TOTALVRAM" | sed 's/$/%/')
echo $VRAMRAT
#echo $VLOAD $VRAMRAT
