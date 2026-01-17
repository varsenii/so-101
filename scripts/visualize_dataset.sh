#!/usr/bin/env bash
set -e

DATASET="$1"
EPISODE="$2"

if [ -z "$DATASET" ]; then
  echo "Usage: $0 <dataset_name> <episode_index>"
  exit 1
fi
if ! [[ "$EPISODE" =~ ^[0-9]+$ ]]; then
    echo "Episode number must be a non-negative integer."
    exit 1
fi

echo "Visualizing episode $EPISODE of dataset $DATASET"

source common/config.sh
source common/huggingface.sh

HF_USER=$(get_huggingface_username)

lerobot-dataset-viz \
  --repo-id ${HF_USER}/${DATASET}  \
  --episode-index ${EPISODE}