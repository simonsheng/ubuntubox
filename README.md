# Ubuntu Box Settings

All settings of a new Ubuntu Box

## how to type ^M

press <Ctrl> + <V> then press <Ctrl> + <M>

## Command need to run

```
sudo apt update
sudo apt install git
sudo apt install tmux
sudo apt install wget
sudo apt install make
sudo apt install build-essential
sudo apt install zsh
sudo apt install exuberant-ctags
ctags -R --language-force=java -f.javasrctags ~/javasrc
ctags -R --language-force=java -f .javainsitectags ~/web-app/src/main/java
```
## [remount home](https://help.ubuntu.com/community/Partitioning/Home/Moving)

```
dmesg | grep SCSI
mkdir /media/home
fdisk /dev/sdc
n -> p -> w
sudo mkfs.ext4 /dev/sdc1

sudo cp /etc/fstab /etc/fstab.$(date +%Y-%m-%d)
cmp /etc/fstab /etc/fstab.$(date +%Y-%m-%d)
sudo rsync -aXS --exclude='/*/.gvfs' /home/. /media/home/.

sudo blkid
```
Add /etc/sdc1 to fstab

## [power font](https://github.com/powerline/fonts)

```
sudo apt-get install fonts-powerline
```

## [manage zsh](https://github.com/robbyrussell/oh-my-zsh)

```
command -v zsh | sudo tee -a /etc/shells
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
chsh -s $(which zsh)
```

## [Install xRDP](https://www.hiroom2.com/2018/05/07/ubuntu-1804-xrdp-lxde-en/)

```
sudo apt install -y xrdp
sudo sed -e 's/^new_cursors=true/new_cursors=false/g' \
           -i /etc/xrdp/xrdp.ini
sudo systemctl enable xrdp
sudo systemctl restart xrdp
echo "lxsession -s Lubuntu -e LXDE" > ~/.xsession
sudo cp /usr/bin/light-locker /usr/bin/light-locker.orig
cat <<EOF | sudo tee /usr/bin/light-locker
#!/bin/sh

# The light-locker uses XDG_SESSION_PATH provided by lightdm.
if [ ! -z "\${XDG_SESSION_PATH}" ]; then
  /usr/bin/light-locker.orig
else
  # Disable light-locker in XRDP.
  true
fi
EOF
sudo chmod a+x /usr/bin/light-locker
```

## [Install lxdp](https://www.hiroom2.com/2018/05/06/ubuntu-1804-lxde-en/)

```
sudo apt install -y lubuntu-desktop
```
## install chrome

```
sudo apt-get install chromium-browser
```

## golang installation

```
wget https://dl.google.com/go/go1.11.4.linux-amd64.tar.gz
sudo rm -rf /usr/lib/go
sudo rm /usr/bin/go
sudo rm /usr/bin/gofmt
sudo tar xvf go1.11.4.linux-amd64.tar.gz -C /usr/lib
sudo mv /usr/lib/go /usr/lib/go1.11
sudo update-alternatives --install /usr/bin/go go /usr/lib/go1.11/bin/go 1101
sudo update-alternatives --install /usr/bin/gofmt gofmt /usr/lib/go1.11/bin/gofmt 1101
sudo echo 'export GOPATH="$HOME/go"' >> ~/.profile
source ~/.profile
```
## compile kuberntes and use all build commands

```
go get -d k8s.io/kubernetes
cd $GOPATH/src/k8s.io/kubernetes
make
# for bash
echo '# set PATH so it includes kubernetes build commands' >> ~/.profile
echo 'if  [ -d "$HOME/go/src/k8s.io/kubernetes/_output/local/bin/linux/amd64" ] ; then' >> ~/.profile
echo '    PATH=$HOME/go/src/k8s.io/kubernetes/_output/local"/bin/linux/amd64:$PATH"' >> ~/.profile
echo 'fi' >> ~/.profile
source ~/.profile

# for zsh
echo '# set PATH so it includes kubernetes build commands' >> ~/.zshrc
echo 'if  [ -d "$HOME/go/src/k8s.io/kubernetes/_output/local/bin/linux/amd64" ] ; then' >> ~/.zshrc
echo '    PATH=$HOME/go/src/k8s.io/kubernetes/_output/local"/bin/linux/amd64:$PATH"' >> ~/.zshrc
echo 'fi' >> ~/.zshrc
sudo ln -s /home/simon/go/src/k8s.io/kubernetes/_output/local/bin/linux/amd64/kubectl /usr/local/bin/kubectl
```
## install kvm2

