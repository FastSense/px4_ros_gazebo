#!/bin/bash
xhost +

if [ "$2" == "make_firmware" ]; then
    cmd="/src/scripts/make_firmware.sh"
fi


if [ "$2" == "bash" ]; then
    cmd="/src/scripts/run_bash.sh"
fi


docker run -it --privileged \
            -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
            -v $FASTSENSE_WORKSPACE_DIR/catkin_ws:/src/catkin_ws/:rw \
            -v $FASTSENSE_WORKSPACE_DIR/Firmware:/src/firmware/:rw \
            -v ~/.ssh:/root/ssh \
            -v ~/.gazebo:/root/.gazebo/:rw \
            -e DISPLAY=$DISPLAY $1 $cmd
