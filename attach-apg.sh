
az login --scope https://management.core.windows.net//.default

myResourceGroup='akstmp-RG'
myStandardPublicIP='cdlgatewaypubip'
gatewayname='cdlgatewayaks'
vnetname='spoke-VNet'
subnetname='gatewaysubnet'

# az network public-ip create -n $myStandardPublicIP -g $myResourceGroup \
# --allocation-method Static --sku Standard \


az network public-ip create \
    --resource-group $myResourceGroup \
    --name $myStandardPublicIP \
    --version IPv4 \
    --sku Standard \
    --allocation-method Static
    --zone 1 2 3

vnetname='spoke-VNet'
subnetname='gatewaysubnet2'
myResourceGroup='akstmp-RG'
az network vnet subnet create -n $subnetname --vnet-name $vnetname -g $myResourceGroup --address-prefixes "10.1.100.0/24"
# --nat-gateway MyNatGateway 

apgvnet='agpvnet'
subnetname='gatewaysubnet2'
myResourceGroup='akstmp-RG'
# az network vnet create -n $vnetname -g $myResourceGroup --address-prefix 10.100.0.0/16 --subnet-name $subnetname --subnet-prefix 10.1.200.0/24 

gatewayname='cdlapg'
myResourceGroup='akstmp-RG'
myStandardPublicIP='cdlgatewaypubip'
subnetname='gatewaysubnet'
vnetname='spoke-VNet'
az network application-gateway create -n $gatewayname -l westcentralus -g $myResourceGroup --sku Standard_v2 --public-ip-address $myStandardPublicIP --vnet-name $vnetname --subnet $subnetname --priority 100


##enable apg
gatewayname='cdlapg2'
myResourceGroup='akstmp-RG'
appgwId=$(az network application-gateway show -n $gatewayname -g $myResourceGroup -o tsv --query "id") 

aksname='akstmpaks'
az aks enable-addons -n $aksname -g $myResourceGroup -a ingress-appgw --appgw-id $appgwId





####
# creating the resource group
# az group create -n <resourcegroupname> -l <location>
#create public ip
myStandardPublicIP='cdlgatewaypubip2'
myResourceGroup='akstmp-RG'
az network public-ip create -n $myStandardPublicIP -g $myResourceGroup --allocation-method Static --sku Standard --zone 1 2 3
# create application gateway with WAF enabled. Standard_v2 WAF_v2

loclation='westcentralus'
subnetid='/subscriptions/ad54c4fb-f585-4033-9e5a-b119d74480b0/resourceGroups/akstmp-RG/providers/Microsoft.Network/virtualNetworks/hub-VNet/subnets/default'
az network application-gateway create -n $gatewayname -l $loclation -g $myResourceGroup --sku Standard_v2 --public-ip-address $myStandardPublicIP --subnet $subnetid --priority 100
# /subscriptions/<subscriptionid>/resourceGroups/<aksvnetresourcegroupname>/providers/Microsoft.Network/virtualNetworks/<vnetname>/Subnets/<subnetname>

#disabel
az aks disable-addons -a ingress-appgw -n akstmpaks -g akstmp-RG


myResourceGroup='akstmp-RG'
gatewayname='aksAppGateway'
appgwId=$(az network application-gateway show -n $gatewayname -g $myResourceGroup -o
myResourceGroup='akstmp-RG'
az aks enable-addons -n $aksname -g $myResourceGroup -a ingress-appgw --appgw-id $appgwId