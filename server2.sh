sudo ip address add 169.254.0.1/32 dev lo:1
sudo apt update && sudo apt install -y frr net-tools
sudo usermod -aG frr vagrant
sudo usermod -aG frrvty vagrant
sudo sed -i 's/bgpd=no/bgpd=yes/g' /etc/frr/daemons
sudo systemctl restart frr
vtysh <<END-CONFIG
conf t
router bgp 64530
neighbor 192.168.58.10 remote-as 4290001234
address-family ipv4 unicast
neighbor 192.168.58.10 activate
network 169.254.0.1/32
end
wr mem
END-CONFIG
