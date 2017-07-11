#/bin/bash

user=$1
password=$2

echo $user
echo $password

for ip in $(cat ip.list)
do
echo $ip
./sshkey.exp $ip $user $password | grep ssh-rsa >> ~/.ssh/authorized_keys_bak

done

cat  ~/.ssh/authorized_keys_bak | tr -s "\r\n" "\n" >>  ~/.ssh/authorized_keys

rm -f ~/.ssh/authorized_keys_bak

chmod 600  ~/.ssh/authorized_keys

for ip in $(cat ip.list)
do

./scp.exp  ~/.ssh/authorized_keys ${ip}:~/.ssh/authorized_keys $user $password
./scp.exp  ~/.ssh/known_hosts ${ip}:~/.ssh/known_hosts $user $password

done
