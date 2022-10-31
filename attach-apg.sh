
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
subnetname='gatewaysubnet'
myResourceGroup='akstmp-RG'
az network vnet subnet create -n $subnetname --vnet-name $vnetname -g $myResourceGroup --address-prefixes "10.1.100.0/24"
# --nat-gateway MyNatGateway 

apgvnet='agpvnet'
subnetname='gatewaysubnet2'
myResourceGroup='akstmp-RG'
az network vnet create -n $vnetname -g $myResourceGroup --address-prefix 10.100.0.0/16 --subnet-name $subnetname --subnet-prefix 10.1.200.0/24 

gatewayname='cdlapg2'
myResourceGroup='akstmp-RG'
myStandardPublicIP='cdlgatewaypubip'
subnetname='gatewaysubnet2'
vnetname='spoke-VNet'
az network application-gateway create -n $gatewayname -l westcentralus -g $myResourceGroup --sku Standard_v2 --public-ip-address $myStandardPublicIP --vnet-name $vnetname --subnet $subnetname --priority 100


##enable apg
gatewayname='cdlapg2'
myResourceGroup='akstmp-RG'
appgwId=$(az network application-gateway show -n $gatewayname -g $myResourceGroup -o tsv --query "id") 

aksname='akstmpaks'
az aks enable-addons -n $aksname -g $myResourceGroup -a ingress-appgw --appgw-id $appgwId