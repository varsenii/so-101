#!/usr/bin/env bash

set -e

source common/config.sh
cd "$LEROBOT_DIR"

WRIST_CAMERA_SYMLINK="/dev/v4l/by-id/usb-Sonix_Technology_Co.__Ltd._USB2.0_CAM1_USB2.0_CAM1-video-index0"
OVERHEAD_CAMERA_SYMLINK="/dev/v4l/by-id/usb-Intel_Corporation_Luxonis_Device_18443010F12BC80F00-video-index0"

python lerobot/scripts/control_robot.py \
  --robot.type=so101 \
  --control.type=teleoperate \
  --control.fps=30 \
  --control.display_data=true


--robot.cameras='''{
    "wrist": {
      "type": "opencv",
      "camera_index": "'"$WRIST_CAMERA_SYMLINK"'",
      "fps": 30,
      "width": 640,
      "height": 480
    },
    "overhead": {
      "type": "opencv",
      "camera_index": "'"$OVERHEAD_CAMERA_SYMLINK"'",
      "fps": 60,
      "width": 640,
      "height": 480,
      "color_mode": "bgr"
    }
  }' \