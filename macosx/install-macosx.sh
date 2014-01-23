#!/bin/bash
cd ~

for n in .bashrc .bash_profile
do
        ln -sf .rc/macosx/$n $n
done

cd - >&/dev/null
