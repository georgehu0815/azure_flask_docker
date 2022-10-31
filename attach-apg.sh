


myResourceGroup='akstmp-RG'
myStandardPublicIP='cdlgatewaypubip'
gatewayname='cdlgatewayaks'
vnetname='spoke-VNet'
subnetname='gatewaysubnet'

az network public-ip create -n $myStandardPublicIP -g $myResourceGroup --allocation-method Static --sku Standard

# az network public-ip create \
#     --resource-group $myResourceGroup \
#     --name $myStandardPublicIP \
#     --version IPv4 \
#     --sku Basic \
#     --allocation-method Static

az network vnet subnet create -n $subnetname --vnet-name $vnetname -g $myResourceGroup \
--address-prefixes "10.1.3.0/24"
# --nat-gateway MyNatGateway 

# az network vnet create -n myVnet -g myResourceGroup --address-prefix 10.0.0.0/16 --subnet-name $subnetname --subnet-prefix 10.1.3.0/24 

az network application-gateway create -n $gatewayname -l westcentralus -g $myResourceGroup \
--sku Standard_v2 --public-ip-address $myStandardPublicIP \
--vnet-name myVnet --subnet $subnetname --priority 100