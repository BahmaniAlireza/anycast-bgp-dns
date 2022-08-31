![GitHub](https://img.shields.io/github/license/BahmaniAlireza/anycast-bgp-dns)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/BahmaniAlireza/anycast-bgp-dns)
![GitHub repo file count](https://img.shields.io/github/directory-file-count/BahmaniAlireza/anycast-bgp-dns)
![GitHub all releases](https://img.shields.io/github/downloads/BahmaniAlireza/anycast-bgp-dns/total)
![GitHub Repo stars](https://img.shields.io/github/stars/BahmaniAlireza/anycast-bgp-dns?style=social)

# Project Goal:
The purpose of creating this project is to show the capability of BGP-ANYCAST network.

# Requirments:
1- vagrant  
2- virtualbox  
3- 3 GB memory 

# Network digram:
   ![bgp any cast network digram](bgp-anycast-dns.jpg)

# How to install and run this project:

    #git clone https://github.com/BahmaniAlireza/anycast-bgp-dns.git  
    #cd anycast-bgp-dns   
    #vagrant up  

# How to test it:
As you can see in the diagram above. There are two servers called server 1 and server 2, on each of them the same IP you can ping 169.254.0.1 from each of client machine. is set, which is load balanced by BGP.
you can ping 169.254.0.1 from each client.

# Test scenario 1:
    #vagrant ssh client1
  
    vagrant@client1:~$ ping 169.254.0.1  
    PING 169.254.0.1 (169.254.0.1) 56(84) bytes of data.  
    64 bytes from 169.254.0.1: icmp_seq=1 ttl=63 time=1.46 ms  
    64 bytes from 169.254.0.1: icmp_seq=2 ttl=63 time=0.776 ms  
    64 bytes from 169.254.0.1: icmp_seq=3 ttl=63 time=1.08 ms  
  
  
    this traffic goes to server1.
  
    #vagrant halt server1
  
    after shutdown the server1, traffic goes to server2.  
  
    vagrant@client1:~$ ping 169.254.0.1  
    PING 169.254.0.1 (169.254.0.1) 56(84) bytes of data.  
    64 bytes from 169.254.0.1: icmp_seq=1 ttl=63 time=1.46 ms  
    64 bytes from 169.254.0.1: icmp_seq=2 ttl=63 time=0.776 ms  
    64 bytes from 169.254.0.1: icmp_seq=3 ttl=63 time=1.08 ms  

# Test scenario 2:

    #vagrant ssh client1

    vagrant@client1:~$dig +short example.com MX @169.254.0.1   
    25 mail.example.com.i    

    vagrant@client1:~$dig +short example.com MX @169.254.0.1
    25 mail.example.com   

    vagrant@client1:~$dig +short www.example.com @127.0.0.1
    192.0.2.1   

    this traffic goes to server1. stop server1 now and we've expected to get the same response from server2 without any changes.

    #vagrant halt server1  

    #vagrant ssh client1   

    vagrant@client1:~$dig +short example.com MX @169.254.0.1
    25 mail.example.com.i

    vagrant@client1:~$dig +short example.com MX @169.254.0.1
    25 mail.example.com

    vagrant@client1:~$dig +short www.example.com @127.0.0.1
    192.0.2.1  

    
# Test scenario 3:
Uset tcp dump on each server to see what kind of traffic comes.

    #vagrant ssh client1 

    vagrant@client1:~$watch -n 1 "dig +short example.com MX @169.254.0.1"   

    #vagrant ssh server1   
    
    vagrant@server1:~$sudo tcpdump -i enp0s8    
    12:07:49.619755 IP 192.168.60.70.43499 > 169.254.0.1.domain: 23209+ [1au] MX? example.com. (52)   
    12:07:49.620433 IP 169.254.0.1.domain > 192.168.60.70.43499: 23209*- 1/0/1 MX mail.example.com. 25 (61)    
    12:07:50.634946 IP 192.168.60.70.60355 > 169.254.0.1.domain: 18818+ [1au] MX? example.com. (52)     
    12:07:50.635468 IP 169.254.0.1.domain > 192.168.60.70.60355: 18818*- 1/0/1 MX mail.example.com. 25 (61)      
    12:07:50.820921 ARP, Request who-has 192.168.57.100 tell 192.168.57.10, length 46     
    12:07:50.820954 ARP, Reply 192.168.57.100 is-at 08:00:27:34:74:c5 (oui Unknown), length 28     
    12:07:51.654168 IP 192.168.60.70.53627 > 169.254.0.1.domain: 11417+ [1au] MX? example.com. (52)      
    12:07:51.654706 IP 169.254.0.1.domain > 192.168.60.70.53627: 11417*- 1/0/1 MX mail.example.com. 25 (61)       
    12:07:52.671363 IP 192.168.60.70.33109 > 169.254.0.1.domain: 54129+ [1au] MX? example.com. (52)         


    #vagrant ssh client2

    vagrant@client2:~$watch -n 1 "dig +short example.com MX @169.254.0.1"

    #vagrant ssh server2

    vagrant@server2:~$sudo tcpdump -i enp0s8

    11:54:14.589830 IP 192.168.61.70.38288 > 169.254.0.1.domain: 1638+ [1au] MX? example.com. (52)   
    11:54:14.590437 IP 169.254.0.1.domain > 192.168.61.70.38288: 1638*- 1/0/1 MX mail.example.com. 25 (61)    
    11:54:15.605782 IP 192.168.61.70.38062 > 169.254.0.1.domain: 18372+ [1au] MX? example.com. (52)    
    11:54:15.606746 IP 169.254.0.1.domain > 192.168.61.70.38062: 18372*- 1/0/1 MX mail.example.com. 25 (61)    
    11:54:16.624286 IP 192.168.61.70.58217 > 169.254.0.1.domain: 23329+ [1au] MX? example.com. (52)    
    11:54:16.624968 IP 169.254.0.1.domain > 192.168.61.70.58217: 23329*- 1/0/1 MX mail.example.com. 25 (61)    
    11:54:17.641321 IP 192.168.61.70.52073 > 169.254.0.1.domain: 21699+ [1au] MX? example.com. (52)    
    11:54:17.641854 IP 169.254.0.1.domain > 192.168.61.70.52073: 21699*- 1/0/1 MX mail.example.com. 25 (61)    

# Use cases:
Best use case of using BGP-ANYCAST is for stateless services such as DNS service.

