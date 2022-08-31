#--------------- add anycast ip to loopback interface ----------------------
sudo ip address add 169.254.0.1/32 dev lo:1
#-------------- install required packegs -----------------------------------
sudo apt update && sudo apt install -y frr net-tools pdns-server sqlite3 pdns-backend-sqlite3 
#---------------- config powerdns ------------------------------------------
sudo sed -i 's/^launch=/launch=gsqlite3/g' /etc/powerdns/pdns.conf
sudo sed -i '/^launch=gsqlite3/a gsqlite3-database\=\/var\/lib\/powerdns\/pdns\.sqlite3' /etc/powerdns/pdns.conf
sudo mkdir -p /var/lib/powerdns
sudo sqlite3 /var/lib/powerdns/pdns.sqlite3 < /usr/share/doc/pdns-backend-sqlite3/schema.sqlite3.sql
sudo chown -R pdns:pdns /var/lib/powerdns
sudo systemctl disable systemd-resolved.service
sudo systemctl stop systemd-resolved
sudo systemctl start pdns
sudo pdnsutil create-zone example.com ns1.example.com
sudo pdnsutil add-record example.com '' MX '25 mail.example.com'
sudo pdnsutil add-record example.com. www A 192.0.2.1
#---------------- config frrouting ----------------------------------------
sudo usermod -aG frr vagrant
sudo usermod -aG frrvty vagrant
sudo sed -i 's/bgpd=no/bgpd=yes/g' /etc/frr/daemons
sudo systemctl restart frr
vtysh <<END-CONFIG
conf t
router bgp 64520
neighbor 192.168.57.10 remote-as 4290001234
address-family ipv4 unicast
neighbor 192.168.57.10 activate
network 169.254.0.1/32
end
wr mem
END-CONFIG
#---------------------------------------------------------------------------