```
grep --color vmx /proc/cpuinfo


# Debian/Ubuntu (for older Debian/Ubuntu versions, you may have to use libvirt-bin instead of libvirt-clients and libvirt-daemon-system)
sudo apt install libvirt-clients libvirt-daemon-system qemu-kvm
# Fedora/CentOS/RHEL
sudo yum install libvirt-daemon-kvm qemu-kvm

# Add yourself to the libvirt group so you don't need to sudo
# NOTE: For older Debian/Ubuntu versions change the group to `libvirtd`
sudo usermod -a -G libvirt $(whoami)

# Update your current session for the group change to take effect
# NOTE: For older Debian/Ubuntu versions change the group to `libvirtd`
newgrp libvirt

curl -LO https://storage.googleapis.com/minikube/releases/latest/docker-machine-driver-kvm2 \
  && sudo install docker-machine-driver-kvm2 /usr/local/bin/
```

## minikube

```
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  && sudo install minikube-linux-amd64 /usr/local/bin/minikube
minikube config set vm-driver kvm2
minikube start
```
## build minikube from source code

```
sudo apt update
sudo atp install tar wget gcc git python
go get -d k8s.io/minikube
cd $GOPATH/src/k8s.io/minikube
make
```

## [install docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/)

```
sudo apt-get update

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common
    
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
   
sudo apt-get update

sudo apt-get install docker-ce

sudo usermod -aG docker $USER
sudo groupadd docker
```

## change your docker iamges location

```
sudo echo '{' >> /etc/docker/daemon.json
sudo echo '     "graph": "/home/simon/docker"' >> /etc/docker/daemon.json
sudo echo '}' >> /etc/docker/daemon.json
sudo service docker restart
```
## oracle java

- copy tar ball to the box /usr/lib
```
sudo tar xf tar-ball -C /usr/lib
```
run the script 

```
#!/bin/zsh
for file in /usr/lib/jdk1.8.0_202/bin/**/*(.);
do
         fileName=$file:t
         sudo update-alternatives --install "/usr/bin/$fileName" $fileName $file 1101;
done
```

## kubeadm kubectl kubelet
```
apt-get update && apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl
```

