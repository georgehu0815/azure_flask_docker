#get all pod
kubectl get pods --all-namespaces
#show deployed pod
kubectl  port-forward flaskapplinux-5b79bf4bd4-pnn7s  5000:5000
curl 127.0.0.1:5000
