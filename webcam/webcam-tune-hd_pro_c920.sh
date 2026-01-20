#!/bin/bash
v4l2-ctl -d /dev/v4l/by-id/usb-046d_HD_Pro_Webcam_C920-video-index0 \
  --set-ctrl=brightness=177 \
  --set-ctrl=contrast=114 \
  --set-ctrl=saturation=72
