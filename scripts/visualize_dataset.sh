#!/usr/bin/env bash
set -e

dataset="$1"

if [ -z "$dataset" ]; then
  echo "Usage: $0 <dataset_name>"
  exit 1
fi
echo "Visualizing dataset: $dataset"

source common/config.sh
source common/huggingface.sh

cd "$LEROBOT_DIR"

HF_USER=$(get_huggingface_username)
echo "Huggingface user: $HF_USER"

python lerobot/scripts/visualize_dataset_html.py \
  --repo-id ${HF_USER}/${dataset}  \