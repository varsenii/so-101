#!/bin/bash
set -e

REPO_ID="$1"

if [ -z "$REPO_ID" ]; then
    echo "Usage: $0 <repo-id>"
    exit 1
fi

source common/config.sh
source common/huggingface.sh

HF_USER=$(get_huggingface_username)

DATASET_PATH="$HF_HOME/lerobot/${HF_USER}/${REPO_ID}"

echo "Uploading dataset:"
echo "  Local path: $DATASET_PATH"
echo "  Repo id:    ${HF_USER}/${REPO_ID}"

hf upload \
  "${HF_USER}/${REPO_ID}" \
  "$DATASET_PATH" \
  --repo-type dataset
