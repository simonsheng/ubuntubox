# Ubuntu Box Settings

All settings of a new Ubuntu Box

## Command need to run

```
sudo apt update
sudo apt install git
sudo apt install tmux
sudo apt install wget
sudo apt install make
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

## vim configration

- [Vundle vim package manager](https://github.com/VundleVim/Vundle.vim) is our package manager

- Install it first by git clone 
```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

### code tools of vim

- [emmet -- html/css tool](https://emmet.io/) has vim version which is [emmet for vim](https://github.com/mattn/emmet-vim)
- [auto-pairs](https://github.com/jiangmiao/auto-pairs)

### directory tools of vim

- [nerdtree](https://github.com/scrooloose/nerdtree)

### vim itself

- [vim-airline](https://github.com/vim-airline/vim-airline)
- [vim-airline-themes](https://github.com/vim-airline/vim-airline-themes)

```
set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'mattn/emmet-vim'
Plugin 'scrooloose/nerdtree'
Plugin 'jiangmiao/auto-pairs'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

call vundle#end()            " required
filetype plugin indent on    " required

" better display 
colorscheme evening

" highlight cursor line
set cursorline
highlight CursorLine term=bold cterm=bold ctermbg=LightBlue

" set up line number
set relativenumber

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
echo '# set PATH so it includes kubernetes build commands' >> $HOME/.profile
echo 'if  -d $HOME/go/src/k8s.io/kubernetes/_output/local/bi["n/linux/amd64" ] ; then' >> $HOME/.profile
echo '    PATH=$HOME/go/src/k8s.io/kubernetes/_output/local"/bin/linux/amd64:$PATH"' >> $HOME/.profile
echo 'fi' >> $HOME/.profile
```
## install kvm2

```

```

## minikube

```
sudo apt install libvirt-clients libvirt-daemon-system qemu-kvm
sudo usermod -a -G libvirt $(whoami)
newgrp libvirt
curl -LO https://storage.googleapis.com/minikube/releases/latest/docker-machine-driver-kvm2 \
  && sudo install docker-machine-driver-kvm2 /usr/local/bin/
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
