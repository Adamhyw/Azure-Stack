#如果不确定以下参数该填什么，请先使用get-AzSPlatformImage查询
Remove-AzsPlatformImage -Publisher "Microsoft" `
-Offer "WindowsServer" `
-sku "Datacenter2016" `
-version "1.0.0" `
-location "shenzhen"
