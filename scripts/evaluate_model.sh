#!/bin/bash
set -e

MODEL="$1"

if [ -z "$MODEL" ]; then
  echo "Usage: $0 <model>"
  exit 1
fi

source common/config.sh
source common/huggingface.sh

HF_USER=$(get_huggingface_username)

cd "$LEROBOT_DIR"

python lerobot/scripts/control_robot.py \
  --robot.type=so101 \
  --control.type=record \
  --control.fps=30 \
  --control.single_task="Grasp a lego block and put it in the bin." \
  --control.repo_id=${HF_USER}/eval_lego_pick_and_place_$(date +%Y-%m-%d_%H-%M-%S) \
  --control.policy.path=${MODEL} \
  --control.display_data=true \
  --control.tags='["so101"]' \
  --control.warmup_time_s=5 \
  --control.episode_time_s=60 \
  --control.reset_time_s=10 \
  --control.num_episodes=20 \
  --control.display_data=true \
  --control.push_to_hub=false \