#!/bin/bash 

masterip=
keyname=/home/naagar/Downloads/pem/test1.pem
key=`cat ~/.ssh/id_rsa.pub`
sed -i "2s/.*/$masterip/" /root/kube-cluster/hosts
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
	apt -y install default-jdk
	wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
	sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
	apt update 
	apt -y install jenkins
	service jenkins restart
        cat /var/lib/jenkins/secrets/initialAdminPassword	
EOF

	echo "JENKINS SETUP DONE "$masterip":8080"
