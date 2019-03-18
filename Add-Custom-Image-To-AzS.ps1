#需要先使用Powershell连接到Azure Stack
#以下仅是windows的示例，linux的示例请到
#“https://docs.microsoft.com/en-us/azure/azure-stack/azure-stack-add-vm-image#add-a-custom-vm-image-to-the-marketplace-by-using-powershell”中查看
Add-AzsPlatformimage -publisher "Microsoft" `
 -offer "WindowsServer" `
 -sku "Datacenter2016" `
 -version "1.0.0” `
 -OSType "Windows" `
 -OSUri "https://vhdwinser2016.blob.shenzhen.perftest.azurestack.external/vhdwinser2016/windowsserver2016.vhd"
