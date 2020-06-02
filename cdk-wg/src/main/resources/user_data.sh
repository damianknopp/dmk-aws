#!/usr/bin/env bash

apt update -y
apt install net-tools -y
apt install inetutils-traceroute -y
apt install wireguard -y
apt install qrencode -y
# snap install amazon-ssm-agent

NET_FORWARD="net.ipv4.ip_forward=1"
sysctl -w  ${NET_FORWARD}
sed -i "s:#${NET_FORWARD}:${NET_FORWARD}:" /etc/sysctl.conf
echo 1 > /proc/sys/net/ipv4/ip_forward

cd /etc/wireguard
umask 077
echo "1.1.1.1" > ./dns.var
echo "eth0" > ./wan_interface_name.var

function gen_keys() {
	local name=${1:-"mobile"}
	local private_key=$(wg genkey)
	local public_key=$(echo $private_key | wg pubkey)
	echo $private_key > ./"${name}_private.key"
	echo $public_key > ./"${name}_public.key"
}

function gen_client_conf() {
	local name=${1:-"mobile"}
	local client_ip_cidr=${2}
	local server_public_ip=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
	gen_keys "${name}"
	local client_private_key=$(cat ./"${name}_private.key")
	local server_public_key=$(cat ./server_public.key)
	cat > ./wg0-"${name}".conf << EOF
[Interface]
PrivateKey = $client_private_key
Address = $client_ip_cidr
DNS = 1.1.1.1

[Peer]
PublicKey = $server_public_key
AllowedIPs = 0.0.0.0/0
Endpoint = $server_public_ip:51820
EOF
}

gen_keys "server"
gen_client_conf "mobile0" "192.168.1.100/32"
gen_client_conf "mobile1" "192.168.1.101/32"
server_private_key=$(cat ./server_private.key)
mobile0_public_key=$(cat ./mobile0_public.key)
mobile1_public_key=$(cat ./mobile1_public.key)

cat > ./wg0.conf << EOF
[Interface]
Address = 10.0.0.1/16
SaveConfig = false
PostUp = iptables -A FORWARD -i %i -j ACCEPT; iptables -t nat -A POSTROUTING -o ens5 -j MASQUERADE; iptables -A FORWARD -o %i -j ACCEPT
PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -t nat -D POSTROUTING -o ens5 -j MASQUERADE; iptables -D FORWARD -o %i -j ACCEPT
ListenPort = 51820
PrivateKey = $server_private_key

[Peer]
PublicKey = $mobile0_public_key
AllowedIPS = 192.168.1.100/32

[Peer]
PublicKey = $mobile1_public_key
AllowedIPS = 192.168.1.101/32
EOF

systemctl enable wg-quick@wg0
systemctl start wg-quick@wg0

#qrencode -t ansiutf8 < /etc/wireguard/wg0-mobile0.conf