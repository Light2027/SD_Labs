#!/bin/bash
echo "Creating Resource Group"
resourceGroupName=SD_Labs
az group create --location westeurope --name $resourceGroupName

echo "Creating deployment group"
deploymentName=Lab-1
templateFileName=azuredeploy.json
parameterFileName='@azuredeploy.parameters.json'
az deployment group create \
  --name $deploymentName \
  --resource-group $resourceGroupName \
  --template-file $templateFileName \
  --parameters $parameterFileName

echo "Deploying web app from github"
webappname=myWebApp875
gitrepo=https://github.com/Light2027/Node.JS_HelloWorld_Azure_CI
branch=main
az webapp deployment source config --name $webappname --resource-group $resourceGroupName \
--repo-url $gitrepo --branch $branch --manual-integration