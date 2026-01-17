#!/bin/bash
set -e

DATASET="${1:-lego_pick_and_place}"
EPISODE="${2:-0}"

if [ -z "$DATASET" ]; then
    echo "Usage: $0 <dataset_name> [episode_number]"
    exit 1
fi
if ! [[ "$EPISODE" =~ ^[0-9]+$ ]]; then
    echo "Episode number must be a non-negative integer."
    exit 1
fi
echo "Replaying episode $EPISODE from dataset: $DATASET"

source common/config.sh
source common/huggingface.sh

HF_USER=$(get_huggingface_username)

lerobot-replay \
    --robot.type=so101_follower \
    --robot.port=$FOLLOWER_PORT \
    --robot.id=so101_follower \
    --dataset.repo_id=${HF_USER}/${DATASET} \
    --dataset.episode=${EPISODE}