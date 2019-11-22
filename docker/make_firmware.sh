#!/bin/bash

firmware_dir=/src/firmware
git clone https://github.com/PX4/Firmware.git $firmware_dir
cd $firmware_dir
git submodule update --init --recursive

# HEADLESS=1 make px4_sitl_default gazebo
make px4_sitl_default gazebo