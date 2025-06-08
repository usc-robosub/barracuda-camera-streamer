#!/bin/bash

# Source ROS and your workspace
source /opt/ros/noetic/setup.bash
source /root/catkin_ws/devel/setup.bash

# Launch camera publisher
rosrun cam_to_yolo camera_publisher.py
