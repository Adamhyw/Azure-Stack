#1. 在hyper-V中创建虚拟磁盘VHD
#自行选择VHD保存位置
$vhdpath = "C:\VHDs\Test.vhd"
$vhdsize = 127GB
New-VHD -Path $vhdpath -SizeBytes $vhdsize

#2. 创建Generation1的虚拟机，挂载第一步的虚拟磁盘，并安装操作系统
#自定义虚拟机名称，文件保存位置，内存大小和系统镜像位置
$Server = "define VM name"
$VMLOC = "VM files location"
$ServerRAM = "Memory Size"
$ISOpath = "ISO image location"
New-VM -Name $Server -Path $VMLOC -MemoryStartupBytes $ServerRAM -VHDPath $vhdpath -Generation 1 -ErrorAction Stop
Add-VMDvdDrive -VMName $Server -Path $ISOpath

#打开Hyper-V安装操作系统，完成请关机
