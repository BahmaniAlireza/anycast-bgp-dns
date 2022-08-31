#-------------- install required packegs -----------------------------------
sudo apt update && sudo apt install -y net-tools
#-------------- add route --------------------------------------------------
sudo route add -host 169.254.0.1 gw 192.168.60.50
