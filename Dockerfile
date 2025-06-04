FROM ros:noetic-ros-base-focal

ENV DEBIAN_FRONTEND=noninteractive

# Step 1: Install tools needed to fetch the key
RUN apt-get update && apt-get install -y curl gnupg

# Step 2: Add updated ROS GPG key (modern method)
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc -o /etc/apt/trusted.gpg.d/ros.asc

# Install dependencies
RUN apt-get update && apt-get install -y \
    python3-pip \
    python3-opencv \
    libopencv-dev \
    libv4l-dev \
    v4l-utils \
    ffmpeg \
    python3-catkin-tools \
    ros-noetic-cv-bridge \
    ros-noetic-image-transport \
    ros-noetic-sensor-msgs \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install numpy

# Create and build workspace
RUN mkdir -p /root/catkin_ws/src
WORKDIR /root/catkin_ws

# COPY your ROS package code into the image
COPY src /root/catkin_ws/src

# Initial build to make sure catkin sees it
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && catkin_make"

# Copy the entrypoint script
COPY entrypoint.sh /root/entrypoint.sh
RUN chmod +x /root/entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/root/entrypoint.sh"]
