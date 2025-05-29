cmake_minimum_required(VERSION 3.0.2)
project(cam_to_yolo)

find_package(catkin REQUIRED COMPONENTS
  rospy
  sensor_msgs
  cv_bridge
)

catkin_package()

catkin_install_python(PROGRAMS
  scripts/camera_publisher.py
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)
