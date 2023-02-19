#!/bin/bash

# This script injects Vagrantfile at the next level child directory

# target_dirs=$(ls -d */)

# vagrant_template=$(cat vagrant_2c8g_template)

for dir in $(ls -d */); 
do cp vagrant_template $dir/Vagrantfile; 
done