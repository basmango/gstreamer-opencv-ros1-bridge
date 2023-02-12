FROM ros:noetic-ros-core

LABEL maintainer Kyle Usbeck

# Trick to get apt-get to not prompt for timezone in tzdata
ENV DEBIAN_FRONTEND=noninteractive

ARG STARTDELAY=5
ENV STARTDELAY=$STARTDELAY

# Install gstreamer dependencies 
RUN sudo apt-get update && sudo apt-get install -y  gstreamer1.0-tools libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-good1.0-dev git python3-catkin-tools gstreamer1.0-plugins-base  gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly libgstreamer-plugins-base1.0-dev  gstreamer1.0-libav ffmpeg

RUN sudo apt-get install -y python3 python3-pip ros-noetic-rospy ros-noetic-cv-bridge

RUN sudo apt-get install -y libcairo2-dev libjpeg-dev libgif-dev

COPY requirements.txt /
COPY opencv-gazebo.py  /

RUN pip3 install --upgrade pip setuptools wheel

RUN pip3 install -r requirements.txt

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh 


