#!/usr/bin/env bash

MODEL="$1"

if [ -z "$MODEL" ]; then
  echo "Usage: $0 <model>"
  exit 1
fi

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
            'fps': 30,
            'fourcc': 'MJPG',
            'warmup_s': 3
        }, 
        'overhead': {
            'type': 'opencv', 
            'index_or_path': '$OVERHEAD_CAMERA_SYMLINK', 
            'width': 640, 
            'height': 480, 
            'fps': 60,
            'fourcc': 'MJPG',
            'warmup_s': 3   
        }
    }" \
    --display_data=false \
    --dataset.repo_id=${HF_USER}/eval_lego_pick_and_place_$(date +%Y-%m-%d_%H-%M-%S)  \
    --dataset.single_task="Grasp a lego block and put it in the bin." \
    --dataset.fps=30 \
    --dataset.episode_time_s=30 \
    --dataset.reset_time_s=3 \
    --policy.path=${MODEL} \
    # --policy.pretrained_model_path=${MODEL} \
    # --policy.path=${MODEL}


