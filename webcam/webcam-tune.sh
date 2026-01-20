#!/bin/bash
v4l2-ctl --list-devices
v4l2-ctl -d /dev/video0 \
  --set-ctrl=brightness=177 \
  --set-ctrl=contrast=114 \
  --set-ctrl=saturation=72
