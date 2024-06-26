#!/usr/bin/env bash

name="python-flask-mr"
location="switzerlandnorth"
environment="dev"
rand="001"
postfix="$name-$environment-$rand"
resourceGroup="rg-$postfix"
appservicePlanName="asp-$postfix"
appserviceName="app-$postfix"
tags="environment=$environment division=id subDivision=idsys"

# Create a resource group
# if ! az group show --name "$resourceGroup" &>/dev/null; then
az group create \
  --name "$resourceGroup" \
  --location $location \
  --tags $tags
# fi

# Create an App Service plan
az appservice plan create \
  --name "$appservicePlanName" \
  --resource-group "$resourceGroup" \
  --sku B1 \
  --is-linux \
  --location $location

# Create an App Service plan
az webapp up \
  --resource-group "$resourceGroup" \
  --name "$appserviceName" \
  --plan "$appservicePlanName" \
  --runtime PYTHON:3.11 \
  --logs \
  -l $location
