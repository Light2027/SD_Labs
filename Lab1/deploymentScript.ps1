$resourceGroup = "SD_Labs"
$location = "westeurope"
$name = "Lab-1"
$templateFilePath = "azuredeploy.json"
$templateParameterFilePath = "azuredeploy.paramters.json"


New-AzResourceGroup -Name $resourceGroup -Location $location -Force


$Params = @{
    Name = $name
    ResourceGroupName = $resourceGroup
    TemplateFile = $templateFilePath
    TemplateParameterFile = $templateParameterFilePath
}
New-AzResourceGroupDeployment @Params