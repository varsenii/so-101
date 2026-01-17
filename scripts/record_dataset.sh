#!/usr/bin/env bash

NUM_EPISODES="$1"

if [ -z "$NUM_EPISODES" ]; then
  echo "Usage: $0 <num_episodes>"
  exit 1
fi

echo "Recording $NUM_EPISODES episodes to dataset: lego_pick_and_place"

source common/config.sh
source common/huggingface.sh

HF_USER=$(get_huggingface_username)


lerobot-record \
    --robot.type=so101_follower \
    --robot.port=$FOLLOWER_PORT \
    --robot.id=so101_follower \
    --robot.cameras="{
        'wrist': {
            'type': 'opencv', 
            'index_or_path': '$WRIST_CAMERA_SYMLINK', 
            'width': 640, 
            'height': 480, 
            'fps': 30
        }, 
        'overhead': {
            'type': 'opencv', 
            'index_or_path': '$OVERHEAD_CAMERA_SYMLINK', 
            'width': 640, 
            'height': 480, 
            'fps': 60
        }
    }" \
    --teleop.type=so101_leader \
    --teleop.port=$LEADER_PORT \
    --teleop.id=so101_leader \
    --display_data=true \
    --dataset.repo_id=${HF_USER}/lego_pick_and_place \
    --dataset.num_episodes=${NUM_EPISODES} \
    --dataset.single_task="Grasp a lego block and put it in the bin." \
    --dataset.fps=30 \
    --dataset.episode_time_s=30 \
    --dataset.reset_time_s=10 \
    --dataset.push_to_hub=false \
    --resume=true
