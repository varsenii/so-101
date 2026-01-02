#!/usr/bin/env bash
set -e

source common/config.sh
cd "$LEROBOT_PATH"

python lerobot/scripts/control_robot.py \
  --robot.type=so101 \
  --robot.cameras='{}' \
  --control.type=calibrate \
  --control.arms='["main_follower"]'
