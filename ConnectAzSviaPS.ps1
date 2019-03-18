    #以下为AAD模式登陆方法，ADFS请到“https://docs.microsoft.com/en-us/azure/azure-stack/azure-stack-powershell-configure-admin”查询
    
    $EnvironmentName="Please input a name you want"
    $ArmEndpointName="https://adminmanagement.<region>.<FQDN>"
    # Register an Azure Resource Manager environment that targets your Azure Stack instance. Get your Azure Resource Manager endpoint value from your service provider.
    Add-AzureRMEnvironment -Name $EnvironmentName -ArmEndpoint $ArmEndpointName

    # Set your tenant name
    $AuthEndpoint = (Get-AzureRmEnvironment -Name $EnvironmentName).ActiveDirectoryAuthority.TrimEnd('/')
    $AADTenantName = "<Tenantname>.onmicrosoft.com"
    $TenantId = (invoke-restmethod "$($AuthEndpoint)/$($AADTenantName)/.well-known/openid-configuration").issuer.TrimEnd('/').Split('/')[-1]

    # After signing in to your environment, Azure Stack cmdlets
    # can be easily targeted at your Azure Stack instance.
    Add-AzureRmAccount -EnvironmentName $EnvironmentName -TenantId $TenantId
