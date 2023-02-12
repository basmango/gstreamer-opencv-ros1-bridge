FROM osrf/ros:noetic-desktop-full
LABEL maintainer Kyle Usbeck

# Trick to get apt-get to not prompt for timezone in tzdata
ENV DEBIAN_FRONTEND=noninteractive

ARG STARTDELAY=5
ENV STARTDELAY=$STARTDELAY

# Install gstreamer dependencies 
RUN sudo apt-get update && sudo apt-get install -y  gstreamer1.0-tools libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-good1.0-dev git python3-catkin-tools gstreamer1.0-plugins-base  gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly libgstreamer-plugins-base1.0-dev  gstreamer1.0-libav ffmpeg
RUN cd ~/ && \
	. /opt/ros/noetic/setup.sh && \
	mkdir --parents catkin_ws/src && \
	cd catkin_ws && \
	catkin init && \
	catkin build && \
	. devel/setup.sh && \
	git clone https://github.com/ros-drivers/gscam src/gscam && \
	catkin build 
	
RUN mkdir /root/code

COPY . /root/code/

