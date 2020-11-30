export DEBIAN_FRONTEND=noninteractive
echo "hostc.sh script" > hostc

sudo ip route add 192.168.100.0/30 via 192.168.30.1 dev enp0s8 #rotta per rete "Subnet D"
sudo ip route add 192.168.10.0/25 via 192.168.30.1 dev enp0s8 #rotta per rete "Subnet A"
sudo ip route add 192.168.20.0/23 via 192.168.30.1 dev enp0s8 #rotta per rete "Subnet B"

#web server configuration

apt-get update
apt-get install -y docker.io
# apt-get install  traceroute

# echo "<h1>This is the WebServer home page</h1>
# <h3>This page is hosted on host-c</h3>" > index.html
#
# echo "
# FROM nginx:latest
# MAINTAINER Davide
# ADD ./index.html /usr/share/nginx/html/index.html
# EXPOSE 80
# "> Dockerfile

# sudo docker build -t my_dncs_webserver .
# sudo docker run -d -p 80:80 my_dncs_webserver
sudo docker pull dustnic82/nginx-test
sudo docker run -d -p 80:80 dustnic82/nginx-test
