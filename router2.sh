sudo apt update && sudo apt install -y frr net-tools
sudo usermod -aG frr vagrant
sudo usermod -aG frrvty vagrant
sudo sed -i 's/bgpd=no/bgpd=yes/g' /etc/frr/daemons
sudo systemctl restart frr
vtysh <<END-CONFIG
conf t
router bgp 4290001234
neighbor 192.168.58.100 remote-as 64530
neighbor 192.168.59.30 remote-as 4290001234
address-family ipv4 unicast
neighbor 192.168.58.100 activate
neighbor 192.168.59.30 activate
network 192.168.58.0/24
network 192.168.59.0/24
network 192.168.61.0/24
end
wr mem
END-CONFIG
echo 1 > /proc/sys/net/ipv4/ip_forward
