
#!/bin/bash

##Color Code
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
BU="\e[1;4m"

if [ $(id -u) -ne 0 ]; then
    echo -e "\e[31m You should perform this as a root user\e[0m"
    exit 1
fi

Head() {
    echo -e "\n\t\t>>>>${Y}${BU}$1${N}<<<<\n"
}

Print() {
    echo -n -e "\n\t$1\t\t -- "
}

stat(){
    if [ $1 -eq 0 ]; then
        echo -e "${G}SUCCESS${N}"

    else
        echo -e "${R}FAILURE${N}"
        echo "Installation failed ::: Check log file /tmp/jinstall.log "
        exit 2
    fi
}

Head "Jenkins Setup"
Print "Install Java"
yum install java -y  &>/tmp/jinstall.log
stat $?

Print "Enable the Jenkins repository"
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo &>>/tmp/jinstall.log
stat $?

Print "Add the repository"
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key &>>/tmp/jinstall.log
stat $?

Print "Install the latest stable version of Jenkins"
sudo yum install jenkins -y &>>/tmp/jinstall.log
stat $?

Print "Enable the Jenkins service"
sudo systemctl enable jenkins &>>/tmp/jinstall.log
stat $?

Print "Start the Jenkins service"
sudo systemctl start jenkins &>>/tmp/jinstall.log
stat $?

echo -e "\e[32m Jenkins Installation Success\e[0m"



