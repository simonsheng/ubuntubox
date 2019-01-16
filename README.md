# Ubuntu Box Settings

All settings of a new Ubuntu Box

## Command need to run

```
sudo apt update
sudo apt install git
sudo apt install tmux
```

## vim configration

[Vundle vim package manager](https://github.com/VundleVim/Vundle.vim) is our package manager

Install it first by git clone 

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

### code tools of vim

[emmet -- html/css tool](https://emmet.io/) has vim version which is [emmet for vim](https://github.com/mattn/emmet-vim)
[auto-pairs](https://github.com/jiangmiao/auto-pairs)


### directory tools of vim

[nerdtree](https://github.com/scrooloose/nerdtree)

```
set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'mattn/emmet-vim'
Plugin 'scrooloose/nerdtree'
Plugin 'jiangmiao/auto-pairs'

call vundle#end()            " required
filetype plugin indent on    " required

set relativenumber
```
