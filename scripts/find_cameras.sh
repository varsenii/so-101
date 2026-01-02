#!/usr/bin/env bash

set -e

source common/config.sh

OUTPUT_DIR="/mnt/ssd/robotics/so-101/output/camera_frames"

cd "$LEROBOT_DIR"

python lerobot/common/robot_devices/cameras/opencv.py \
    --images-dir "$OUTPUT_DIR"
