#!/usr/bin/env bash

source common/config.sh

lerobot-teleoperate \
    --robot.type=so101_follower \
    --robot.port=/dev/serial/by-id/usb-1a86_USB_Single_Serial_5AB0179034-if00 \
    --robot.id=so101_follower \
    --robot.cameras="{
        'wrist': {
            'type': 'opencv', 
            'index_or_path': '$WRIST_CAMERA_SYMLINK', 
            'width': 640, 
            'height': 480, 
            'fps': 30,
            'fourcc': 'MJPG'
        }, 
        'overhead': {
            'type': 'opencv', 
            'index_or_path': '$OVERHEAD_CAMERA_SYMLINK', 
            'width': 640, 
            'height': 480, 
            'fps': 60,
            'fourcc': 'MJPG'
        }
    }" \
    --teleop.type=so101_leader \
    --teleop.port=/dev/serial/by-id/usb-1a86_USB_Single_Serial_5AB0181889-if00 \
    --teleop.id=so101_leader \
    --display_data=true