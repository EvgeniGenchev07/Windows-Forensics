#!/bin/bash

if [[ "$1" == "install" ]]; then
echo "Installing all libraries and tools"
sudo apt update
sudo apt install inetsim perl libnet-dns-perl libnet-server-perl -y
echo "Downloading DNS 1.37"
cpan -f -g NLNETLABS/Net-DNS-1.37.tar.gz
cpan -T -f -i NLNETLABS/Net-DNS-1.37.tar.gz

elif [[ "$1" == "start" ]]; then
echo "Choose from the following adapters:"
echo "$(ifconfig | awk '{print $1}' | grep : | tr -d ':')"
read -p "Type the name of the adapter: " adapter
read -p "Choose ip: " ip
read -p "Choose subnet: " mask
echo "Configurnig the settings"

# Remove current DHCP IP
sudo ip addr flush dev "$adapter"

# Set static IP + subnet
sudo ip addr add "$ip/$mask" dev "$adapter"

# Bring interface up
sudo ip link set "$adapter" up

# Set default gateway
sudo ip route add default via "$ip"

#Setting DSN server"
echo "nameserver $ip" | sudo tee /etc/resolv.conf > /dev/null

#Configuring DNS settings for inetsim
echo "start_service dns
start_service irc
start_service ntp
start_service finger
start_service ident
start_service syslog
start_service time_tcp
start_service time_udp
start_service daytime_tcp
start_service daytime_udp
start_service echo_tcp
start_service echo_udp
start_service discard_tcp
start_service discard_udp
start_service quotd_tcp
start_service quotd_udp
start_service chargen_tcp
start_service chargen_udp
start_service dummy_tcp
start_service dummy_udp

service_bind_address $ip
service_run_as_user inetsim
service_max_childs 15
service_timeout 120
create_reports yes
report_language en

#############################################################
# Service DNS
#############################################################

dns_bind_port 53
dns_default_ip $ip

#########################################
# dns_default_hostname
#
# Default hostname to return with DNS replies
#
# Syntax: dns_default_hostname <hostname>
#
# Default: www
#
#dns_default_hostname somehost


#########################################
# dns_default_domainname
#
# Default domain name to return with DNS replies
#
# Syntax: dns_default_domainname <domain name>
#
# Default: inetsim.org
#
#dns_default_domainname some.domain

dns_static www.foo.com 127.0.0.1
#dns_static ns1.foo.com 10.70.50.30
#dns_static ftp.bar.net 10.10.20.30

redirect_external_address 10.0.0.1
" | sudo tee /etc/inetsim/inetsim.conf > /dev/null

sudo systemctl stop dnsmasq 2> /dev/null
sudo systemctl stop systemd-resolved 2> /dev/null
#Starting inetsim
sudo service inetsim restart
elif [[ $1 == "stop" ]]; then


echo "Choose from the following adapters:"
echo "$(ifconfig | awk '{print $1}' | grep : | tr -d ':')"
read -p "Type the name of the adapter: " adapter
echo "Restoring settings"
# Stopping inetsim
sudo pkill inetsim
sudo systemctl restart systemd-resolved 2> /dev/null
sudo systemctl restart dnsmasq 2> /dev/null
# Remove static IPs
sudo ip addr flush dev "$adapter"

# Remove default route
sudo ip route flush dev "$adapter"

# Service restart
sudo service NetworkManager restart

fi
