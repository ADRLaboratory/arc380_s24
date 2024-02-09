FROM ros:humble-ros-base

# Install additional dependencies
RUN apt-get update
RUN apt-get install -y \
    # rviz
    ros-humble-rviz2 \
    # MoveIt
    ros-humble-moveit \
    # Gazebo
    ros-humble-ros-gz \
    # Controllers
    ros-humble-joint-state-publisher \
    ros-humble-joint-state-publisher-gui \
    ros-humble-joint-trajectory-controller \
    ros-humble-controller-manager \
    # Cleanup
    && rm -rf /var/lib/apt/lists/*

# Set up noVNC display
ENV DISPLAY=novnc:0.0

# Set up workspace
ENV ARC380_WS=/root/arc380_ws
RUN mkdir -p $ARC380_WS/src
WORKDIR $ARC380_WS
RUN /bin/bash -c '. /opt/ros/humble/setup.bash; colcon build'

# Source workspace
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
