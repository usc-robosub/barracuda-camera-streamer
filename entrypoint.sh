#!/bin/bash
set -e

# Set ROS networking to connect to the external master
export ROS_MASTER_URI=http://barracuda-description:11311
export ROS_HOSTNAME=$(hostname -I | awk '{print $1}')

# Source ROS and your workspace
source /opt/ros/noetic/setup.bash
source /root/catkin_ws/devel/setup.bash

# Launch camera publisher
rosrun cam_to_yolo camera_publisher.py
