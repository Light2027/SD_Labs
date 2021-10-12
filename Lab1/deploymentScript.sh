#!/bin/bash
echo "Creating Resource Group"
resourceGroupName=SD_Labs
location=westeurope
az group create --location $location --name $resourceGroupName #--debug

echo "Creating deployment group"
deploymentName=Lab-1
templateFileName=azuredeploy.json
parameterFileName='@azuredeploy.parameters.json'
webAppName=myWebApp875
az deployment group create \
  --name $deploymentName \
  --resource-group $resourceGroupName \
  --template-file $templateFileName \
  --parameters $parameterFileName \
  --parameters "webAppName=$webAppName" #--debug # This is passed in here as source control magically does not work as resource...

echo "Deploying web app from github"
gitrepo=https://github.com/Light2027/Node.JS_HelloWorld_Azure_CI
branch=main
az webapp deployment source config \
--name $webAppName \
--resource-group $resourceGroupName \
--repo-url $gitrepo --branch $branch --manual-integration #--debug