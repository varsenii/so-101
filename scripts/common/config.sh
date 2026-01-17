#!/bin/bash

LEROBOT_DIR="/mnt/ssd/robotics/so-101/lerobot"
OUTPUT_DIR="/mnt/ssd/robotics/so-101/output"

WRIST_CAMERA_SYMLINK="/dev/v4l/by-id/usb-Sonix_Technology_Co.__Ltd._USB2.0_CAM1_USB2.0_CAM1-video-index0"
OVERHEAD_CAMERA_SYMLINK="/dev/v4l/by-id/usb-Intel_Corporation_Luxonis_Device_18443010F12BC80F00-video-index0"

FOLLOWER_PORT="/dev/serial/by-id/usb-1a86_USB_Single_Serial_5AB0179034-if00"
LEADER_PORT="/dev/serial/by-id/usb-1a86_USB_Single_Serial_5AB0181889-if00"