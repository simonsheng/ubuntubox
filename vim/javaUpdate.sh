#!/bin/bash
for file in /usr/lib/jvm/jdk1.8.0_211/bin/*
do
  sudo update-alternatives --install /usr/bin/${file##*/} ${file##*/} $file 1101
done
