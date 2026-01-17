#!/bin/bash
set -e

DATASET="$1"
EPISODES_TO_DELETE="$2"

if [ -z "$DATASET" ]; then
  echo "Usage: $0 <dataset_name> <episode_indices_comma_separated>"
  exit 1
fi
if [ -z "$EPISODES_TO_DELETE" ]; then
  echo "Usage: $0 <dataset_name> <episode_indices_comma_separated>"
  exit 1
fi

source common/config.sh
source common/huggingface.sh

HF_USER=$(get_huggingface_username)

lerobot-edit-dataset \
    --repo_id ${HF_USER}/${DATASET} \
    --operation.type delete_episodes \
    --operation.episode_indices "[${EPISODES_TO_DELETE}]"