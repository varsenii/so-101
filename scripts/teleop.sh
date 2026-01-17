#!/usr/bin/env bash

lerobot-teleoperate \
    --robot.type=so101_follower \
    --robot.port=/dev/serial/by-id/usb-1a86_USB_Single_Serial_5AB0179034-if00 \
    --robot.id=so101_follower \
    --teleop.type=so101_leader \
    --teleop.port=/dev/serial/by-id/usb-1a86_USB_Single_Serial_5AB0181889-if00 \
    --teleop.id=so101_leader