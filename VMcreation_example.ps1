$Server = "eSight"               # VMName 
$ServerRAM = 32GB                     # Fixed memory = 32GB 
$VMLOC = "C:\HyperV"                  # VHD file directory
$Switch = "vSwitch"             # vSwitch name
$VHDdir=Split-Path -Parent $MyInvocation.InvocationName

# Create vSwitch
$net = Get-NetAdapter -Name 'LOM1' -ErrorAction Stop
New-VMSwitch -Name "vSwitch" -AllowManagementOS $True -NetAdapterName $net.Name -ErrorAction Stop

# create VM
mkdir $VMLOC -ErrorAction Stop
copy C:\OnsiteScript\contents\$Server.vhdx  $VMLOC -ErrorAction Stop
do
{
sleep -Seconds 30
}
while ("echo $?" -eq "False")
New-VM -Name $Server -Path $VMLOC -MemoryStartupBytes $ServerRAM -VHDPath $VMLOC\$Server.vhdx -SwitchName $Switch -Generation 2 -ErrorAction Stop

# Set vCores 
Set-VMProcessor -VMName $Server -Count 8 -ErrorAction Stop

# Set vTPM
New-HgsGuardian -Name "Guardian_eSight" -GenerateCertificates -ErrorAction Stop
$owner = Get-HgsGuardian Guardian_eSight 
$keypro = New-HgsKeyProtector -Owner $owner -AllowUntrustedRoot  
Set-VMKeyProtector -VMName $Server -KeyProtector $keypro.RawData -ErrorAction Stop
Enable-VMTPM -VMName $Server -ErrorAction Stop

# Start VM 
Start-VM $Server -ErrorAction Stop