## install java 
```
sudo update-alternatives --install /usr/bin/jaotc jaotc /usr/lib/jvm/sapmachine-jdk-11.0.6.0.1/bin/ jaotc 1
sudo update-alternatives --install /usr/bin/jarsigner jarsigner /usr/lib/jvm/sapmachine-jdk-11.0.6.0.1/bin/jarsigner 1
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/sapmachine-jdk-11.0.6.0.1/bin/javac 1
sudo update-alternatives --install /usr/bin/javap javap /usr/lib/jvm/sapmachine-jdk-11.0.6.0.1/bin/javap 1
sudo update-alternatives --install /usr/bin/jconsole jconsole /usr/lib/jvm/sapmachine-jdk-11.0.6.0.1/bin/jconsole 1
sudo update-alternatives --install /usr/bin/jdeprscan jdeprscan /usr/lib/jvm/sapmachine-jdk-11.0.6.0.1/bin/jdeprscan 1
sudo update-alternatives --install /usr/bin/jfr jfr /usr/lib/jvm/sapmachine-jdk-11.0.6.0.1/bin/jfr 1
sudo update-alternatives --install /usr/bin/jimage jimage /usr/lib/jvm/sapmachine-jdk-11.0.6.0.1/bin/jimage 1
sudo update-alternatives --install /usr/bin/jjs jjs /usr/lib/jvm/sapmachine-jdk-11.0.6.0.1/bin/jjs 1
sudo update-alternatives --install /usr/bin/jmap jmap /usr/lib/jvm/sapmachine-jdk-11.0.6.0.1/bin/jmap 1
sudo update-alternatives --install /usr/bin/jps jps /usr/lib/jvm/sapmachine-jdk-11.0.6.0.1/bin/jps 1
sudo update-alternatives --install /usr/bin/jshell jshell /usr/lib/jvm/sapmachine-jdk-11.0.6.0.1/bin/jshell 1
sudo update-alternatives --install /usr/bin/jstat jstat /usr/lib/jvm/sapmachine-jdk-11.0.6.0.1/bin/jstat 1
sudo update-alternatives --install /usr/bin/keytool keytool /usr/lib/jvm/sapmachine-jdk-11.0.6.0.1/bin/keytool 1
sudo update-alternatives --install /usr/bin/rmic rmic /usr/lib/jvm/sapmachine-jdk-11.0.6.0.1/bin/rmic 1
sudo update-alternatives --install /usr/bin/rmiregistry rmiregistry /usr/lib/jvm/sapmachine-jdk-11.0.6.0.1/bin/rmiregistry 1
sudo update-alternatives --install /usr/bin/unpack200 unpack200 /usr/lib/jvm/sapmachine-jdk-11.0.6.0.1/bin/unpack200 1
sudo update-alternatives --install /usr/bin/jar jar /usr/lib/jvm/sapmachine-jdk-11.0.6.0.1/bin/jar 1
sudo update-alternatives --install /usr/bin/java java/usr/lib/jvm/sapmachine-jdk-11.0.6.0.1/bin/java 1
sudo update-alternatives --install /usr/bin/javadoc javadoc /usr/lib/jvm/sapmachine-jdk-11.0.6.0.1/bin/javadoc 1
sudo update-alternatives --install /usr/bin/jcmd jcmd /usr/lib/jvm/sapmachine-jdk-11.0.6.0.1/bin/jcmd 1
sudo update-alternatives --install /usr/bin/jdb jdb /usr/lib/jvm/sapmachine-jdk-11.0.6.0.1/bin/jdb 1
sudo update-alternatives --install /usr/bin/jdeps jdeps /usr/lib/jvm/sapmachine-jdk-11.0.6.0.1/bin/jdeps 1
sudo update-alternatives --install /usr/bin/jhsdb jhsdb /usr/lib/jvm/sapmachine-jdk-11.0.6.0.1/bin/jhsdb 1
sudo update-alternatives --install /usr/bin/jinfo jinfo /usr/lib/jvm/sapmachine-jdk-11.0.6.0.1/bin/jinfo 1
sudo update-alternatives --install /usr/bin/jlink jlink /usr/lib/jvm/sapmachine-jdk-11.0.6.0.1/bin/jlink 1
sudo update-alternatives --install /usr/bin/jmod jmod /usr/lib/jvm/sapmachine-jdk-11.0.6.0.1/bin/jmod 1 
sudo update-alternatives --install /usr/bin/jrunscript jrunscript /usr/lib/jvm/sapmachine-jdk-11.0.6.0.1/bin/jrunscript 1
sudo update-alternatives --install /usr/bin/jstack jstack /usr/lib/jvm/sapmachine-jdk-11.0.6.0.1/bin/jstack 1
sudo update-alternatives --install /usr/bin/jstatd jstatd /usr/lib/jvm/sapmachine-jdk-11.0.6.0.1/bin/jstatd 1
sudo update-alternatives --install /usr/bin/pack200 pack200 /usr/lib/jvm/sapmachine-jdk-11.0.6.0.1/bin/pack200 1
sudo update-alternatives --install /usr/bin/rmid rmid /usr/lib/jvm/sapmachine-jdk-11.0.6.0.1/bin/rmid 1
sudo update-alternatives --install /usr/bin/serialver serialver /usr/lib/jvm/sapmachine-jdk-11.0.6.0.1/bin/serialver 1
```
