#!/usr/bin/env bash
set -e

NUM_EPISODES="$1"

if [ -z "$NUM_EPISODES" ]; then
  echo "Usage: $0 <num_episodes>"
  exit 1
fi

echo "Recording $NUM_EPISODES episodes to dataset: lego_pick_and_place"

source common/config.sh
source common/huggingface.sh

HF_USER=$(get_huggingface_username)

cd "$LEROBOT_DIR"

python lerobot/scripts/control_robot.py \
  --robot.type=so101 \
  --control.type=record \
  --control.fps=30 \
  --control.single_task="Grasp a lego block and put it in the bin." \
  --control.repo_id=${HF_USER}/lego_pick_and_place \
  --control.tags='["so101"]' \
  --control.warmup_time_s=5 \
  --control.episode_time_s=30 \
  --control.reset_time_s=0 \
  --control.num_episodes=${NUM_EPISODES} \
  --control.display_data=true \
  --control.push_to_hub=false \
  --control.resume=true
