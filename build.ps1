git clone https://github.com/georgehu0815/azure_flask_docker.git flaskapp
cd flaskapp
sudo docker build -t udgtgmay2gwjiacr.azurecr.io/flaskapp:1.0 -f Dockerfile  .
sudo docker push udgtgmay2gwjiacr.azurecr.io/flaskapp:1.0