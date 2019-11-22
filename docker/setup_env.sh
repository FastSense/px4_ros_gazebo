#!/bin/bash

export catkin_dir=/src/catkin_ws
export firware_dir=/src/firmware

source /opt/ros/kinetic/setup.bash
source $catkin_dir/devel/setup.bash
source $firware_dir/Tools/setup_gazebo.bash $firware_dir $firware_dir/build/px4_sitl_default
export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:$firware_dir
export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:$firware_dir/Tools/sitl_gazebo



