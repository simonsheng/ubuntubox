# Ubuntu Box Settings

All settings of a new Ubuntu Box

## Command need to run

```
sudo apt update
sudo apt install git
```

## vim configration

[Vundle vim package manager](https://github.com/VundleVim/Vundle.vim) is mour package manager

### web tools

[emmet](https://emmet.io/) has vim version which is [emmet for vim](https://github.com/mattn/emmet-vim)

```
set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'mattn/emmet-vim'


call vundle#end()            " required
filetype plugin indent on    " required
```
