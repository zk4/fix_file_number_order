#!/bin/bash

apt-get update
apt-get install gnutls-bin
echo "cn = "45.77.168.42"
organization = "GlobalSign RULTR"
serial = 1
expiration_days = 3650
ca
signing_key
cert_signing_key
crl_signing_key" > ca.txt

echo "cn = "45.77.168.42"
organization = "GlobalSign RULTR"
expiration_days = 3650
signing_key
encryption_key
tls_www_server" > server.txt


certtool --generate-privkey --outfile ca-key.pem
certtool --generate-self-signed --load-privkey ca-key.pem --template ca.txt --outfile ca-cert.pem
certtool --generate-privkey --outfile trojan-key.pem
certtool --generate-certificate --load-privkey trojan-key.pem --load-ca-certificate ca-cert.pem --load-ca-privkey ca-key.pem --template server.txt --outfile trojan-cert.pem


apt-get install trojan

cp trojan-cert.pem trojan-key.pem /etc/trojan
