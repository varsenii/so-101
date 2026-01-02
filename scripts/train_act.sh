#!/bin/bash
set -e

DATASET="$1"

if [ -z "$DATASET" ]; then
  echo "Usage: $0 <dataset>"
  exit 1
fi

source common/config.sh
source common/huggingface.sh

HF_USER=$(get_huggingface_username)

cd "$LEROBOT_DIR"
python lerobot/scripts/train.py \
  --dataset.repo_id=${HF_USER}/${DATASET} \
  --policy.type=act \
  --output_dir=${OUTPUT_DIR}/train/act_${DATASET}_test \
  --job_name=act_${DATASET} \
  --policy.device=cuda \
  --wandb.enable=true \
  --batch_size=32
  --steps=4870 \
  --log_freq=4 \
  --save_freq=4870 \
  --eval_freq=4870 \
  # --config_path=outputs/train/act_so101_test/checkpoints/last/pretrained_model/train_config.json \
  # --resume=true