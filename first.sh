#!/bin/bash 

masterip=13.232.147.53
nodeip=3.6.38.211
keyname=/home/sandeep/Downloads/pem/test1.pem
key=`cat ~/.ssh/id_rsa.pub`
sed -i "2s/.*/$masterip/" /root/kube-cluster/hosts
sed -i "5s/.*/$nodeip/" /root/kube-cluster/hosts
#exit 
scp -i "$keyname" ~/.ssh/id_rsa.pub ubuntu@"$masterip":/tmp/
sleep 5 
ssh -i "$keyname" ubuntu@"$masterip"   << EOF
	sleep 2
	sudo su 
	sleep 2
	cat "/tmp/id_rsa.pub" >> ~/.ssh/authorized_keys
	sleep 2
	apt update
	sleep 15
	apt -y install python 
	sleep 25
EOF

	echo "SETUP DONE FOR MASTER NODE:"$masterip""

scp -i "$keyname" ~/.ssh/id_rsa.pub ubuntu@"$nodeip":/tmp/
sleep 5
ssh -i "$keyname" ubuntu@"$nodeip" << EOF
        sleep 2
        sudo su
        sleep 2
        cat "/tmp/id_rsa.pub" >> ~/.ssh/authorized_keys
        sleep 2
        apt update
        sleep 10
        apt -y install python
        sleep 20
EOF

	echo "SETUP DONE FOR FIRST NODE:"$nodeip""

